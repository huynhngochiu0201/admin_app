import 'package:admin_app/components/app_bar/custom_app_bar.dart';
import 'package:admin_app/models/service_model.dart';
import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/constants/app_color.dart';
import 'package:admin_app/pages/service/widget/add_service.dart';
import 'package:admin_app/services/remote/service.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  List<ServiceModel> _services = []; // Change to ServiceModel
  bool _isLoading = true;
  String? _errorMessage;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _fetchServices(); // Update method name
  }

  Future<void> _fetchServices() async {
    // Update method name
    try {
      ServiceService serviceService = ServiceService();
      List<ServiceModel> services = await serviceService
          .fetchAllServicesByCreateAt(); // Use ServiceService
      setState(() {
        _services = services;
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
    // Update method name
    await _fetchServices(); // Call the fetchServices method to refresh the list
  }

  // Future<void> _deleteService(ServiceModel service) async {
  //   // Update method to delete service
  //   try {
  //     ServiceService serviceService = ServiceService();
  //     await serviceService
  //         .deleteServiceById(service.id); // Assuming this method exists
  //     _fetchServices(); // Refresh the list after deletion
  //   } catch (e) {
  //     print('Error deleting service: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Service'),
      body: RefreshIndicator(
        onRefresh: _refreshServices, // Function to call when pulling to refresh
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 20.0),
          child: Column(
            children: [
              CrElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(builder: (context) => const AddService()),
                  )
                      .then((value) {
                    // After adding a new service, fetch the services again
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
                        : _services.isEmpty
                            ? const Center(child: Text('No services available'))
                            : DynamicHeightGridView(
                                builder: (context, index) {
                                  ServiceModel service =
                                      _services[index]; // Use ServiceModel
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
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                    horizontal: 10.0)
                                                .copyWith(top: 10),
                                            child: Container(
                                              height: 200,
                                              width: size.width,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  service.image ??
                                                      '', // Update to use service image
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      const Icon(Icons
                                                          .error), // Handle image errors
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    service.name ??
                                                        'Unnamed', // Update to use service name
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 20.0),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: isExpanded ||
                                                              service.description!
                                                                      .length <=
                                                                  200
                                                          ? service.description
                                                          : service.description
                                                              ?.substring(
                                                                  0, 200),
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20),
                                                      children: [
                                                        if (!isExpanded &&
                                                            (service.description
                                                                        ?.length ??
                                                                    0) >
                                                                200)
                                                          TextSpan(
                                                            text:
                                                                '... Read more',
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    setState(
                                                                        () {
                                                                      isExpanded =
                                                                          true;
                                                                    });
                                                                  },
                                                          ),
                                                        if (isExpanded &&
                                                            (service.description
                                                                        ?.length ??
                                                                    0) >
                                                                200)
                                                          TextSpan(
                                                            text: ' Show less',
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    setState(
                                                                        () {
                                                                      isExpanded =
                                                                          false;
                                                                    });
                                                                  },
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 40.0,
                                                width: 80.0,
                                                decoration: BoxDecoration(
                                                  color: AppColor.blue,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.8),
                                                      spreadRadius: 0,
                                                      blurRadius: 3,
                                                      offset:
                                                          const Offset(0, 2),
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '${service.price} \$', // Update to use service price
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: _services.length, // Update itemCount
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
