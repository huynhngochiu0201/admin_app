import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/pages/service/widget/add_area.dart';
import 'package:admin_app/services/remote/area_service.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import '../../../models/area_model.dart';

class AreaPage extends StatefulWidget {
  const AreaPage({super.key});

  @override
  State<AreaPage> createState() => _AreaPageState();
}

class _AreaPageState extends State<AreaPage> {
  List<AreaModel> _areas = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchAreas();
  }

  Future<void> _fetchAreas() async {
    try {
      AreaService areaService = AreaService();
      List<AreaModel> areas = await areaService.fetchAllAreasByCreateAt();
      setState(() {
        _areas = areas;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshServices() async {
    await _fetchAreas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Area'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshServices,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 20.0),
          child: Column(
            children: [
              CrElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(builder: (context) => const AddArea()),
                  )
                      .then((value) {
                    _fetchAreas();
                  });
                },
                text: 'Add Area',
                color: Colors.blue,
                borderColor: Colors.white,
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage != null
                        ? Center(child: Text('Error: $_errorMessage'))
                        : _areas.isEmpty
                            ? const Center(child: Text('No services available'))
                            : DynamicHeightGridView(
                                builder: (context, index) {
                                  AreaModel area =
                                      _areas[index]; // Use AreaModel
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
                                            area.name ?? 'Unnamed',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 20.0),
                                          Text(
                                            '${area.price} \$',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: _areas.length,
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
