import 'package:flutter/material.dart';

import "../screens/home.dart";
import '../screens/product_selection_screen.dart';
import "../screens/profile_screen.dart";
import '../screens/auditorium_selection_screen.dart';
import '../constants/colors.dart';

class AppRoutes extends StatefulWidget {
  const AppRoutes({super.key});

  @override
  State<AppRoutes> createState() => _AppRoutesState();
}

class _AppRoutesState extends State<AppRoutes> {
  int currentTab = 0;
  final List<Widget> screens = [
    const HomePage(title: "Home"),
    const AuditoriumSelectionScreen(title: "Chọn rạp chiếu"),
    const ProductSelectionScreen(),
    const ProfileScreen(),
  ];

  final pageStorageBucket = PageStorageBucket();
  Widget currentScreen = const HomePage(title: "Home");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: pageStorageBucket,
        child: currentScreen,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          enableFeedback: false,
          currentIndex: currentTab,
          selectedItemColor: colorPrimary, // Màu của icon khi được chọn
          unselectedItemColor: Colors.grey, // Màu của icon khi không được chọn
          showUnselectedLabels: true, // Hiển thị label khi không được chọn
          selectedFontSize: 12, // Kích thước font chữ khi được chọn
          unselectedFontSize: 12, // Kích thước font chữ khi không được chọn
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              currentTab = index;
              currentScreen = screens[index];
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Chọn phim',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.place),
              label: 'Chọn rạp',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood),
              label: 'Bắp nước',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Tôi',
            ),
          ],
        ),
      ),
    );
  }
}
