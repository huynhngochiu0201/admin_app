import 'dart:typed_data';
import 'package:admin_app/models/service_model.dart';
import 'package:admin_app/services/local/define_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class ServiceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload image to Firebase Storage
  Future<String> uploadImageToStorage(Uint8List file) async {
    String fileName = const Uuid().v4(); // Generate a unique file name
    Reference ref = _storage.ref().child('services/$fileName');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // Fetch all services from Firebase Firestore
  Future<List<ServiceModel>> fetchAllServicesByCreateAt() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection(AppDefineCollection.APP_SERVICE)
          .orderBy('createAt', descending: true) // Fetch by creation date
          .get();

      return snapshot.docs.map((doc) {
        return ServiceModel.fromJson(doc.data() as Map<String, dynamic>)
          ..id = doc.id; // Add the document ID
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch services: $e');
    }
  }

  // Add new service to Firebase Firestore
  Future<void> addService({
    required String name,
    required String description,
    required double price,
    required Uint8List? imageFile,
  }) async {
    try {
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await uploadImageToStorage(imageFile);
      }

      String serviceId = const Uuid().v4(); // Generate a unique ID
      ServiceModel newService = ServiceModel(
        id: serviceId,
        name: name,
        price: price,
        description: description,
        image: imageUrl,
        createAt: Timestamp.now(),
      );

      await _firestore
          .collection(AppDefineCollection.APP_SERVICE)
          .doc(serviceId)
          .set(newService.toJson());

      print('Service added successfully!');
    } catch (e) {
      print('Failed to add service: $e');
    }
  }

  // Delete service by ID
  Future<void> deleteServiceById(String serviceId) async {
    try {
      await _firestore
          .collection(AppDefineCollection.APP_SERVICE)
          .doc(serviceId)
          .delete();
      print('Service deleted successfully!');
    } catch (e) {
      print('Failed to delete service: $e');
    }
  }

  Future<void> updateServiceById(
      String id, String name, double price, String description) async {
    // Implement your Firestore update logic here
    // Example:
    await FirebaseFirestore.instance.collection('services').doc(id).update({
      'name': name,
      'price': price,
      'description': description,
    });
  }
}
