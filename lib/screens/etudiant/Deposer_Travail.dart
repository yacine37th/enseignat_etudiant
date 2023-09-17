import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class DeposerTravail extends StatefulWidget {
  const DeposerTravail({super.key});

  @override
  State<DeposerTravail> createState() => _DeposerTravailState();
}

class _DeposerTravailState extends State<DeposerTravail>
    with SingleTickerProviderStateMixin {
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
    var travails = db.collection("travails").doc();
    final path = 'travails/${travails.id}';
    final file = File(categorieImage!.path);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() => {});

    final catepic = await snapshot.ref.getDownloadURL();
    print(
        "bookThumnail /////////////////////////////////////////////////////////////////////");
    print(catepic);

    doc.update({
      "traivailsIDS": FieldValue.arrayUnion([travails.id]),
        "travailPic": catepic,
    }).onError((e, _) => print(
        "Error writing document /////////////////////////////////////////////: $e"));
    travails.set({
      "userID": doc.id,
      "travailID": travails.id,
      "travailAbout": categoryName.text,
      "travailPic": catepic,
      "type" : type
    }).onError((e, _) => print(
        "Error writing document /////////////////////////////////////////////: $e"));
  }


  String? type;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Ajouter un travail"),
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
                      hintText: "Entrer la description du travail",
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
                    child:
                        const Text('Selectionner la photo du travail'),
                  ),
                ),



RadioListTile(
                      title: Text("TD"),
                      value: "TD",
                      groupValue: type,
                      onChanged: (value) {
                        setState(() {
                          type = value.toString();
                        });
                      },
                    ),

                    RadioListTile(
                      title: Text("TP"),
                      value: "TP",
                      groupValue: type,
                      onChanged: (value) {
                        setState(() {
                          type = value.toString();
                        });
                      },
                    ),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    // style: ButtonStyle(
                    //     backgroundColor: MaterialStateProperty.all(
                    //         Color.fromRGBO(32, 48, 61, 1))),
                    onPressed: () => {
                      if (_formKey.currentState!.validate() && type!="")
                        {
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
