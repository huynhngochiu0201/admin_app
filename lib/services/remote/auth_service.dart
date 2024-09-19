import 'package:admin_app/models/login_request.dart';
import 'package:admin_app/models/user_model.dart';
import 'package:admin_app/services/local/define_collection.dart';
import 'package:admin_app/services/local/sevice_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  Future<SignupResult> createStaff(UserModel userModel) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.email ?? '',
        password: userModel.password ?? '',
      );
      String uid = userCredential.user!.uid;
      String imagePath =
          '${AppDefineCollection.APP_USER_AVATAR}/$uid/user_avatar';

      final Reference ref = storage.ref().child(imagePath);
      final UploadTask uploadTask = ref.putBlob(userModel.avatar!);
      final TaskSnapshot downloadUrl = await uploadTask;
      final String imageUrl = await downloadUrl.ref.getDownloadURL();

      final usermodel = UserModel(
          id: uid,
          email: userModel.email,
          password: userModel.password,
          avatar: imageUrl,
          name: userModel.name);
      await FirebaseFirestore.instance
          .collection(AppDefineCollection.APP_ACCOUNT)
          .doc(uid)
          .set(usermodel.toJson());
      return SignupResult.success;
    } catch (e) {
      print("Error creating staff: $e");
      return SignupResult.emailAlreadyExists;
    }
  }

  Future<void> deleteStaff(UserModel userModel) async {
    try {
      if (userModel.avatar != null) {
        String imagePath =
            '${AppDefineCollection.APP_USER_AVATAR}/${userModel.id}/user_avatar';
        final Reference ref = storage.ref().child(imagePath);
        await ref.delete();
      }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userModel.email!,
        password: userModel.password!,
      );
      await FirebaseAuth.instance.currentUser!.delete();
      await _firestore
          .collection(AppDefineCollection.APP_ACCOUNT)
          .doc(userModel.id)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  Future<bool?> checkRole(String email) async {
    try {
      final querySnapshot = await _firestore
          .collection(AppDefineCollection.APP_ACCOUNT)
          .where('email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final role = querySnapshot.docs.first;
        if (role['role'] == 'admin') {
          return true;
        } else if (role['role'] == 'staff') {
          return false;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error checking role: $e');
    }
  }

  Future<SigninResult> signInWithEmail(LoginRequest loginRequest) async {
    try {
      final check = await checkRole(loginRequest.email);
      if (check == true) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginRequest.email,
          password: loginRequest.password,
        );
        return SigninResult.successIsAdmin;
      } else if (check == false) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: loginRequest.email,
          password: loginRequest.password,
        );
        return SigninResult.successIsStaff;
      } else {
        return SigninResult.failure;
      }
    } catch (e) {
      return SigninResult.failure;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> updatePassword(String newPassword) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'Không tìm thấy người dùng. Vui lòng đăng nhập lại.',
        );
      }
      await currentUser.updatePassword(newPassword);
      _firestore
          .collection(AppDefineCollection.APP_ACCOUNT)
          .doc(currentUser.uid)
          .update({'password': newPassword});
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<UserModel>> getCustomer() async {
    try {
      final queryData = await _firestore
          .collection(AppDefineCollection.APP_ACCOUNT)
          .where('role', isEqualTo: 'customer')
          .get();
      var userData =
          queryData.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      return userData;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getStaff() async {
    try {
      final queryData = await _firestore
          .collection(AppDefineCollection.APP_ACCOUNT)
          .where('role', isEqualTo: 'staff')
          .get();
      var userData =
          queryData.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      return userData;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateStaff(UserModel userModel, String oldPassword) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userModel.email!,
        password: oldPassword,
      );
      userCredential.user!.updatePassword(userModel.password!);
      if (userModel.avatar != null) {
        String imagePath =
            '${AppDefineCollection.APP_USER_AVATAR}/${userModel.id}/user_avatar';
        final Reference ref = storage.ref().child(imagePath);
        final UploadTask uploadTask = ref.putBlob(userModel.avatar!);
        final TaskSnapshot downloadUrl = await uploadTask;
        final String imageUrl = await downloadUrl.ref.getDownloadURL();
        await _firestore
            .collection(AppDefineCollection.APP_ACCOUNT)
            .doc(userModel.id)
            .update({...userModel.toJson(), 'avatar': imageUrl});
        return;
      }
      await _firestore
          .collection(AppDefineCollection.APP_ACCOUNT)
          .doc(userModel.id)
          .update({
        'name': userModel.name,
        'password': userModel.password,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<SignupResult> addUser(UserModel userModel, String role) async {
    try {
      // Tạo tài khoản người dùng với email và password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userModel.email ?? '',
        password: userModel.password ?? '',
      );
      String uid = userCredential.user!.uid;

      // Đường dẫn lưu trữ ảnh đại diện của người dùng
      String imagePath =
          '${AppDefineCollection.APP_USER_AVATAR}/$uid/user_avatar';

      // Upload ảnh đại diện nếu có
      String? imageUrl;
      if (userModel.avatar != null) {
        final Reference ref = storage.ref().child(imagePath);
        final UploadTask uploadTask = ref.putBlob(userModel.avatar!);
        final TaskSnapshot downloadUrl = await uploadTask;
        imageUrl = await downloadUrl.ref.getDownloadURL();
      }

      // Cập nhật thông tin người dùng với vai trò
      final newUser = UserModel(
        id: uid,
        email: userModel.email,
        password: userModel.password,
        avatar: imageUrl,
        name: userModel.name,
        role: role, // Thêm vai trò người dùng
      );

      // Lưu người dùng vào Firestore
      await _firestore
          .collection(AppDefineCollection.APP_ACCOUNT)
          .doc(uid)
          .set(newUser.toJson());

      return SignupResult.success;
    } catch (e) {
      print("Error adding user: $e");
      return SignupResult.emailAlreadyExists;
    }
  }
}
