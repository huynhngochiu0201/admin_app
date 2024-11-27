import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/pages/service/widget/add_wheel_size.dart';
import 'package:admin_app/services/remote/wheel_size_service.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

import '../../../models/wheel_size_model.dart';

class WheelSizePage extends StatefulWidget {
  const WheelSizePage({super.key});

  @override
  State<WheelSizePage> createState() => _WheelSizePageState();
}

class _WheelSizePageState extends State<WheelSizePage> {
  List<WheelSizeModel> _wheelSizes = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchWheelSizes();
  }

  Future<void> _fetchWheelSizes() async {
    try {
      WheelSizeService wheelSizeService = WheelSizeService();
      List<WheelSizeModel> wheelSizes =
          await wheelSizeService.fetchAllWheelSizesByCreateAt();
      setState(() {
        _wheelSizes = wheelSizes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshWheelSizes() async {
    await _fetchWheelSizes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wheel Size'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshWheelSizes,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 20.0),
          child: Column(
            children: [
              CrElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                        builder: (context) => const AddWheelSize()),
                  )
                      .then((value) {
                    _fetchWheelSizes();
                  });
                },
                text: 'Add Wheel Size',
                color: Colors.blue,
                borderColor: Colors.white,
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage != null
                        ? Center(child: Text('Error: $_errorMessage'))
                        : _wheelSizes.isEmpty
                            ? const Center(
                                child: Text('No wheel sizes available'))
                            : DynamicHeightGridView(
                                builder: (context, index) {
                                  WheelSizeModel wheelSize = _wheelSizes[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.8),
                                            spreadRadius: 0,
                                            blurRadius: 3,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            wheelSize.name ?? 'Unnamed',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 20.0),
                                          Text(
                                            '${wheelSize.price} \$',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: _wheelSizes.length,
                                crossAxisCount: 1,
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
