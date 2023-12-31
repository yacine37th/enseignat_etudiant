import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/SingIn.dart';
import 'package:flutter_application_1/screens/enseignant/AddStuf.dart';
import 'package:flutter_application_1/screens/enseignant/Justification.dart';
import 'package:flutter_application_1/screens/enseignant/Students.dart';
import 'package:flutter_application_1/screens/enseignant/addtoGroup/MyStudents.dart';

class HomeEnsi extends StatefulWidget {
  const HomeEnsi({super.key});

  @override
  State<HomeEnsi> createState() => _HomeEnsiState();
}

class _HomeEnsiState extends State<HomeEnsi>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Subscription',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [
    AddStuf(),
    Students(),

    MyStudents(),

    Justification(),
  ];
  static const IconData subscriptions =
      IconData(0xe618, fontFamily: 'MaterialIcons');
  Route route = MaterialPageRoute(builder: (context) => SingIn());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
     
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Text("Enseig"),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // selectedIconTheme:  IconThemeData(
        //   color:  Color.fromRGBO(32, 48, 61, 1),

        // ),

        // unselectedIconTheme: IconThemeData(
        //   color:  Colors.blackS

        // ),
        // selectedIconTheme: IconThemeData(color: Colors.red),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            // backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Etudiants',
            // backgroundColor: Colors.green,
          ),
BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Mes Etudiants',
            // backgroundColor: Colors.green,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.offline_bolt),
            label: 'Justifications',
            // backgroundColor: Colors.purple,
          ),
          // BottomNavigationBarItem(
          //   // icon: Icon(Icons.settings),
          //   // label: 'Settings',
          //   icon: Icon(subscriptions),
          //   label: 'Subscription',
          //   // backgroundColor: Colors.pink,
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      body: screens[_selectedIndex],
    );
  }
}
