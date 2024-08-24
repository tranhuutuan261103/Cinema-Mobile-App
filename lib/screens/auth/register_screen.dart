import 'package:cinema_mobile_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';
import '../../widgets/text_field_custom.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    FocusScope.of(context).unfocus();

    await Provider.of<AuthProvider>(context, listen: false).register(
      _firstNameController.text,
      _lastNameController.text,
      _usernameController.text,
      _phoneController.text,
      _emailController.text,
      _passwordController.text,
    );

    // Check if the widget is still mounted before using the context
    if (!mounted) return;

    if (Provider.of<AuthProvider>(context, listen: false).isAuthenticated) {
      Navigator.of(context).pop();
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFieldCustom(
                          label: 'Họ',
                          icon: Icons.person,
                          controller: _lastNameController,
                        ),
                        const SizedBox(height: 16.0),
                        TextFieldCustom(
                          label: 'Tên',
                          icon: Icons.person,
                          controller: _firstNameController,
                        ),
                        const SizedBox(height: 16.0),
                        TextFieldCustom(
                          label: 'Username',
                          icon: Icons.person,
                          controller: _usernameController,
                        ),
                        const SizedBox(height: 16.0),
                        TextFieldCustom(
                          label: 'Email',
                          icon: Icons.email,
                          controller: _emailController,
                        ),
                        const SizedBox(height: 16.0),
                        TextFieldCustom(
                          label: 'Số điện thoại',
                          icon: Icons.phone,
                          controller: _phoneController,
                        ),
                        const SizedBox(height: 16.0),
                        TextFieldCustom(
                          label: 'Mật khẩu',
                          icon: Icons.lock,
                          controller: _passwordController,
                          isObscure: true,
                        ),
                        const SizedBox(height: 16.0),
                        TextFieldCustom(
                          label: 'Nhập lại mật khẩu',
                          icon: Icons.lock,
                          controller: _confirmPasswordController,
                          isObscure: true,
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: _register,
                            color: colorPrimary,
                            textColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: const Text('Đăng ký'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Tôi đã có tài khoản. '),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text('Đăng nhập',
                          style: TextStyle(color: colorPrimary)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_isLoading)
            Positioned.fill(
              child: Stack(
                children: [
                  ModalBarrier(
                      dismissible: false, color: Colors.black.withOpacity(0.5)),
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
