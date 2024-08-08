import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text('Trang phim của tôi'),
      ),
      body: Column(
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
              const Positioned(
                top: 22,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "Trần Hữu Tuân",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
      ),
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
