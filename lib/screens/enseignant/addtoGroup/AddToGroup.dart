import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToGroup extends StatefulWidget {
  const AddToGroup({super.key});

  @override
  State<AddToGroup> createState() => _AddToGroupState();
}

class _AddToGroupState extends State<AddToGroup> {
  String? group;
  Future addToGroup() async {
    FirebaseFirestore.instance
        .collection("Users")
        .doc("${Get.arguments["UID"]}")
        .update({
      "userGroup": group,
      "userProf": FirebaseAuth.instance.currentUser!.uid,
    });
    navigator!.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter au groupe"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RadioListTile(
              title: Text("Groupe 1"),
              value: "Groupe 1",
              groupValue: group,
              activeColor: Colors.blue[800],
              onChanged: (value) {
                setState(() {
                  group = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("Groupe 2"),
              value: "Groupe 2",
              groupValue: group,
              activeColor: Colors.blue[800],
              onChanged: (value) {
                setState(() {
                  group = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("Groupe 3 "),
              value: "Groupe 3  ",
              groupValue: group,
              activeColor: Colors.blue[800],
              onChanged: (value) {
                setState(() {
                  group = value.toString();
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: ElevatedButton(
                // style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all(
                //         Color.fromRGBO(32, 48, 61, 1))),
                onPressed: () {
                  if (group != "" && group != null) {
                    addToGroup();
                  }else {
                    print("deed");
                  }
                },
                child: const Text(
                  'Confirmer',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
