import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: MaterialButton(
              padding: const EdgeInsets.all(16),
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
                Navigator.of(context).pop();
              },
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}