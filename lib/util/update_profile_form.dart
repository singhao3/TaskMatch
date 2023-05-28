// import 'package:flutter/material.dart';

// class UpdateProfile extends StatefulWidget {
//   const UpdateProfile({super.key});

//   @override
//   State<UpdateProfile> createState() => _UpdateProfileState();
// }

// class _UpdateProfileState extends State<UpdateProfile> {
//   //const UpdateProfile({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('TaskMatch'),
//         backgroundColor: Colors.green,
//       ),
//       body: Container(
//         color: Colors.green,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 const Text(
//                   'Update Profile',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 const Spacer(),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(
//                         color: Colors.white,
//                         width: 2.0,
//                       ),
//                       borderRadius:
//                           const BorderRadius.all(Radius.circular(10.0)),
//                     ),
//                     child: const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         'Task-seekers',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             const Flexible(
//               child: MyCustomForm(),
//             ),
//             const SizedBox(height: 20),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (BuildContext context) {
//                           return const UpdateProfile();
//                         },
//                       ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.black,
//                     backgroundColor: Colors.white,
//                   ),
//                   child: const Text('Update'),
//                 ),
//                 const SizedBox(height: 10),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MyCustomForm extends StatefulWidget {
//   const MyCustomForm({Key? key}) : super(key: key);

//   @override
//   MyCustomFormState createState() {
//     return MyCustomFormState();
//   }
// }

// class MyCustomFormState extends State<MyCustomForm> {
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           TextFormField(
//             decoration: const InputDecoration(
//               icon: Icon(Icons.android, color: Colors.white),
//               hintText: 'Enter your user ID',
//               labelText: 'UserID',
//               labelStyle: TextStyle(color: Colors.white),
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//             ),
//           ),
//           TextFormField(
//             decoration: const InputDecoration(
//               icon: Icon(Icons.person, color: Colors.white),
//               hintText: 'Enter your name',
//               labelText: 'Name',
//               labelStyle: TextStyle(color: Colors.white),
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//             ),
//           ),
//           TextFormField(
//             decoration: const InputDecoration(
//               icon: Icon(Icons.email, color: Colors.white),
//               hintText: 'Enter your email address',
//               labelText: 'Email Address',
//               labelStyle: TextStyle(color: Colors.white),
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//             ),
//           ),
//           TextFormField(
//             decoration: const InputDecoration(
//               icon: Icon(Icons.password, color: Colors.white),
//               hintText: 'Enter your password',
//               labelText: 'Password',
//               labelStyle: TextStyle(color: Colors.white),
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//             ),
//           ),
//           TextFormField(
//             decoration: const InputDecoration(
//               icon: Icon(Icons.password, color: Colors.white),
//               hintText: 'Reenter your password',
//               labelText: 'Confirm Password',
//               labelStyle: TextStyle(color: Colors.white),
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.white),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }