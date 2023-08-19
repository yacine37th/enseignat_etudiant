import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/SingIn.dart';
import 'package:flutter_application_1/screens/etudiant/Deposer_Travail.dart';
import 'package:flutter_application_1/screens/etudiant/Deposer_justification.dart';

class AddStufs extends StatefulWidget {
  const AddStufs({super.key});

  @override
  State<AddStufs> createState() => _AddStufsState();
}

class _AddStufsState extends State<AddStufs>
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


Route route = MaterialPageRoute(builder: (context) => SingIn());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0,
        title: Text("Etudiant"),
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
                          builder: (context) => const Deposer()));
                },
                child: Text("Déposer justification d'abscence")),

                ElevatedButton(
               style: ButtonStyle(
                  // backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))
                  
                  ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeposerTravail()));
                },
                child: Text("Déposer Mon travail")),

              //      ElevatedButton(
              //  style: ButtonStyle(
              //     // backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))
                  
              //     ),
              //                  onPressed: () async {
              //         await FirebaseAuth.instance.signOut();
              //             //  Navigator.of(context).pop();
              //             Navigator.pushReplacement(context, route);
              //       },
              //   child: Text("logout")),
          
          ],
        ),
      ),
  
    );
  }
}