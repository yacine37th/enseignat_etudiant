import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/HomeScreen.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/screens/SingIn.dart';
import 'package:flutter_application_1/screens/SingUp.dart';
import 'package:flutter_application_1/screens/enseignant/AjouterNote.dart';
import 'package:flutter_application_1/screens/enseignant/HomeEnseignant.dart';
import 'package:flutter_application_1/screens/enseignant/StudentDetails.dart';
import 'package:flutter_application_1/screens/enseignant/addtoGroup/AddToGroup.dart';
import 'package:flutter_application_1/screens/etudiant/HomeEtudiant.dart';
import 'package:get/get.dart';
// import 'package:warak_admin/HomeScreen.dart';
// import 'package:warak_admin/firebase_options.dart';
// import 'package:warak_admin/model/user_model.dart';
// import 'package:warak_admin/screens/AddAuthor.dart';
// import 'package:warak_admin/screens/AddBooks.dart';
// import 'package:warak_admin/screens/AddCategorie.dart';
// import 'package:warak_admin/screens/AddCustomCategory.dar:t';
// import 'package:warak_admin/screens/AddNewBookcarousel.dart';
// import 'package:warak_admin/screens/OrderSubs.dart';
// import 'package:warak_admin/screens/OrderWaraqi.dart';
// import 'package:warak_admin/screens/OrdersElectrinoque.dart';
// import 'package:warak_admin/screens/Updatesubscription.dart';
// import 'package:warak_admin/Home.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var user = FirebaseAuth.instance.currentUser;
  var data;
  bool de = false;
  bool isLogin = false;
  bool login = false;
  Future islog() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        print(isLogin);
//       Navigator.pushReplacement(
// context,MaterialPageRoute(builder: (context) => SingIn()),);
// Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      } else {
        print('User is signed in!');
        setState(() {
          isLogin = true;
        });
        print(user.uid);
        print(isLogin);
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
    return GetMaterialApp(
      title: 'E-student',
      debugShowCheckedModeBanner: false,
      // defaultTransition: Transition.cupertino,
      // theme: Themes.customLightTheme,
      // textDirection: MainFunctions.textDirection,
      home: isLogin ? HomeScreen() : SingIn(),
      //     ? HomeScreen()
      //     // de
      //     //     ? HomeEtudiant()
      //     //     : HomeEnsi()
      //     : SingIn(),
      getPages: [
        GetPage(
          name: "/home",
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: "/register",
          page: () => const SignUp(),
        ),
        GetPage(
          name: "/login",
          page: () => const SingIn(),
        ),
             GetPage(
          name: "/addToGroup",
          page: () =>AddToGroup(),
        ),

            GetPage(
          name: "/addNote",
          page: () =>AjouterNote(),
        ),

        //    GetPage(
        //   name: "/studentDetails",
        //   page: () =>StudentDetails(),
        // ),
      ],
      // initialRoute:  isLogin ? "/home" : "/login"
      // initialRoute: isLogin ? "/home" :
      //  "/login",

      // if(isLogin==false){
      //   return "/login"
      // }else {
      //   return  "/home"
      // };
    );
  }
}
