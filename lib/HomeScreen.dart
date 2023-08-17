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

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(vsync: this);
  // }
//    var user = FirebaseAuth.instance.currentUser;
//   bool test =false ;
//   @override
//   void initState() {
//     print(user);
// //     if (user != null){
// //       // ScaffoldMessenger.of(context).showSnackBar(
// //       //   SnackBar(
// //       //     content: Text('${user!.email} signed in'),
// //       //   ),
// //       // );
// //       setState(() {
// //         test = true;
// //       });
// //       print('login');
// //       print(user);
// //       // Navigator.push(
// //       //   context,
// //       //   MaterialPageRoute(builder: (context) => HomeScreen()),
// //       // );
// //     }else{
// //           print('logout');
// //  setState(() {
// //           Navigator
// //     .of(context)
// //     .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => SingIn()));
// //  });

// //     }
// FirebaseAuth.instance
//   .authStateChanges()
//   .listen((User? user) {
//     if (user == null) {
//       print('User is currently signed out!');
// //       Navigator.pushReplacement(
// // context,MaterialPageRoute(builder: (context) => SingIn()),);
// // Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
//     } else {
//       print('User is signed in!');
//       setState(() {
//         test = true;
//       });

//       //       // Navigator.push(
// //       //   context,
// //       //   MaterialPageRoute(builder: (context) => HomeScreen()),
// //       // );

//     }
//   });
//     super.initState();
//   }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
 var data;
  bool de = false;
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
        setState(() {
          isLogin = true;
        });

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
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Text("eded"),
      // ),
      body: de ? HomeEtudiant(): HomeEnsi() 
     
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
      //                 Navigator.push(context,
      //                     MaterialPageRoute(builder: (context) => SingIn()));
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
