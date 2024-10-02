import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/providers/auth_provider.dart';

import '../../../common/routes/routes.dart';
import '../../../common/constants/colors.dart';
import '../../../common/services/account_service.dart';
import '../../../common/widgets/not_found_container.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) {
      return;
    }
    File selectedImage = File(image.path);
    _updateAvatar(selectedImage);
  }

  @override
  void initState() {
    super.initState();
  }

  void _updateAvatar(File fileData) {
    final token = Provider.of<AuthProvider>(context, listen: false).getToken;
    AccountService().updateAvatar(token, fileData).then((account) {
      if (mounted) {
        Provider.of<AuthProvider>(context, listen: false).setUser(account);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Avatar updated successfully'),
          ),
        );
      }
    }).catchError(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = Provider.of<AuthProvider>(context).isAuthenticated;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Trang phim của tôi'),
            IconButton(
                onPressed: () {
                  // Push the setting screen
                  Navigator.of(context).pushNamed(Routes.settingsScreen);
                },
                icon: const Icon(Icons.settings, color: Colors.white)),
          ],
        ),
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
                      Navigator.of(context).pushNamed(Routes.login);
                    },
                    child: const Text('Đăng nhập'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            Provider.of<AuthProvider>(context).getUser?.backgroundUrl ??
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
              width: 80,
              height: 80,
              left: MediaQuery.of(context).size.width / 2 - 40,
              child: Stack(children: [
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            Provider.of<AuthProvider>(context)
                                    .getUser
                                    ?.avatarUrl ??
                                "https://assetsio.gnwcdn.com/Genshin-Impact-Furina-best-build%2C-Talent-and-Ascension-materials%2C-weapon%2C-and-team-cover.jpg?width=1200&height=1200&fit=crop&quality=100&format=png&enable=upscale&auto=webp",
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                    )),
                Positioned(
                  bottom: 0,
                  right: 0,
                  width: 30,
                  height: 30,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.orange,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Positioned(
              top: 22,
              left: 0,
              right: 0,
              child: Center(
                  child: Text(
                "${Provider.of<AuthProvider>(context).getUser?.firstName ?? ""} ${Provider.of<AuthProvider>(context).getUser?.lastName ??
                        ""}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
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
                      Navigator.of(context).pushNamed(Routes.invoiceHistory);
                    },
                  ),
                  _buildProfileButton(
                    title: "Phim đã xem",
                    icon: Icons.remove_red_eye,
                    color: Colors.green,
                    backgroundColor: Colors.green[50],
                    value: 3,
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.invoiceHistory);
                    },
                  ),
                  _buildProfileButton(
                    title: "Đánh giá",
                    icon: Icons.star,
                    value: 5,
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.invoiceHistory);
                    },
                  ),
                  _buildProfileButton(
                    title: "Bình luận",
                    icon: Icons.message,
                    color: Colors.blue,
                    backgroundColor: Colors.blue[50],
                    value: 0,
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.invoiceHistory);
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
