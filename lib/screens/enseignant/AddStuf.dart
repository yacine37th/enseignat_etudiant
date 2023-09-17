import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/SingIn.dart';
import 'package:flutter_application_1/screens/enseignant/AjouterCours.dart';
import 'package:flutter_application_1/screens/enseignant/AjouterEmploi.dart';

class AddStuf extends StatefulWidget {
  const AddStuf({super.key});

  @override
  State<AddStuf> createState() => _AddStufState();
}

class _AddStufState extends State<AddStuf> with SingleTickerProviderStateMixin {
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

  Route route = MaterialPageRoute(builder: (context) => SingIn());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Enseignant"),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                    // backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))

                    ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AjouterEmploi()));
                },
                child: Text("Ajouter Emploi du Temps")),
            ElevatedButton(
                style: ButtonStyle(
                    // backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))

                    ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AjouterCours()));
                },
                child: Text("Ajouter Cours")),
            // ElevatedButton(
            //     style: ButtonStyle(
            //         // backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))

            //         ),
            //     onPressed: () async {
            //       await FirebaseAuth.instance.signOut();
            //       Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(builder: (context) => SingIn()),
            //         (Route<dynamic> route) => false,
            //       );
            //     },
            //     child: Text("logout")),
          ],
        ),
      ),
    );
  }
}
