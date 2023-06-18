import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmatch/NavPages/discover.dart';
import 'package:taskmatch/NavPages/history.dart';
import 'package:taskmatch/pages/taskdoer/taskdoer_home.dart';
import 'package:taskmatch/NavPages/message.dart';
import 'package:taskmatch/NavPages/profile.dart';
import 'package:taskmatch/auth.dart';
import 'package:flutter/material.dart';

class TaskDoerHome extends StatefulWidget {
  const TaskDoerHome({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TaskDoerHomeState createState() => _TaskDoerHomeState();
}

class _TaskDoerHomeState extends State<TaskDoerHome> {
  final User? user = Auth().currentUser;
  String? username;

  @override
  void initState() {
    super.initState();
    fetchUsername(); 
  }

  Future<void> fetchUsername() async {
    final uid = user?.uid;
    if (uid != null) {
      final snapshot =
          await FirebaseFirestore.instance.collection('task_doers').doc(uid).get();
      final data = snapshot.data();
      if (data != null) {
        setState(() {
          username = data['name'] ?? ''; 
        });
      }
    }
  }

  Future<void> signOut() async {
    await Auth().signOut();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 2;

  static const List<Widget> _widgetOptions = <Widget>[
    Discover(),
    history(),
    Home(),
    message(),
    profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Row(
          children: const [
            Text(
              'TaskMatch',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: username != null
                        ? Text(username!) 
                        : const Text('Loading...'), 
                    accountEmail: Text(user?.email ?? 'User email'),
                    currentAccountPicture: const CircleAvatar(
                      backgroundImage: AssetImage('images/user.png'),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      // Handle navigation to home page
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () {
                      // Handle navigation to profile page
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () {
                      // Handle navigation to settings page
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.question_answer),
                    title: const Text('FAQ'),
                    onTap: () {
                      // Handle navigation to FAQ page
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text('About Us'),
                    onTap: () {
                      // Handle navigation to FAQ page
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                children: [
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Sign Out'),
                    onTap: signOut,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _selectedIndex == 2
                ? Column(
                    children: [
                      
                      Expanded(
                        child: _widgetOptions.elementAt(_selectedIndex),
                      ),
                    ],
                  )
                : _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
