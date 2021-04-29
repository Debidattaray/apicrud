// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // Future<void>
//   Future<List<User>> getuserdata() async {
//     var response = await http.get(
//       Uri.https('jsonplaceholder.typicode.com', 'users'),
//     );
//     // print(response.body);

//     var jsonData = jsonDecode(response.body);

//     List<User> users = [];

//     for (var u in jsonData) {
//       User user = User(u["name"], u["email"], u["username"]);
//       users.add(user);
//     }
//     print(users);
//     return users;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Card(
//           child: FutureBuilder(
//             future: getuserdata(),
//             builder: (context, AsyncSnapshot snapshot) {
//               if (snapshot.data == null) {
//                 return Container(
//                   child: Center(
//                     child: Text("Loading"),
//                   ),
//                 );
//               } else
//                 return ListView.builder(
//                     itemCount: snapshot.data.length,
//                     // itemCount: snapshot.data == null ? 0 : snapshot.data.length,
//                     itemBuilder: (context, i) {
//                       return ListTile(title: Text(snapshot.data[i].name)
//                           // title: Text(snapshot.data[i].n),
//                           );
//                     });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class User {
//   final String name, email, username;

//   User(this.name, this.email, this.username);
// }

// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<Album> fetchAlbum() async {
//   final response =
//       await http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/1'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// class Album {
//   final int userId;
//   final int id;
//   final String title;

//   Album(this.userId,  this.id,  this.title);

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//        json['userId'],
//        json['id'],
//        json['title'],
//     );
//   }
// }

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   // MyApp({Key key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late Future<Album> futureAlbum;

//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchAlbum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Fetch Data Example'),
//         ),
//         body: Center(
//           child: FutureBuilder<Album>(
//             future: futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Text(snapshot.data!.title);
//               } else if (snapshot.hasError) {
//                 return Text("${snapshot.error}");
//               }

//               // By default, show a loading spinner.
//               return CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//

import 'dart:convert';
// import 'dart:ffi';

import 'package:apicrud/datamodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// Future<Album> createAlbum(String title) async {
//   final response = await http.post(
//     Uri.https('jsonplaceholder.typicode.com', 'albums'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );
//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

Future<DataModel> submitData(String name, String job) async {
  final response = await http.post(Uri.https("reqres.in", "api/users"),
      // headers: <String, String>{
      // 'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: {'name': name, 'job': job});
  var data = response.body;
  print(data);

  if (response.statusCode == 201) {
    String responseString = response.body;
    return dataModelFromJson(responseString);
  } else {
    throw Exception('Failed to load album');
  }
}

TextEditingController nameController = TextEditingController();
TextEditingController jobController = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  late DataModel _dataModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                  hintText: "Enter Text",
                ),
                controller: nameController,
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                  hintText: "Enter job",
                ),
                controller: jobController,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  String name = nameController.text;
                  String job = jobController.text;

                  DataModel data = await submitData(name, job);

                  setState(() {
                    _dataModel = data;
                  });
                },
                child: Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
