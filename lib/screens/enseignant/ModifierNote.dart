import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModifierNote extends StatelessWidget {
  var test;
  ModifierNote({super.key, @required this.test});
  final note = TextEditingController();
  late AnimationController _controller;
  final _formKey = GlobalKey<FormState>();
  var data;
  //se a Async-await function to get the data
  var db = FirebaseFirestore.instance;
  Future DepositionNew() async {
    // var docauth = db.collection("Users").doc(test['UID']);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(test['UID'])
        .get()
        .then((snapshot) {
      data = snapshot.data()!;
      // Use ds as a snapshot
      var notes = db.collection("Users").doc(test['UID']);

      notes.update({
        "note": note.text,
      }).onError((e, _) => print(
          "Error writing document /////////////////////////////////////////////: $e"));

      // print('Values from db /////////////////////////////////: ' + data["TypeUser"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Modifier une Note"),
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
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the Note of the Student';
                      }
                      return null;
                    },
                    controller: note,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      hintText: "Entrer la nouvelle Note",
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
                          // DepositionNew()
                          DepositionNew(),
                          Navigator.of(context).pop(),
                        },
                    },
                    child: const Text('Enovyer'),
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
