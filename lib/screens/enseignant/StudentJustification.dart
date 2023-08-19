import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/enseignant/AjouterAbsence.dart';
import 'package:flutter_application_1/screens/enseignant/AjouterNote.dart';
import 'package:open_mail_app/open_mail_app.dart';

class JustificationDetails extends StatelessWidget {
  var test;
  JustificationDetails({super.key, @required this.test});

  // const OrderDetails({super.key});

  var db = FirebaseFirestore.instance;
  bool confirm = false;
  var data;
  var not;
    Future DepositionNew() async {
    // var docauth = db.collection("Users").doc(test['UID']);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(test['UID'])
        .get()
        .then((snapshot) {
      data = snapshot.data()!;
      // Use ds as a snapshot
      FirebaseFirestore.instance
        .collection('justifications')
        .doc(data["justificationID"])
        .get()
        .then((snapshot) {
        data = snapshot.data()!;
      // Use ds as a snapshot
    //  print(data["note"]);
     not = data["justificationPic"];
     
     
      
      // print('Values from db /////////////////////////////////: ' + data["TypeUser"]);
    });
   
    
      
      // print('Values from db /////////////////////////////////: ' + data["TypeUser"]);
    });

    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Justification Details '),
        // actions: <Widget>[

        //   IconButton(
        //     icon: const Icon(Icons.add),
        //     tooltip: 'Ajouter Absence',
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => AjouterAbsence(
        //                     test: test,
        //                   )));
        //     },
        //   ),
        // //   IconButton(
        // //     icon: const Icon(Icons.update),
        // //     tooltip: 'modifier la note',
        // //     onPressed: () {
        // //       Navigator.push(
        // //           context,
        // //           MaterialPageRoute(
        // //               builder: (context) => AjouterNote(
        // //                     test: test,
        // //                   )));
        // //     },
        // //   ),
        // ],
   
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Column(children: [
              Text('${test['UserName']}' , style: TextStyle(fontSize: 20),),

              TextButton(   onPressed: () async {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => StudentsDetails(
                          //               test: data,
                          //             )));
                          var result = await OpenMailApp.openMailApp(
                               nativePickerTitle: 'Veuillez choissir une App',
                               
                          );
                          // If no mail apps found, show error
                          if (!result.didOpen && !result.canOpen) {
                            // showNoMailAppsDialog(context);

                            // iOS: if multiple mail apps found, show dialog to select.
                            // There is no native intent/default app system in iOS so
                            // you have to do it yourself.
                          } else if (!result.didOpen && result.canOpen) {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return MailAppPickerDialog(
                                    mailApps: result.options,
                                  );
                                });
                          }
                          ;
                        },child: Text('${test['Email']}',style: TextStyle(fontSize: 20),),),

              // Text('${test['UserName']}'),
                // Text('${data}'),
                      // Text(
              //   'Order Date : ${DateTime.parse(test['orderDate'].toDate().toString())}',
              //   style: TextStyle(fontSize: 18),
              // ),
              // Text(test['orderID']),
              // orderDate

              // Text(test['orderDate']),

              // Padding(
              //     padding: EdgeInsets.symmetric(vertical: 15),
              //     child: Center(
              //       child: Image.network('${test['orderProofImageURL']}'),
              //     )
              //     // Image.network(test['orderProofImageURL'] , ),
              //     ),
              Text("Justification :",style: TextStyle(fontSize: 20),),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Image.network('${test['justificationPic']}',
                        width: 300,
                        height: 300, errorBuilder: (BuildContext context,
                            Object exception, StackTrace? stackTrace) {
                      return Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxFLlzVp2jEn2Kx38_HsZiHYKtBJtQxxTg810DIpZS&s");
                    }),
                  )
                  // Image.network(detail['orderProofImageURL'] , ),
                  ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: ElevatedButton(
                      // style: ButtonStyle(
                      //     backgroundColor: MaterialStateProperty.all(
                      //         Color.fromRGBO(32, 48, 61, 1))),
                      onPressed: () {
                        // Navigator.of(context).pop();
                        // DepositionNew();
                         FirebaseFirestore.instance
        .collection('Users')
        .doc(test['UID'])
        .get()
        .then((snapshot) {
      data = snapshot.data()!;
      // Use ds as a snapshot
      var notes = db.collection("Users").doc(test['UID']);

      notes.update({
        "justificationValid?": true,
      }).onError((e, _) => print(
          "Error writing document /////////////////////////////////////////////: $e"));

      // print('Values from db /////////////////////////////////: ' + data["TypeUser"]);
    });
                      },
                      child: Text('Valider'),
                    ),
                  ),
                  // SizedBox(
                  //   width: 25.0,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 18),
                  //   child: ElevatedButton(
                  //     style: ButtonStyle(
                  //       backgroundColor: MaterialStateProperty.all(Colors.red),
                  //     ),
                  //     onPressed: () {
                  //       print("object");
                  //       print("object//////////////////////////");

                  //       print(test['orderID']);

                  //       var docauth = db
                  //           .collection("ordersPhysical")
                  //           .doc(test['orderID']);

                  //       docauth.delete().onError((e, _) => print(
                  //           "Error writing document /////////////////////////////////////////////: $e"));

                  //       // Navigator.pushAndRemoveUntil(
                  //       //   context,
                  //       //   MaterialPageRoute(
                  //       //       builder: (context) => OrdersElectronique()),
                  //       //   (Route<dynamic> route) => false,
                  //       // );
                  //       // Navigator.of(context).pop();
                  //       Navigator.of(context).pop();
                  //     },
                  //     child: Text('Delete'),
                  //   ),
                  // ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
