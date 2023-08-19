import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/etudiant/AddStufs.dart';
import 'package:flutter_application_1/screens/etudiant/EmploiDuTempsDowload.dart';
import 'package:flutter_application_1/screens/etudiant/Profil.dart';
import 'package:flutter_application_1/screens/etudiant/TelechargerDoc.dart';

class HomeEtudiant extends StatefulWidget {
  const HomeEtudiant({super.key});

  @override
  State<HomeEtudiant> createState() => _HomeEtudiantState();
}

class _HomeEtudiantState extends State<HomeEtudiant>
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

  final screens =[
  AddStufs(),
  TelechargerDoc(),
  EmploiDuTempsDowload(),
  Profile()
   
  ];
  static const IconData subscriptions = IconData(0xe618, fontFamily: 'MaterialIcons');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
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
            icon: Icon(Icons.document_scanner),
            label: 'Cours',
            // backgroundColor: Colors.green,
          ),
         BottomNavigationBarItem(
             icon: Icon(Icons.table_chart),
            label: 'Emploi Du Temps',
            // backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            // icon: Icon(Icons.settings),
            // label: 'Settings',
             icon: Icon(Icons.person_2),
            label: 'Profil',
            // backgroundColor: Colors.pink,
          ),
           
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      body: screens[_selectedIndex],
      // body: 
      //  SafeArea(

      //   child: Center(
      //       child: Column(
      //     children: [
      //       //  test ?  Center(child: Column(children: [
      //       //   Text("${user}"),
      //       //   TextButton(onPressed: () async{
      //       //      await FirebaseAuth.instance.signOut();
      //       //   }, child: Text('logout'))
      //       //  ],))
      //       //   :
      //       Center(
      //           child: Column(
      //         children: [
      //           Text('you need to login'),
      //           TextButton(
      //               onPressed: () {
      //                 // Navigator.push(context,
      //                 //     MaterialPageRoute(builder: (context) => SingIn()));
      //               },
      //               child: Text("login")),
      //           TextButton(
      //               onPressed: () async {
      //                 await FirebaseAuth.instance.signOut();
      //               },
      //               child: Text('logout')),
      //           //  ],))
      //         ],
      //       ))
      //       // await FirebaseAuth.instance.signOut();
      //     ],
      //   )),
      // ),
   
    );
  }
}