import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AjouterAbsence extends StatelessWidget {
  var test;
  AjouterAbsence({super.key, @required this.test});
    final _formKey = GlobalKey<FormState>();
  final categoryName = TextEditingController();
  final note = TextEditingController();
  var db = FirebaseFirestore.instance;

 Future DepositionNew() async {

    var docauth = db.collection("Users").doc(test['UID']);

    docauth.update({
      // "authorID" : docauth.id,
      "nombreAbsence": note.text,
    }).onError((e, _) => print(
        "Error writing document /////////////////////////////////////////////: $e"));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Absences"),
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                //   child: TextFormField(
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Entrer Titre de la matière';
                //       }
                //       return null;
                //     },
                //     controller: categoryName,
                //     decoration: InputDecoration(
                //         border: OutlineInputBorder(),
                //         hintText: "Entrer Titre de la matière"),
                //   ),
                // ),
                
                
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Number of the Absence';
                      }
                      return null;
                    },
                    controller: note,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      hintText: "Entrer le nombre des absence",
                      // labelText: 'Enter text',
                    ),
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
                        },
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