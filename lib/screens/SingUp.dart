import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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




 var db = FirebaseFirestore.instance;
Future createNewUser() async {
    Get.defaultDialog(
        title: "Please wait", content: const CircularProgressIndicator());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      FirebaseFirestore.instance
          .collection("Users")
          .doc(credential.user!.uid)
          .set({
        "UID": credential.user!.uid,
        "Email": email.text,
        "UserName": username.text,
        "TypeUser":_selectedLocation,
      });
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      Get.back();
  Get.defaultDialog(
        title: "Please wait", content: const Text('done'));
      // Get.toNamed("/EmailVerification");
    } on FirebaseAuthException catch (e) {
      Get.back();

      if (e.code == 'weak-password') {
        Get.defaultDialog(
          title: "The password provided is too weak.",
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
          title: "The account already exists for that email.",
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


Future creare() async{
  print(email.text);
  print(username.text);
  print(password.text);

  print(_selectedLocation);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Creation du compte"),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
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
                          return "Entrer votre nom d'utilisateur";
                        } else if (val.length > 10) {
                          return "nom d'utilisateur can't be larger than 10 letter";
                        } else if (val.length < 3) {
                          return "Username can't be less than 3 letter";
                        }

                        return null;
                      },
                      controller: username,
                      decoration: InputDecoration(
                        // border: OutlineInputBorder(),
                        hintText: "Entrer votre nom d'utilisateur",
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
                          return "Please enter an email";
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                            .hasMatch(val)) {
                          return "Please enter a valid email";
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
                      // obscureText: signUpController.showPassword,
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        if (value.length > 20) {
                          return "Password can't be larger than 20 letter";
                        }
                        if (value.length < 8) {
                          return "Password can't be smaller than 8 letter";
                        }

                        return null;
                      },
                      // onSaved: (password) {
                      //   signUpController.userPassword =
                      //       password?.trim();
                      // },
                      // onChanged: (password) {
                      //   signUpController.userPassword =
                      //       password.trim();
                      // },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        // suffixIcon: IconButton(
                        //     onPressed: () {
                        //       // signUpController.invertShowPassword();
                        //     },
                        //     // icon: signUpController.showPassword
                        //     //     ? const Icon(Icons.visibility)
                        //     //     : const Icon(Icons.visibility_off)
                        //         ),
                        hintText: 'Password',
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
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(32, 48, 61, 1))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          createNewUser();
                          //          Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(builder: (context) =>),
                          //   (Route<dynamic> route) => false,
                          // );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
