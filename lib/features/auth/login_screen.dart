import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../common/providers/auth_provider.dart';

import '../../common/constants/colors.dart';
import '../../common/models/account.dart';
import '../../common/services/account_service.dart';
import '../../common/widgets/text_field_custom.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    FocusScope.of(context).unfocus();

    await Provider.of<AuthProvider>(context, listen: false).login(
      _emailController.text,
      _passwordController.text,
    );

    // Check if the widget is still mounted before using the context
  if (!mounted) return;

    if (Provider.of<AuthProvider>(context, listen: false).isAuthenticated) {
      String token = Provider.of<AuthProvider>(context, listen: false).getToken;
      Account user = await AccountService().getProfile(token);
      Provider.of<AuthProvider>(context, listen: false).setUser(user);

      Navigator.of(context).pop();
    }

    setState(() {
      _isLoading = false;
    });
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
          // Main content of the screen
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Đăng nhập tài khoản'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFieldCustom(
                        controller: _emailController,
                        label: "Email",
                        icon: Icons.email),
                    const SizedBox(height: 16.0),
                    TextFieldCustom(
                      controller: _passwordController,
                      label: 'Mật khẩu',
                      icon: Icons.lock,
                      isObscure: true,
                    ),
                    const SizedBox(height: 24.0),
                    SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: _login,
                        color: colorPrimary,
                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: const Text('Đăng nhập'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Chưa có tài khoản? '),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text('Đăng ký', style: TextStyle(color: colorPrimary)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Loading overlay
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
