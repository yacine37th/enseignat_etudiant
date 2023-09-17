import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/SingIn.dart';
import 'package:flutter_application_1/screens/etudiant/Teachers.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var data;
  bool de = false;
  bool isLogin = false;
  bool login = false;
  var db = FirebaseFirestore.instance;
  var data2;
  var data3;

  var noteTD ; 
  var noteTP;
  var moyenne ; 

  Future islog() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');

//       Navigator.pushReplacement(
// context,MaterialPageRoute(builder: (context) => SingIn()),);
// Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      } else {
        print('User is signed in!');
        setState(() {
          data = user;
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
            data2 = snapshot.data()!;
            noteTD = data2["note_TD"];
            noteTP = data2["note_TP"];


moyenne =(noteTD + noteTP) ~/2 ; 

print("moyenne");
print(moyenne);
            print("dddd///////////////" + data2["UserName"]);
            setState(() {
                isLogin = true;
              });
          });
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

  Route route = MaterialPageRoute(builder: (context) => SingIn());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Profile"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              //  Navigator.of(context).pop();
              Navigator.pushReplacement(context, route);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              isLogin
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: CircleAvatar(
                            radius: 40,
                            child: Image.network(
                                "https://w7.pngwing.com/pngs/184/113/png-transparent-user-profile-computer-icons-profile-heroes-black-silhouette-thumbnail.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data2["UserName"],
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(
                        //     "Note: ${data3["note"]}",
                        //     style: TextStyle(fontSize: 20),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Nombre d'absence: ${data2["nombreAbsence"]=="" ? "Pas d'absence": data2["nombreAbsence"] }",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Note TD : ${data2["note_TD"]=="" ? "Pas de note": data2["note_TD"] }",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),

                           Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Note TP : ${data2["note_TP"]=="" ? "Pas de note": data2["note_TP"] }",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),


                           Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Moyenne : ${moyenne =="" ? "pas de moyenne": moyenne}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),


                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Votre justification est validée : ${data2["justificationValid?"]}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              // textStyle: MaterialStateProperty.all(Colors.white),
                            ),
                            child: Text("Trouver les enseignants"),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Teachers()));
                            },
                          ),
                        ),
                      ],
                    )
                  : CircularProgressIndicator(
                      backgroundColor: const Color.fromARGB(255, 0, 68, 124),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
