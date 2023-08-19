import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:path_provider/path_provider.dart';

class EmploiDuTempsDowload extends StatefulWidget {
  const EmploiDuTempsDowload({super.key});

  @override
  State<EmploiDuTempsDowload> createState() => _EmploiDuTempsDowloadState();
}

class _EmploiDuTempsDowloadState extends State<EmploiDuTempsDowload> {
  late AnimationController _controller;
  final _formKey = GlobalKey<FormState>();
  final categoryName = TextEditingController();
  final link = TextEditingController();
  var data;
  var data2;
  Future islog() async {
    FirebaseFirestore.instance
        .collection('emploiTemps')
        .doc("TkwKguGiEFOz9rZ2bAIbiexf3Po2")
        .get()
        .then((snapshot) {

      // Use ds as a snapshot
      setState(() {
        data = snapshot.data()!;
        print('Values from db /////////////////////////////////: ' +
            data["emploiPic"]);
      });

      // print('Values from db /////////////////////////////////: ' + data["TypeUser"]);
    });

FirebaseFirestore.instance
        .collection('cours')
        .doc("hmvhMRXBdWTJTBO0fhF0")
        .get()
        .then((snapshot) {

      // Use ds as a snapshot
      setState(() {
        data2 = snapshot.data()!;
        print('Values from db /////////////////////////////////: ' +
            data2["coursPic"]);
      });

      // print('Values from db /////////////////////////////////: ' + data["TypeUser"]);
    });

  }

  @override
  void initState() {
    // print(user);
    islog();
    super.initState();
  }

  Future dowload(ref) async {
    final dir = await getApplicationCacheDirectory();
    final file = File('${dir.path}/${ref}');
    await ref.writeToFile(file);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Dowload ${ref}")));
  }


  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('emploiTemps')
      // .where('TypeUser', isEqualTo: "etudiant")
      // .orderBy("orderDate",descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emploi Du temps"),
      ),
      body: SafeArea(child:    StreamBuilder<QuerySnapshot>(
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
                              backgroundColor: const Color.fromARGB(255, 0, 68, 124),
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
                        trailing: Icon(Icons.download),
                        onTap: () {
                                       FileDownloader.downloadFile(
                      url:data["emploiPic"],
                      onProgress: (name, progress) {
                        setState(() {
                          // _progress = progress;
                        });
                      },
                      onDownloadCompleted: (value) {
                        print('path  $value ');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Dowload Complete ${value}")));
                        setState(() {
                          // _progress = null;
                        });
                      },
                      onDownloadError: (String error) {
                        print('DOWNLOAD ERROR: $error');
                      });
                        },
                        title: Text(data['emploiAbout']),
                      
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
   )
      
      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //           ElevatedButton(
      //           style: ButtonStyle(
      //               // backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))

      //               ),
      //           onPressed: () {
      //             // dowload(data["emploiPic"]);
      //             FileDownloader.downloadFile(
      //                 url:
      //                     data["emploiPic"].toString(),
      //                 onProgress: (name, progress) {
      //                   setState(() {
      //                     // _progress = progress;
      //                   });
      //                 },
      //                 onDownloadCompleted: (value) {
      //                   print('path  $value ');
      //                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //                       content: Text("Dowload Complete: ${value}")));
      //                   setState(() {
      //                     // _progress = null;
      //                   });
      //                 },
      //                 onDownloadError: (String error) {
      //                   print('DOWNLOAD ERROR: $error');
      //                 });
      //             print("//////////////////////////" + data["emploiPic"]);
      //           },
      //           child: Text("Telecharger emploi du temps")),
      //       ElevatedButton(
      //           style: ButtonStyle(
      //               // backgroundColor:  MaterialStateProperty.all(Color.fromRGBO(32, 48, 61, 1))

      //               ),
      //           onPressed: () {
      //              FileDownloader.downloadFile(
      //                 url:data2["coursPic"],
      //                 onProgress: (name, progress) {
      //                   setState(() {
      //                     // _progress = progress;
      //                   });
      //                 },
      //                 onDownloadCompleted: (value) {
      //                   print('path  $value ');
      //                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //                       content: Text("Dowload Complete ${value}")));
      //                   setState(() {
      //                     // _progress = null;
      //                   });
      //                 },
      //                 onDownloadError: (String error) {
      //                   print('DOWNLOAD ERROR: $error');
      //                 });
            
      //           },
      //           child: Text("Telecharger Les Cours")),
          
        
      //     ],
      //   ),
      // ),
   
   
    );
  }
}
