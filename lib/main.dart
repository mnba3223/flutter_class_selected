import 'package:class_selected/database/database_helper.dart';
import 'package:class_selected/model/model.dart';
import 'package:class_selected/view/teacherList.dart';
import 'package:class_selected/view/teacherList_sqlite_api.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teacher Course System',
      // theme: ThemeData(
      //   appBarTheme: AppBarTheme(elevation: 0),
      // ),
      // home: TeacherListView(),
      home: TeacherListView_v2(),
    );
  }
}


// class MyHomePage_v2 extends StatefulWidget {
//   @override
//   _MyHomePage_v2State createState() => _MyHomePage_v2State();
// }

// class _MyHomePage_v2State extends State<MyHomePage_v2> {
//   final dbHelper = DatabaseHelper.instance;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('SQLite Demo'),
//       ),
//       body: FutureBuilder<List<Teacher>>(
//         future: dbHelper.fetchTeachers(),
//         builder: (context, snapshot) {
//           print(snapshot.connectionState);
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             }

//             final teachers = snapshot.data;

//             return ListView.builder(
//               itemCount: teachers!.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(teachers[index].name),
//                   subtitle: Text(teachers[index].bio),
//                 );
//               },
//             );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
