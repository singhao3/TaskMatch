import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmatch/auth.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() => MyCustomFormState();
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? phoneNumber;
  User? user = Auth().currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final uid = user?.uid;
    if (uid != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('task_seekers')
          .doc(uid)
          .get();
      final data = snapshot.data();
      if (data != null) {
        setState(() {
          username = data['name'] ?? '';
          phoneNumber = data['phoneNumber'] ?? '';
          _isLoading = false; 
        });
      }
      print('Username: $username'); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: _isLoading
          ? CircularProgressIndicator() // Show loading indicator while data is being fetched
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    initialValue: username ?? '', // Pass the username value as a String
                    readOnly: false,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.green),
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.green),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    style: TextStyle(color: Colors.green),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: user?.email,
                    readOnly: false,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email, color: Colors.green),
                      labelText: 'Email Address',
                      labelStyle: TextStyle(color: Colors.green),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    style: TextStyle(color: Colors.green),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: phoneNumber ?? '',
                    readOnly: false,
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone, color: Colors.green),
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: Colors.green),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
    );
  }
}
