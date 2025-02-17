import 'package:flutter/material.dart';
import 'package:newsapp/news_screen.dart';

void main() {
  runApp(const News());
}

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        NewsScreen.route: (context) => NewsScreen(),
      },
      initialRoute: NewsScreen.route,
    );
  }
}
