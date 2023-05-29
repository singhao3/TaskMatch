import 'package:flutter/material.dart';
import 'package:taskmatch/pages/taskseeker/taskseeker_homepage.dart';
import 'package:taskmatch/pages/taskdoer/taskdoer_homepage.dart';
import 'package:taskmatch/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:taskmatch/pages/task_doer_home_page.dart';
// import 'package:taskmatch/pages/task_seeker_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskMatch',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WidgetTree(),
        '/taskdoerhome': (context) => const TaskDoerHome(),
        '/taskseekerhome': (context) => const TaskSeekerHome(),
      },
    );
  }
}
