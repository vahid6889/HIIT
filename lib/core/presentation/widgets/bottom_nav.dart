import 'package:Hiit/features/feature_bookmark/presentation/screens/bookmark_screen.dart';
import 'package:Hiit/features/feature_weather/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  PageController Controller;
  BottomNav({Key? key, required this.Controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      color: primaryColor,
      child: SizedBox(
        height: 63,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  Controller.animateToPage(
                    HomeScreen.page,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(Icons.home)),
            const SizedBox(),
            IconButton(
                onPressed: () {
                  Controller.animateToPage(
                    BookmarkScreen.page,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(Icons.bookmark)),
          ],
        ),
      ),
    );
  }
}
