import 'package:flutter/material.dart';

import '../../common/constants/colors.dart';

import './home/home.dart';
import './auditorium/auditorium_selection_screen.dart';
import './product/product_selection_screen.dart';
import './profile/profile_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> dashBoardScreens = [];
  
  @override
  void initState() {
    super.initState();
    dashBoardScreens = [
      const HomePage(title: "Home"),
      const AuditoriumSelectionScreen(title: "Chọn rạp chiếu"),
      const ProductSelectionScreen(),
      const ProfileScreen(),
    ];
  }
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // The main content with the gradient background
          Center(
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.only(bottom: 80),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    ...List.generate(
                      3,
                      (index) => Colors.white.withOpacity(0),
                    )
                  ],
                  center: const Alignment(-1.0, -1.0),
                ),
              ),
              child: PageStorage(
                bucket: bucket,
                child: dashBoardScreens[currentPage],
              ),
            ),
          ),
          // Bottom navigation bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 80,
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  bottomNavigationItem(context, 0, Icons.home, 'Chọn phim'),
                  bottomNavigationItem(context, 1, Icons.place, 'Chọn rạp'),
                  bottomNavigationItem(context, 2, Icons.fastfood, 'Bắp nước'),
                  bottomNavigationItem(context, 3, Icons.person, 'Tôi'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded bottomNavigationItem(
      BuildContext context, int itemIndex, IconData icon, String text) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          setState(() {
            currentPage = itemIndex;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: currentPage != itemIndex
                  ? Colors.grey
                  : colorPrimary,
            ),
            const SizedBox(height: 5),
            Text(text,
                style: TextStyle(
                  color: currentPage != itemIndex
                      ? Colors.grey
                      : colorPrimary,
                  fontSize: 12,
                )),
          ],
        ),
      ),
    );
  }
}