
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var faker = new Faker();
    for (int i =0 ; i<100 ; i++) {
      users..add({
      'full_name': faker.person.name(), // John Doe
      'company': faker.company.name(), // Stokes and Sons
      'age': faker.randomGenerator.integer(99) // 42
      })
          .then((value) => print("User Added " + value.id))
          .catchError((error) => print("Failed to add user: $error"));
    }


    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: UserInformation(),
        ),
      ),
    );
  }
}

class UserInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['full_name']),
              subtitle: new Text(document.data()['company']),
            );
          }).toList(),
        );
      },
    );
  }
}