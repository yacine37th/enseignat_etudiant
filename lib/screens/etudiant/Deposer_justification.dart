import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/etudiant/AddStufs.dart';
import 'package:flutter_application_1/screens/etudiant/HomeEtudiant.dart';
import 'package:image_picker/image_picker.dart';

class Deposer extends StatefulWidget {
  const Deposer({super.key});

  @override
  State<Deposer> createState() => _DeposerState();
}

class _DeposerState extends State<Deposer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final categoryName = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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
        setState(() {
          data = user.uid;
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  File? categorieImage;
  UploadTask? uploadTask;

  Future pickimage() async {
    try {
      final categorieImage = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 85);
      if (categorieImage == null) return;
      final imageTemp = File(categorieImage.path);
      setState(() {
        this.categorieImage = imageTemp;
      });
      print("//////////////////image/////////////////");
      print(categorieImage.name);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  var db = FirebaseFirestore.instance;
  Future DepositionNew() async {
        var doc = db.collection("Users").doc(data);

    var justifications = db.collection("justifications").doc();
    final path = 'justifications/${justifications.id}';
    final file = File(categorieImage!.path);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => {});

    final catepic = await snapshot.ref.getDownloadURL();
    print(
        "bookThumnail /////////////////////////////////////////////////////////////////////");
    print(catepic);

 doc.update({
      "justificationID": justifications.id,
    }).onError((e, _) => print(
        "Error writing document /////////////////////////////////////////////: $e"));
    justifications.set({
      "userID" : doc.id,
      "justificationID": justifications.id,
      "justificationAbout": categoryName.text,
      "justificationPic": catepic,
    }).onError((e, _) => print(
        "Error writing document /////////////////////////////////////////////: $e"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Ajouter une justification d'absence"),
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the justification About';
                      }
                      return null;
                    },
                    controller: categoryName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Entrer la description d'abscence",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    // style: ButtonStyle(
                    //     backgroundColor: MaterialStateProperty.all(
                    //         Color.fromRGBO(32, 48, 61, 1))),
                    onPressed: () => pickimage(),
                    child: const Text('Selectionner la photo de la justification'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    // style: ButtonStyle(
                    //     backgroundColor: MaterialStateProperty.all(
                    //         Color.fromRGBO(32, 48, 61, 1))),
                    onPressed: () => {
                      if (_formKey.currentState!.validate())
                        {
                          // addNewCategorie(),
                          DepositionNew(),
                        
                        },
                        Navigator.of(context).pop(),
                    },
                    child: const Text('Envoyer'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
