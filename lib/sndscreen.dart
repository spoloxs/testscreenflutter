import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SecondScreen extends StatelessWidget {
  final myController1 = TextEditingController();

  SecondScreen();
  @override
  Widget build (BuildContext ctxt) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DATA PAGE"),
      ),
      body:Column(
          children: <Widget>[
            SizedBox(
              width: 500,
              child: TextField(
                controller: myController1,
                style: const TextStyle(color: Colors.red),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.black12,
                  hintStyle: TextStyle(color: Colors.black38),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 3, color: Colors.white12)),
                  hintText: 'Enter the name to delete...',
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            Expanded (child: StreamBuilder<List<User>>(
            stream: readUsers(),
            builder: (context, snapshot){
              if(snapshot.hasError){
                return Text("Had some error!!!");
              }
              else if(snapshot.hasData)
                {
                  final users = snapshot.data!;

                  return (
                      ListView(
                    children: users.map(buildUser).toList(),
                  ));
                }
              else
                {
                  return Center(child: CircularProgressIndicator());
                }
          },
        ))]),
      floatingActionButton: Column(mainAxisAlignment: MainAxisAlignment.end,
          children: [
          FloatingActionButton(
          onPressed: (){
                final docUser = FirebaseFirestore.instance
                    .collection('user')
                    .doc('${myController1.text}');

                docUser.delete();
            },
              backgroundColor: Color(0xFF303030),
              tooltip: 'Click to delete data',
              child: const Icon(Icons.minimize),
            )],
            )
    );
  }

  Widget buildUser(User user) => ListTile(
    leading: CircleAvatar(child: Text(user.name[0])),
    title: Text(user.name),
    subtitle: Text('${user.age}'),
    onTap: (){myController1.text = user.name;},
  );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('user') //gets all collection
      .orderBy('name', descending: true)
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