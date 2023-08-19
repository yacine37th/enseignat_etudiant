import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/enseignant/AjouterNote.dart';
import 'package:flutter_application_1/screens/enseignant/ModifierNote.dart';
import 'package:flutter_application_1/screens/enseignant/StudentDetails.dart';
import 'package:open_mail_app/open_mail_app.dart';

class Teachers extends StatefulWidget {
  const Teachers({super.key});

  @override
  State<Teachers> createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
// void onOpenMailClicked() async {
//   try {
//        await Utils.sendEmail(
//        email: "optional@email.com",
//        subject: "Optional",
//        );
//        } catch (e) {
//         debugPrint("sendEmail failed ${e}");
//        }
// }
//   Future<void> _launch(Uri url) async {
//     await canLaunchUrl(url)
//         ? await launchUrl(url)
//         : _showSnackBar('could_not_launch_this_app'.tr());
//       }

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('Users')
      .where('TypeUser', isEqualTo: "ensignant")
      // .orderBy("orderDate",descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Tous les enseignants"),
        
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
                        onTap: () async {
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
                        },
                        title: Text(data['UserName']),
                        subtitle: Text(data['Email']),
                        // subtitle: Row(
                        //   children: [
                        //     TextButton(
                        //         onPressed: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) => AjouterNote(
                        //                         test: data,
                        //                       )));
                        //         },
                        //         child: Text("Ajouter Note")),

                        //          TextButton(
                        //         onPressed: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) => ModifierNote(
                        //                         test: data,
                        //                       )));
                        //         },
                        //         child: Text("Modifier la Note"))
                        //   ],
                        // ),
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
