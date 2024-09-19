import 'package:admin_app/services/local/sevice_status.dart';
import 'package:admin_app/services/remote/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/models/user_model.dart';

//import 'package:file_picker/file_picker.dart' as file_picker;

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  AddUserPageState createState() => AddUserPageState();
}

class AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  String? _email;
  String? _password;
  String? _name;
  String? _role;
  //file_picker.PlatformFile? _avatar;

  bool _isLoading = false;

  // Future<void> _pickAvatar() async {
  //   file_picker.FilePickerResult? result =
  //       await file_picker.FilePicker.platform.pickFiles(
  //     type: file_picker.FileType.image,
  //   );

  //   if (result != null) {
  //     setState(() {
  //       _avatar = result.files.first;
  //     });
  //   }
  // }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      // Tạo mô hình người dùng
      UserModel newUser = UserModel(
        email: _email,
        password: _password,
        name: _name,
        // avatar: _avatar?.bytes, // Đọc dữ liệu ảnh
      );

      // Gọi phương thức addUser
      final result = await _authService.addUser(newUser, _role ?? 'staff');

      setState(() {
        _isLoading = false;
      });

      // Kiểm tra kết quả
      if (result == SignupResult.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thêm người dùng thành công!')),
        );
        Navigator.of(context).pop(); // Quay về trang trước đó
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lỗi khi thêm người dùng!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm người dùng mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập email';
                  }
                  // Basic email validation
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Vui lòng nhập email hợp lệ';
                  }
                  return null;
                },
                onSaved: (value) => _email = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mật khẩu'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mật khẩu';
                  }
                  if (value.length < 6) {
                    return 'Mật khẩu phải ít nhất 6 ký tự';
                  }
                  return null;
                },
                onSaved: (value) => _password = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tên'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên';
                  }
                  return null;
                },
                onSaved: (value) => _name = value,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Vai trò'),
                items: ['admin', 'staff', 'customer']
                    .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(role),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _role = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng chọn vai trò';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: _pickAvatar,
              //   child: const Text('Chọn ảnh đại diện'),
              // ),
              // if (_avatar != null)
              //   Padding(
              //     padding: const EdgeInsets.only(top: 8.0),
              //     child: Text('Đã chọn: ${_avatar!.name}'),
              //   ),
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Thêm người dùng'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
