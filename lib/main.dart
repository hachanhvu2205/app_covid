import 'package:covid/country.dart';
import 'package:covid/global.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Covid app"),
      ),
      body: body(currentIndex),
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.public,
              color: Colors.green,
            ),
            title: Text('Global'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.flag,
              color: Colors.green,
            ),
            title: Text('Country'),
          ),
        ],
      ),
    );
  }
}

Widget body(int currentIndex) {
  if (currentIndex == 0) {
    return GlobalPage();
  }
  if (currentIndex == 1) {
    return CountryPage();
  }
}
