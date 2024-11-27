import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/pages/service/widget/add_payload.dart';
import 'package:admin_app/services/remote/payload_service.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

import '../../../models/payload_model.dart';

class PayloadPage extends StatefulWidget {
  const PayloadPage({super.key});

  @override
  State<PayloadPage> createState() => _PayloadPageState();
}

class _PayloadPageState extends State<PayloadPage> {
  List<PayloadModel> _payloads = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchServices();
  }

  Future<void> _fetchServices() async {
    try {
      PayloadService payloadService = PayloadService();
      List<PayloadModel> payloads =
          await payloadService.fetchAllPayloadsByCreateAt();
      setState(() {
        _payloads = payloads;
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
    await _fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payload'),
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
                    MaterialPageRoute(builder: (context) => const AddPayload()),
                  )
                      .then((value) {
                    _fetchServices();
                  });
                },
                text: 'Add Service',
                color: Colors.blue,
                borderColor: Colors.white,
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage != null
                        ? Center(child: Text('Error: $_errorMessage'))
                        : _payloads.isEmpty
                            ? const Center(child: Text('No payloads available'))
                            : DynamicHeightGridView(
                                builder: (context, index) {
                                  PayloadModel payload = _payloads[index];
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
                                            payload.name ?? 'Unnamed',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 20.0),
                                          Text(
                                            '${payload.price} \$',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: _payloads.length,
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
