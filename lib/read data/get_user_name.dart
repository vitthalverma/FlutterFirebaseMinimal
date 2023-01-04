import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  const GetUserName({super.key, required this.documentID});
  final String documentID;

  @override
  Widget build(BuildContext context) {
    //get the collection

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentID).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
              '${data['first name']} ${data['last name']}, ${data['age']} years old');
        }
        return const Text('loading...');
      }),
    );
  }
}
