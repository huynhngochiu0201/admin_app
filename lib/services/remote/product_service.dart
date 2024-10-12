import 'package:admin_app/models/add_product_model.dart';
import 'package:admin_app/models/category_model.dart';
import 'package:admin_app/models/product_model.dart';
import 'package:admin_app/models/update_product_model.dart';
import 'package:admin_app/services/local/define_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<void> updateProduct(UpdateProductModel product) async {
    try {
      String imageId = product.productId!;
      String imageStoragePath =
          '/${AppDefineCollection.APP_PRODUCT}/${product.cateId}/$imageId';

      final Map<String, dynamic> productData = product.toJson();

      if (product.image != null) {
        final Reference ref = _storage.ref().child(imageStoragePath);
        final UploadTask uploadTask = ref.putData(product.image!);
        final TaskSnapshot taskSnapshot = await uploadTask;
        final String imageUrl = await taskSnapshot.ref.getDownloadURL();
        productData['image'] = imageUrl;
      }

      await _firestore
          .collection(AppDefineCollection.APP_PRODUCT)
          .doc(product.productId)
          .update(productData);
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  Future<void> addNewProduct(AddProductModel product) async {
    try {
      String docId =
          _firestore.collection(AppDefineCollection.APP_PRODUCT).doc().id;
      String imageStoragePath =
          '/${AppDefineCollection.APP_PRODUCT}/${product.cateId}/$docId';

      String imageUrl = '';
      if (product.image != null) {
        final Reference ref = _storage.ref().child(imageStoragePath);
        final UploadTask uploadTask = ref.putData(product.image!);
        final TaskSnapshot downloadUrl = await uploadTask;
        imageUrl = await downloadUrl.ref.getDownloadURL();
      }

      await _firestore
          .collection(AppDefineCollection.APP_PRODUCT)
          .doc(docId)
          .set(ProductModel(
            id: docId,
            categoryId: product.cateId,
            name: product.productName,
            image: imageUrl,
            price: product.price,
            description: product.description,
            viewCount: 0,
            orderCount: 0,
            favourute: 0,
            quantity: product.quantity,
            createAt: Timestamp.now(),
          ).toJson());
    } catch (e) {
      throw Exception('Error adding new product: $e');
    }
  }

  Future<List<ProductModel>> fetchAllProductsByCreateAt() async {
    try {
      final querySnapshot = await _firestore
          .collection(AppDefineCollection.APP_PRODUCT)
          .orderBy('createAt', descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error fetching products by category: $e');
    }
  }

  Future<List<ProductModel>> fetchNewProducts() async {
    try {
      final querySnapshot = await _firestore
          .collection(AppDefineCollection.APP_PRODUCT)
          .orderBy('createAt', descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error fetching new products: $e');
    }
  }

  Future<List<ProductModel>> searchProducts(String searchText) async {
    String searchTermLower = searchText.toLowerCase();

    List<ProductModel> matchedProducts = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(AppDefineCollection.APP_PRODUCT)
          .get();
      for (var doc in querySnapshot.docs) {
        String nameLower = doc['name'].toLowerCase();
        if (nameLower.contains(searchTermLower)) {
          matchedProducts
              .add(ProductModel.fromJson(doc.data() as Map<String, dynamic>));
        }
      }
      return matchedProducts;
    } catch (e) {
      throw Exception('Error searching products: $e');
    }
  }

  Future<void> deleteProductByIdCate(String idCate) async {
    try {
      final querySnapshot = await _firestore
          .collection(AppDefineCollection.APP_PRODUCT)
          .where('categoryId', isEqualTo: idCate)
          .get();
      for (var doc in querySnapshot.docs) {
        await _firestore
            .collection(AppDefineCollection.APP_PRODUCT)
            .doc(doc.id)
            .delete();
      }
    } catch (e) {
      throw Exception('Error deleting products by category: $e');
    }
  }

  // Phương thức xóa sản phẩm theo ID
  Future<void> deleteProductById(String productId) async {
    try {
      // Xóa sản phẩm từ Firestore
      await _firestore
          .collection(AppDefineCollection.APP_PRODUCT)
          .doc(productId)
          .delete();

      // Xóa ảnh sản phẩm từ Firebase Storage
      String imageStoragePath =
          '/${AppDefineCollection.APP_PRODUCT}/$productId';
      final Reference ref = _storage.ref().child(imageStoragePath);
      await ref.delete();
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final snapshot = await _firestore.collection('categories').get();
      return snapshot.docs.map((doc) => doc['name'] as CategoryModel).toList();
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}
