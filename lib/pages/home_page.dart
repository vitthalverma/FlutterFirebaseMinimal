import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_minimal/read%20data/get_user_name.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  //documents IDs
  List<String> docIDs = [];

  Future getDocID() async {
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy('age', descending: true)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            // print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        actions: [
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: const Icon(Icons.logout_rounded)),
        ],
        title: Text(
          'Signed in as ${user?.email}',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDocID(),
                builder: ((context, snapshot) {
                  return ListView.builder(
                    itemCount: docIDs.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ListTile(
                          tileColor: Colors.grey.shade400,
                          title: GetUserName(documentID: docIDs[index]),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
