import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/enseignant/HomeEnseignant.dart';
import 'package:image_picker/image_picker.dart';

class AjouterEmploi extends StatefulWidget {
  const AjouterEmploi({super.key});

  @override
  State<AjouterEmploi> createState() => _AjouterEmploiState();
}

class _AjouterEmploiState extends State<AjouterEmploi>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

  PlatformFile? pickFile;
  UploadTask? uploadTask;
  UploadTask? uploadTask2;
  File? categorieImage;
  File? bookImage;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickFile = result.files.first;
    });
  }

  // File? categorieImage;
  // UploadTask? uploadTask;

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
    var emploiTemps = db.collection("emploiTemps").doc();

    // final path = 'emploiTemps/${emploiTemps.id}';
    // final file = File(categorieImage!.path);

    // final ref = FirebaseStorage.instance.ref().child(path);
    // uploadTask = ref.putFile(file);

    // final snapshot = await uploadTask!.whenComplete(() => {});

    // final catepic = await snapshot.ref.getDownloadURL();
    // print(
    //     "bookThumnail /////////////////////////////////////////////////////////////////////");
    // print(catepic);

    final path = 'emploiTemps/${pickFile!.name}';
    final file = File(pickFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => {});

    final bookURL = await snapshot.ref.getDownloadURL();
    print(
        "urlDowload /////////////////////////////////////////////////////////////////////");
    print(bookURL);

    emploiTemps.set({
      "emploiID": emploiTemps.id,
      "emploiAbout": categoryName.text,
      "emploiPic": bookURL,
    }).onError((e, _) => print(
        "Error writing document /////////////////////////////////////////////: $e"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Ajouter un nouveau emploi du temps "),
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
                        return 'Entrer qlq chose a propos de ce emploi du temps';
                      }
                      return null;
                    },
                    controller: categoryName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Entrer description de cet emploi du temps"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    // style: ButtonStyle(
                    //     backgroundColor: MaterialStateProperty.all(
                    //         Color.fromRGBO(32, 48, 61, 1))),
                    onPressed: () => selectFile(),
                    child:
                        const Text("Séléctionner le fichier d'emploi du temps"),
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
                          Navigator.of(context).pop(),
                        }
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
