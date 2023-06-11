import 'package:Hiit/core/presentation/widgets/app_background.dart';
import 'package:Hiit/core/presentation/widgets/bottom_nav.dart';
import 'package:Hiit/features/feature_bookmark/presentation/screens/bookmark_screen.dart';
import 'package:Hiit/features/feature_weather/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({Key? key}) : super(key: key);

  final PageController pageController = PageController(initialPage: 0);
  void _darkStatusAndNavigationBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.grey.shade900,
        systemNavigationBarDividerColor: Colors.grey.shade900,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _darkStatusAndNavigationBar();
    List<Widget> pageViewWidget = [
      const HomeScreen(),
      BookmarkScreen(pageController: pageController),
    ];

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBody: true,
      bottomNavigationBar: BottomNav(Controller: pageController),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AppBackground.getBackGroundImage(),
          ),
        ),
        height: height,
        child: PageView(
          controller: pageController,
          children: pageViewWidget,
        ),
      ),
    );
  }
}
