import 'package:cinema_mobile_app/models/account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';
import '../providers/auth_provider.dart';
import '../services/account_service.dart';
import '../widgets/not_found_container.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Account>? _accountFuture;

  @override
  void initState() {
    super.initState();
    _fetchAccount();
  }

  void _fetchAccount() {
    if (Provider.of<AuthProvider>(context, listen: false).isAuthenticated) {
      final token = Provider.of<AuthProvider>(context, listen: false).getToken;
      setState(() {
        _accountFuture = AccountService().getProfile(token);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = Provider.of<AuthProvider>(context).isAuthenticated;

    // Show login dialog if not authenticated
    if (!isAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoginDialog(context);
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text('Trang phim của tôi'),
      ),
      body: isAuthenticated
          ? _buildProfileContent(context)
          : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const NotFoundContainer(
                    message: "Vui lòng đăng nhập để xem trang cá nhân",
                    subMessage: "Đăng nhập để xem thông tin cá nhân của bạn",
                    icon: Icons.person,
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _showLoginDialog(context);
                  },
                  child: const Text('Đăng nhập'),
                ),
              ],
            ),
          ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent dismissal by tapping outside the dialog
      builder: (context) => AlertDialog(
        title: const Text('Login'),
        content: SizedBox(
          width: 300,
          height: 120,
          child: Column(
            children: [
              // Add a text field for the username
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              // Add a text field for the password
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final username = usernameController.text;
              final password = passwordController.text;
              Provider.of<AuthProvider>(context, listen: false)
                  .login(username, password);
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              // Redirect to the home page
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    _fetchAccount();
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            "https://preview.redd.it/10-10-event-v0-h6v5mggehl8c1.png?auto=webp&s=0d043feb11fb70a85a3b1ca79bdecfd67b288f52",
            fit: BoxFit.cover,
          ),
        ),
        Stack(
          clipBehavior:
              Clip.none, // Allow the image to overflow out of the Stack
          children: [
            Transform.translate(
              offset: const Offset(0, -24),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24)),
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: -64, // Position the image above the container
              left: 0,
              right: 0,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    "https://assetsio.gnwcdn.com/Genshin-Impact-Furina-best-build%2C-Talent-and-Ascension-materials%2C-weapon%2C-and-team-cover.jpg?width=1200&height=1200&fit=crop&quality=100&format=png&enable=upscale&auto=webp",
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 22,
              left: 0,
              right: 0,
              child: Center(
                child: FutureBuilder<Account>(
                    future: _accountFuture,
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.hasData ? snapshot.data!.firstName : "",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
              ),
            ),
            Positioned(
              top: 70,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildProfileButton(
                    title: "Vé đã mua",
                    icon: Icons.local_movies,
                    color: Colors.red,
                    backgroundColor: Colors.red[50],
                    value: 5,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/');
                    },
                  ),
                  _buildProfileButton(
                    title: "Phim đã xem",
                    icon: Icons.remove_red_eye,
                    color: Colors.green,
                    backgroundColor: Colors.green[50],
                    value: 3,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/');
                    },
                  ),
                  _buildProfileButton(
                    title: "Đánh giá",
                    icon: Icons.star,
                    value: 5,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/');
                    },
                  ),
                  _buildProfileButton(
                    title: "Bình luận",
                    icon: Icons.message,
                    color: Colors.blue,
                    backgroundColor: Colors.blue[50],
                    value: 0,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileButton(
      {required String title,
      required IconData icon,
      Color? color,
      Color? backgroundColor,
      required int value,
      required Function onPressed}) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: SizedBox(
        width: 80,
        child: Column(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor ?? Colors.yellow[50],
                  borderRadius: BorderRadius.circular(40),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Icon(
                    icon,
                    color: color ?? Colors.yellow,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
