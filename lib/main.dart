import 'package:flutter/material.dart';
import 'package:testscreenflutter/sndscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testscreenflutter/splashscreen.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Splashscreen());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Screen',
      theme: ThemeData(
      ),
      home: const FirstScreen(title: 'Search Bar'),
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key, required this.title});
  final String title;

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  int idnum = 1;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      appBar: AppBar(
        shadowColor: Colors.white30,
        backgroundColor: Colors.black,
        // Here we take the value from the FirstScreen object that was created by
        // the App.build method, and use it to set our appbar title.
        centerTitle: true,
        title: Text(widget.title,
            textScaleFactor: 1.5,
            style: const TextStyle(
              shadows: <Shadow>[
              Shadow(offset: Offset(3.0, 7.0),
                blurRadius: 9.0,
                color: Color.fromARGB(80, 255, 255, 255)
              ),
              ],
        ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
          width: 500,
          child: TextField(
            controller: myController,
            style: const TextStyle(color: Colors.yellow),
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white10,
              hintStyle: TextStyle(color: Colors.white30),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 3, color: Colors.white12)),
              hintText: 'Enter a search term',
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ),
      ],
      ),
      floatingActionButton: Column(mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: (){
            final name = myController.text;
            createuser(name: name);
            idnum++;
          },
          backgroundColor: Color(0xFF303030),
          tooltip: 'Click to add data',
          child: const Icon(Icons.add),
      ),
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondScreen())
            );
          },
          backgroundColor: Color(0xFF303030),
          tooltip: 'Click to search',
          child: const Icon(Icons.search),
      ),
      ]
    )
    );
  }
  Future createuser({required String name}) async{
        final docUser = FirebaseFirestore.instance.collection('user').doc(name);

        final json = {
          'name': name,
          'age': 21,
        };

        await docUser.set(json);
  }
}