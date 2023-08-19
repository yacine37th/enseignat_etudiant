import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/SingIn.dart';
import 'package:flutter_application_1/screens/enseignant/HomeEnseignant.dart';
import 'package:flutter_application_1/screens/etudiant/HomeEtudiant.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  var db = FirebaseFirestore.instance;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
 var data;
  var de = false  ;
  bool isLogin = true;
  bool login = false;
    Future islog() async {
      
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          isLogin = false;
        });
        print(isLogin);
//       Navigator.pushReplacement(
// context,MaterialPageRoute(builder: (context) => SingIn()),);
// Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      } else {
        print('User is signed in!');
        // setState(() {
        //   isLogin = true;
        // });

        print(user.uid);
        print(isLogin);

        FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get()
            .then((snapshot) {
          // Use ds as a snapshot
          setState(() {
            data = snapshot.data()!;
            print('Values from db /////////////////////////////////: ' +
                data["TypeUser"]);
          });

          if (data["TypeUser"] == "etudiant") {
            print('etudiant');
            setState(() {
              de = true;
            });
            Get.back();
          } else {
            print('ensignant');
            setState(() {
              de = false;
            });
            Get.back();

          }

          // print('Values from db /////////////////////////////////: ' + data["TypeUser"]);
        });
      }
    });
  }

  @override
  void initState() {
    // print(user);
    islog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: de ? HomeEtudiant(): HomeEnsi()                


       
      //  
     
     
    );
  }
}
