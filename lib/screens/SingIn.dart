import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/HomeScreen.dart';
import 'package:flutter_application_1/screens/SingUp.dart';
import 'package:get/get.dart';

class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showPassword = true;
  invertShowPassword() {
    showPassword = !showPassword;
  }

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _obscured = false;
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    invertShowPassword();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  var db = FirebaseFirestore.instance;

  Future signInAUser() async {
    Get.defaultDialog(
        barrierDismissible: false,
        title: "Please wait",
        content: const CircularProgressIndicator(),
         onConfirm: () {
            Get.back();
          },
        );
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      // credential.user!.uid

      var data;
      FirebaseFirestore.instance
          .collection('Users')
          .doc(credential.user!.uid)
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
          Get.back();
      //      Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreen()),
      // );
        } else {
          print('ensignant');
          Get.back();
            Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
        }

        // print('Values from db /////////////////////////////////: ' + data["TypeUser"]);
      });

      print('////////////////////////////////////// DONE');
      // Get.defaultDialog(
      //   barrierDismissible: false,
      //   title: "Please wait",
      //   content: const Text("Login Success"),
      //   onConfirm: () {
      //     Get.back();
      //   },
      // );
    } on FirebaseAuthException catch (e) {
      Get.back();

      if (e.code == 'user-not-found') {
        Get.defaultDialog(
          title: "No user found for that email.",
          content: const Icon(
            Icons.report_problem,
            color: Colors.red,
          ),
          onConfirm: () {
            Get.back();
          },
        );
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
          title: "Wrong password provided for that user.",
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
      print(e);
      Get.back();
      Get.defaultDialog(
        title: "something went wrong",
        content: const Icon(
          Icons.report_problem,
          color: Colors.red,
        ),
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Login"),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            
            decoration: BoxDecoration(
              // border: Border.all(width: 1)

            ),
            child: Stack(
              children: [
                Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisSize: MainAxisSize.min,
                            
                            mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    _toggleObscured();
                                  },
                                  icon: _obscured
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                              hintText: 'Password',
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              child: ElevatedButton(
                                
                                style: ButtonStyle(
                                    // backgroundColor: MaterialStateProperty.all(
                                    //     Color.fromRGBO(32, 48, 61, 1)),
                                    //     alignment: Alignment.center
                                    
                                        ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    signInAUser();
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
                        
                        
                        
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              child: ElevatedButton(
                                
                                style: ButtonStyle(
                                    // backgroundColor: MaterialStateProperty.all(
                                    //     Color.fromRGBO(32, 48, 61, 1)),
                                    //     alignment: Alignment.center
                                    
                                        ),
                                onPressed: () {
                                              Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUp()),
      );
                                },
                                child: const Text('Registration'),
                              ),
                            ),
                                            
                          ],
                        ),
                      ],
                    ),
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
