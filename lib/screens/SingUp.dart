import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/SingIn.dart';
import 'package:flutter_application_1/sign_up_controller.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // final SignUpController signUpController = Get.find();

  final authorName = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  final bookTitle = TextEditingController();
  final bookCategory = TextEditingController();
  final bookAbout = TextEditingController();
  var bookPrice = TextEditingController();
  final bookPublishingHouse = TextEditingController();
  final bookAuthorName = TextEditingController();
  var category;
  var bookauthorID;
  var bookauhorName;
  final _formKey = GlobalKey<FormState>();
  var _selectedValue;
  var _selectedValueAuth;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    authorName.dispose();
    bookTitle.dispose();
    bookCategory.dispose();
    bookAbout.dispose();
    bookPrice.dispose();
    bookPublishingHouse.dispose();
    bookAuthorName.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  List<String> _locations = ['etudiant', 'ensignant']; // Option 2
  var _selectedLocation;
  bool _obscureText = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _obscured = true;
  final textFieldFocusNode = FocusNode();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  var db = FirebaseFirestore.instance;
  Route route = MaterialPageRoute(builder: (context) => SingIn());

  Future createNewUser() async {
    Get.defaultDialog(
      barrierDismissible: false,
      title: "Veuillez attendre ...",
      content: const CircularProgressIndicator(),
      //  onConfirm: () {
      //     Get.back();
      //   },
    );
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      if( _selectedLocation =="ensignant"){
        FirebaseFirestore.instance
          .collection("Users")
          .doc(credential.user!.uid)
          .set({
        "UID": credential.user!.uid,
        "Email": email.text,
        "UserName": username.text,
        "TypeUser": _selectedLocation,
      });
       Get.back();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Inscription a été trés bien fait , maintenant login")));
      // Get.defaultDialog(
      //     title: "Votre compte a ete bien créé",
      //     onConfirm: () {
      //       Get.back();
      //     });
       Navigator.of(context).pop();
     
      }else{
        FirebaseFirestore.instance
          .collection("Users")
          .doc(credential.user!.uid)
          .set({
        "UID": credential.user!.uid,
        "Email": email.text,
        "UserName": username.text,
        "TypeUser": _selectedLocation,
        "nombreAbsence": "",
        "note" : "",
        "traivailsIDS":[],
        "justificationValid?" : false,
      });
        Get.back();
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Inscription a été trés bien fait")));
       Navigator.of(context).pop();
      }
       // await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    

      // Get.toNamed("/EmailVerification");
    } on FirebaseAuthException catch (e) {
      Get.back();

      if (e.code == 'weak-password') {
        Get.defaultDialog(
          title: "Le mot de passe fourni est trop faible.",
          content: const Icon(
            Icons.report_problem,
            color: Colors.red,
          ),
          onConfirm: () {
            Get.back();
          },
        );
      } else if (e.code == 'email-already-in-use') {
        Get.defaultDialog(
          title: "Le compte existe déjà pour cet e-mail.",
          content: const Icon(
            Icons.report_problem,
            color: Colors.red,
          ),
          onConfirm: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      Get.back();
    }
  }

  Future creare() async {
    print(email.text);
    print(username.text);
    print(password.text);

    print(_selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Création du compte"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 10, horizontal: 30),
                    //     child: DropdownButtonFormField(
                    //         value: _selectedValue,
                    //         hint: Text('choose the Category of the book'),
                    //         isExpanded: true,
                    //         onChanged: (value) {
                    //           setState(() {
                    //             _selectedValue = value;
                    //           });
                    //         },
                    //         onSaved: (value) {
                    //           setState(() {
                    //             _selectedValue = value;
                    //           });
                    //         },
                    //         validator: (value) =>
                    //             value == null ? 'Select the Category of the book' : null,
                    //         items: categorieList.map((category) {
                    //           return DropdownMenuItem(
                    //             child: Text(category["name"]),
                    //             value: category,
                    //           );
                    //         }).toList())),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: TextFormField(
                        // The validator receives the text that the user has entered.
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Veuillez Entrer votre nom Complet";
                          }
                          // else if (val.length > 10) {
                          //   return "nom d'utilisateur can't be larger than 10 letter";
                          // }
                          else if (val.length < 3) {
                            return "Votre Nom ne peut pas être inférieur à 8 lettres";
                          }

                          return null;
                        },
                        controller: username,
                        decoration: InputDecoration(
                          // border: OutlineInputBorder(),
                          hintText: "Entrer votre Nom Complet",
                          // labelText: "Entrer votre nom d'utilisateur",
                          prefixIcon: Icon(Icons.person_2),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Veuillez entrer votre email";
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                              .hasMatch(val)) {
                            return "Veuillez enter un email valid";
                          }

                          return null;
                        },
                        // onSaved: (emailAddress) {
                        //   signUpController.userEmailAddress =
                        //       emailAddress?.trim();
                        // },
                        // onChanged: (emailAddress) {
                        //   signUpController.userEmailAddress =
                        //       emailAddress.trim();
                        // },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                          hintText: 'E-mail',
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscured,
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Veuillez enter votre mot de passe";
                          }
                          if (value.length > 20) {
                            return "Mot de passe ne peut pas dépasser 20 lettres";
                          }
                          if (value.length < 8) {
                            return "Le mot de passe ne peut pas être inférieur à 8 lettres";
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {
                                _toggleObscured();
                              },
                              icon: _obscured
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          hintText: 'Mot De Passe',
                        ),
                      ),
                    ),
                    // Padding(
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 10, horizontal: 30),
                    //     child: DropdownButtonFormField(
                    //         value: _selectedValueAuth,
                    //         hint: Text('choose the Author of the book'),
                    //         isExpanded: true,
                    //          validator: (value) =>
                    //             value == null ? 'Select the Author of the book' : null,
                    //         onChanged: (value) {
                    //           setState(() {
                    //             _selectedValueAuth = value;
                    //           });
                    //         },
                    //         onSaved: (value) {
                    //           setState(() {
                    //             _selectedValueAuth = value;
                    //           });
                    //         },
                    //         items: authorList.map((category) {
                    //           return DropdownMenuItem(
                    //             child: Text(category["name"]),
                    //             value: category,
                    //           );
                    //         }).toList())),
                    //    Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 15, horizontal: 30),
                    //   child: TextFormField(
                    //     minLines: 3,
                    //     maxLines: 8,
                    //     keyboardType: TextInputType.multiline,
                    //     controller: bookAbout,
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return 'Please enter the Descrption of the Book';
                    //       }
                    //       return null;
                    //     },
                    //     decoration: InputDecoration(
                    //       alignLabelWithHint: true,
                    //       border: OutlineInputBorder(),
                    //       hintText: "Enter the Descrption of the Book",
                    //       // labelText: 'Enter text',
                    //     ),
                    //   ),
                    // ),
                    //  Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 15, horizontal: 30),
                    //   child: TextFormField(
                    //     keyboardType: TextInputType.number,
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return 'Please enter the Price of the Book';
                    //       }
                    //       return null;
                    //     },
                    //     controller: bookPrice,
                    //     decoration: InputDecoration(
                    //       alignLabelWithHint: true,
                    //       border: OutlineInputBorder(),
                    //       hintText: "Enter the Price of the Book",
                    //       // labelText: 'Enter text',
                    //     ),
                    //   ),
                    // ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 15, horizontal: 30),
                    //   child: TextFormField(
                    //     // minLines: 3,
                    //     // maxLines: 8,
                    //     // keyboardType: TextInputType.multiline,
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return 'Please enter the publisher house';
                    //       }
                    //       return null;
                    //     },
                    //     controller: bookPublishingHouse,
                    //     decoration: InputDecoration(
                    //       alignLabelWithHint: true,
                    //       border: OutlineInputBorder(),
                    //       hintText: "Enter the publisher house",
                    //       // labelText: 'Enter text',
                    //     ),
                    //   ),
                    // ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 30),
                    //   child: ElevatedButton(
                    //      style: ButtonStyle(
                    // backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))

                    // ),
                    //     onPressed: () {},
                    //     child: const Text('Select Picture of the book'),
                    //   ),
                    // ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 30),
                    //   child: ElevatedButton(
                    //      style: ButtonStyle(
                    // backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))

                    // ),
                    //     onPressed: (){},
                    //     child: const Text('Select File'),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: DropdownButton(
                        hint: Text(
                            "Type d'utilisateur"), // Not necessary for Option 1
                        value: _selectedLocation,

                        onChanged: (newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                          });
                        },
                        //  validator: (value) =>
                        //       value == null ? 'Select the Category of the book' : null,

                        items: _locations.map((location) {
                          return DropdownMenuItem(
                            child: new Text(location),
                            value: location,
                          );
                        }).toList(),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ElevatedButton(
                        // style: ButtonStyle(
                        //     backgroundColor: MaterialStateProperty.all(
                        //         Color.fromRGBO(32, 48, 61, 1))),
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _selectedLocation != null) {
                            createNewUser();
                            //          Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(builder: (context) =>),
                            //   (Route<dynamic> route) => false,
                            // );
                          }
                        },
                        child: const Text('Creer Compte'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
