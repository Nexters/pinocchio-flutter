import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) {
        return MainScreen();
      },
    );
  }

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("메인"),
        centerTitle: true,
      ),
      body: Center(child: Text('메인 화면')),
    );
  }
}
