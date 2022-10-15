import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

Future main() async {
//start of firebase connection
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //end firebase connection

  runApp(const MyApp());
  var coID = await AddParent();
  AddStudent(coID);
  //validateEmail();
}

AddStudent(colID) {
  final userRef = FirebaseFirestore.instance.collection("Parent");
  userRef.doc(colID).collection("Studet").add({
    "BloodType": "lamaalmajhad",
    "Class": "lamaalmajhad@outlook.com",
    "Name": "lama school",
    "Nationality": "False",
    "StudentID": "first student",
    "UserName": "سعودي",
  });
}

AddParent() async {
  final userRef = FirebaseFirestore.instance.collection("Parent");
  var colectionID = await userRef.add({
    "Email": "leen@outlook.com",
    "JobTitle": "lama school",
    "LateStatus": "False",
    "Name": "renad",
    "Nationality": "سعودي",
    "ParentID": "P1",
    "Password": "123456",
    "PhoneNumber": "0554662852",
    "UserName": "RenadAlbesher12345",
  });
  return colectionID.id;
}

//////////////this for email validation
/*
void validateEmail() {
  final bool isValid = EmailValidator.validate("lamaalmajhad@outlook.com");

  if (isValid) {
    ScaffoldMessenger.of(context)
        .showSnackBar((snackBar(content: Text("Valid Email"))));
  }
}
*/
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    //here is a code for testing the connection with firebase only
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => FirebaseFirestore.instance
              .collection('testing')
              .add({'timestamp': Timestamp.fromDate(DateTime.now())}),
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('testing').snapshots(),
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (!snapshot.hasData) return const SizedBox.shrink();
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final docData = snapshot.data?.docs[index];
                final dateTime = (docData!['timestamp'] as Timestamp).toDate();
                return ListTile(
                  title: Text(dateTime.toString()),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
//here is the end for testing the connection with firebase

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
