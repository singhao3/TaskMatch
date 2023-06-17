import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class TaskSeekerPage extends StatefulWidget {
  const TaskSeekerPage({Key? key}) : super(key: key);

  @override
  _TaskSeekerPageState createState() => _TaskSeekerPageState();
}

class _TaskSeekerPageState extends State<TaskSeekerPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference taskWatchlistRef = FirebaseFirestore.instance.collection('task_watchlist');
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  List<String> watchlistTasks = [];

  @override
  void initState() {
    super.initState();
    // Fetch the watchlist tasks for the current user
    fetchWatchlistTasks();

    // Request FCM permission
    _requestNotificationPermission();

    // Get FCM token
    _firebaseMessaging.getToken().then((token) {
      if (token != null) {
        // Save the token to the task_seeker document in Firestore
        final taskSeekerDocRef = FirebaseFirestore.instance.collection('task_seekers').doc(user?.uid);
        taskSeekerDocRef.update({
          'notificationTokens': FieldValue.arrayUnion([token]),
        });
      }
    });

    // Configure Firebase Messaging foreground callbacks
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground message
      print('Handling a foreground message: ${message.messageId}');
      // Check if the notification is for a task application
      if (message.data['type'] == 'taskApplication') {
        // Extract task information from the message
        final taskId = message.data['taskId'];
        final taskTitle = message.data['taskTitle'];

        // Show a notification dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('New Task Application'),
            content: Text('Your task "$taskTitle" (ID: $taskId) has a new application!'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle when the app is in the foreground and the user taps on the notification
      print('Handling a foreground message with notification: ${message.messageId}');
    });
  }

  Future<void> _requestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  Future<void> fetchWatchlistTasks() async {
    final uid = user?.uid;
    if (uid != null) {
      final snapshot = await taskWatchlistRef.doc(uid).get();
      final data = snapshot.data() as Map<String, dynamic>; // Specify the type of 'data'
      if (data != null) {
        setState(() {
          watchlistTasks = List<String>.from(data['tasks'] ?? []);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Seeker Page'),
      ),
      body: ListView.builder(
        itemCount: watchlistTasks.length,
        itemBuilder: (context, index) {
          final taskId = watchlistTasks[index];
          return ListTile(
            title: Text('Task ID: $taskId'),
          );
        },
      ),
    );
  }
}
