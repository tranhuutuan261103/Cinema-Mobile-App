import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/providers/auth_provider.dart';

import '../../../common/constants/colors.dart';
import '../../../common/models/account.dart';
import '../../../common/services/account_service.dart';
import '../../../common/widgets/text_field_custom.dart';
import '../../../common/widgets/modals/message_modal.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).user;

    if (user != null) {
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      emailController.text = user.email;
      phoneController.text = user.phoneNumber ?? "";
      addressController.text = user.address ?? "";
    }
  }

  Future<void> _updateUserInfo() async {
    setState(() {
      isLoading = true;
    });

    final user = Provider.of<AuthProvider>(context, listen: false).user;

    if (user != null) {
      Account updatedUser = Account(
        username: user.username,
        email: emailController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneController.text,
        address: addressController.text,
        avatarUrl: user.avatarUrl,
      );

      try {
        Account result = await AccountService().updateProfile(
            Provider.of<AuthProvider>(context, listen: false).token,
            updatedUser);
        Provider.of<AuthProvider>(context, listen: false).setUser(result);
        showModelDialog("Cập nhật thông tin thành công");
      } catch (e) {
        showModelDialog("Cập nhật thông tin thất bại");
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text('Chỉnh sửa thông tin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              TextFieldCustom(
                  controller: firstNameController,
                  label: "Tên",
                  icon: Icons.person),
              const SizedBox(height: 16),
              TextFieldCustom(
                  controller: lastNameController,
                  label: "Họ",
                  icon: Icons.person),
              const SizedBox(height: 16),
              TextFieldCustom(
                controller: emailController,
                label: "Email",
                icon: Icons.email,
              ),
              const SizedBox(height: 16),
              TextFieldCustom(
                  controller: phoneController,
                  label: "Số điện thoại",
                  icon: Icons.person),
              const SizedBox(height: 16),
              TextFieldCustom(
                controller: addressController,
                label: "Địa chỉ",
                icon: Icons.email,
              ),
              const SizedBox(height: 16),
              MaterialButton(
                onPressed: _updateUserInfo,
                color: colorPrimary,
                textColor: Colors.white,
                child: isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text("Cập nhật"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showModelDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return MessageModal(
          message: message,
          title: "Thông báo",
        );
      },
    );
  }
}
