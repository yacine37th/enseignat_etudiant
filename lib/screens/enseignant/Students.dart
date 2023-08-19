import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/enseignant/AjouterNote.dart';
import 'package:flutter_application_1/screens/enseignant/ModifierNote.dart';
import 'package:flutter_application_1/screens/enseignant/StudentDetails.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Users')
      .where('TypeUser', isEqualTo: "etudiant")
      // .orderBy("orderDate",descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Tous Les étudiants"),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 68, 124),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
                // Text('${snapshot.connectionState}');
              }
              // if(snapshot.data!.docs.map==[]){
              //   return Center(child: Text("No data"),);
              // }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: ListTile(
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentsDetails(
                                        test: data,
                                      )));
                        },
                        title: Text(data['UserName']),
                        subtitle: SingleChildScrollView(
                          scrollDirection:
                              axisDirectionToAxis(AxisDirection.right),
                          child: Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AjouterNote(
                                                  test: data,
                                                )));
                                  },
                                  child: Text(
                                    "Ajouter Note",
                                    style: TextStyle(fontSize: 12),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ModifierNote(
                                                  test: data,
                                                )));
                                  },
                                  child: Text("Modifier la Note",
                                      style: TextStyle(fontSize: 12))),
                              TextButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => ModifierNote(
                                    //               test: data,
                                    //             )));
                                    var db = FirebaseFirestore.instance;

                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(data['UID'])
                                        .get()
                                        .then((snapshot) {
                                      data = snapshot.data()!;
                                      // Use ds as a snapshot
                                      var notes = db
                                          .collection("Users")
                                          .doc(data['UID']);

                                      notes.update({
                                        "note": "",
                                      }).onError((e, _) => print(
                                          "Error writing document /////////////////////////////////////////////: $e"));

                                      // print('Values from db /////////////////////////////////: ' + data["TypeUser"]);
                                    });
                                  },
                                  child: Text("Supprimer la Note",
                                      style: TextStyle(fontSize: 12)))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}
