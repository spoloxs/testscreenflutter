import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen();
  @override
  Widget build (BuildContext ctxt) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DATA PAGE"),
      ),
      body: StreamBuilder<List<User>>(
          stream: readUsers(),
          builder: (context, snapshot){
              if(snapshot.hasError){
                return Text("Had some error!!!");
              }
              else if(snapshot.hasData)
                {
                  final users = snapshot.data!;

                  return ListView(
                    children: users.map(buildUser).toList(),
                  );
                }
              else
                {
                  return Center(child: CircularProgressIndicator());
                }
          }),
    );
  }

  Widget buildUser(User user) => ListTile(
    leading: CircleAvatar(child: Text(user.name[0])),
    title: Text(user.name),
    subtitle: Text('${user.age}'),
  );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('user') //gets all collection
      .snapshots()  //gets all documents
      .map((snapshot) =>  //returns a query snapshot of map string dynamic so that we get some json data.
        snapshot.docs.map(((doc) => User.fromJson(doc.data()))).toList()); //first go to each document data then convert json data to user objects
}                                                                          //which gets converted to list data later.

class User{
  final String name;
  final int age;

  User({required this.name, required this.age});

  static User fromJson(Map<String, dynamic> json) => User(
    name: json['name'],
    age: json['age'],
  );
}