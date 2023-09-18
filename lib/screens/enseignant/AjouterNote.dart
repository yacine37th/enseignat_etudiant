import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AjouterNote extends StatefulWidget {
  const AjouterNote({super.key});

  @override
  State<AjouterNote> createState() => _AjouterNoteState();
}

class _AjouterNoteState extends State<AjouterNote> {
  late AnimationController _controller;
  final _formKey = GlobalKey<FormState>();
  final categoryName = TextEditingController();
  final note = TextEditingController();
  var db = FirebaseFirestore.instance;
  String? typeNote;
  Future DepositionNew() async {
    // var notes = db.collection("notes").doc();
    if (typeNote == "TD") {
      var docauth = db.collection("Users").doc("${Get.arguments['UID']}");

      docauth.update({
        // "authorID" : docauth.id,
        "note_TD": double.parse(note.text),
        // "typeNote":typeNote,
      }).onError((e, _) => print(
          "Error writing document /////////////////////////////////////////////: $e"));
    } else if (typeNote == "TP") {
         var docauth = db.collection("Users").doc("${Get.arguments['UID']}");

      docauth.update({
        // "authorID" : docauth.id,
        "note_TP":  double.parse(note.text),
        // "typeNote":typeNote,
      }).onError((e, _) => print(
          "Error writing document /////////////////////////////////////////////: $e"));

      // notes.set({
      //   "noteID": notes.id,
      //   "userID": docauth.id,
      //   "matiere": categoryName.text,
      //   "note": note.text,
      // }).onError((e, _) => print(
      //     "Error writing document /////////////////////////////////////////////: $e"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Ajouter une Note"),
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
                    //   inputFormatters:FilteringTextInputFormatter.allow(
                    //   RegExp(r'[0-9]'),
                    // ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entrer la note';
                      }
                      return null;
                    },
                    controller: note,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      hintText: "Entrer la Note",
                      // labelText: 'Enter text',
                    ),
                  ),
                ),

                RadioListTile(
                  title: Text("TD"),
                  value: "TD",
                  groupValue: typeNote,
                  activeColor: Colors.blue[800],
                  onChanged: (value) {
                    setState(() {
                      typeNote = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Text("TP"),
                  value: "TP",
                  groupValue: typeNote,
                  activeColor: Colors.blue[800],
                  onChanged: (value) {
                    setState(() {
                      typeNote = value.toString();
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
                      if (_formKey.currentState!.validate() &&
                          typeNote != null &&
                          typeNote != "")
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
