// import 'dart:typed_data';
// import 'package:admin_app/models/service_model.dart';
// import 'package:admin_app/services/local/define_collection.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:uuid/uuid.dart';

// class ServiceService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   // Upload image to Firebase Storage
//   Future<String> uploadImageToStorage(Uint8List file) async {
//     // Generate a unique file name using Uuid
//     String fileName = const Uuid().v4();

//     // Reference to the Firebase Storage location
//     Reference ref = _storage.ref().child('services/$fileName');

//     // Upload the file
//     UploadTask uploadTask = ref.putData(file);

//     // Wait for the upload to complete
//     TaskSnapshot snapshot = await uploadTask;

//     // Get the URL of the uploaded file
//     String downloadUrl = await snapshot.ref.getDownloadURL();

//     return downloadUrl;
//   }

//   // Add new service to Firebase Firestore
//   Future<void> addService({
//     required String name,
//     required String description, // Make sure this is required
//     required double price,
//     required Uint8List? imageFile,
//   }) async {
//     try {
//       // Step 1: Upload the image to Firebase Storage
//       String? imageUrl;
//       if (imageFile != null) {
//         imageUrl = await uploadImageToStorage(imageFile);
//       }

//       // Step 2: Prepare the service data
//       String serviceId =
//           const Uuid().v4(); // Generate unique ID for the service
//       ServiceModel newService = ServiceModel(
//         id: serviceId,
//         name: name,
//         price: price,
//         description: description, // Pass the description here
//         image: imageUrl,
//         createAt: Timestamp.now(),
//       );

//       // Step 3: Save service data to Firestore
//       await _firestore
//           .collection(AppDefineCollection.APP_SERVICE)
//           .doc(serviceId)
//           .set(newService.toJson());

//       print('Service added successfully!');
//     } catch (e) {
//       print('Failed to add service: $e');
//     }
//   }
// }

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

  // Add new service to Firebase Firestore
  Future<void> addService({
    required String name,
    required String description, // Add description here
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
        description: description, // Set description here
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
}
