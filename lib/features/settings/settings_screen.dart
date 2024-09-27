import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/providers/auth_provider.dart';

import '../../common/constants/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isAuth = Provider.of<AuthProvider>(context).isAuthenticated;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text('Settings'),
      ),
      body: isAuth
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildButton("Edit Profile", () {
                  Navigator.of(context).pushNamed("editProfile");
                }),
                const Spacer(),
                _buildButton("Logout", () {
                  Provider.of<AuthProvider>(context, listen: false).logout();
                  Navigator.of(context).pop();
                }),
              ],
            )
          : const SizedBox(),
    );
  }

  Widget _buildButton(String title, Function()? onPressed) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: MaterialButton(
        padding: const EdgeInsets.all(16),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
