

// import 'package:flutter/material.dart';

// class MyCustomForm extends StatefulWidget {
//   const MyCustomForm({Key? key}) : super(key: key);

//   @override
//   MyCustomFormState createState() => MyCustomFormState();
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
//             decoration: InputDecoration(
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
//             style: TextStyle(color: Colors.white),
//           ),
//           SizedBox(height: 16),
//           TextFormField(
//             decoration: InputDecoration(
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
//             style: TextStyle(color: Colors.white),
//           ),
//           SizedBox(height: 16),
//           TextFormField(
//             decoration: InputDecoration(
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
//             style: TextStyle(color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class MyCustomForm extends StatefulWidget {
//   const MyCustomForm({Key? key}) : super(key: key);

//   @override
//   MyCustomFormState createState() => MyCustomFormState();
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
//             decoration: InputDecoration(
//               icon: Icon(Icons.android, color: Colors.green), // Set the icon color to green
//               hintText: 'Enter your user ID',
//               labelText: 'UserID',
//               labelStyle: TextStyle(color: Colors.green), // Set the label text color to green
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.green), // Set the underline color to green
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.green), // Set the focused underline color to green
//               ),
//             ),
//             style: TextStyle(color: Colors.green), // Set the text color to green
//           ),
//           SizedBox(height: 16),
//           TextFormField(
//             decoration: InputDecoration(
//               icon: Icon(Icons.person, color: Colors.green),
//               hintText: 'Enter your name',
//               labelText: 'Name',
//               labelStyle: TextStyle(color: Colors.green),
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.green),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.green),
//               ),
//             ),
//             style: TextStyle(color: Colors.green),
//           ),
//           SizedBox(height: 16),
//           TextFormField(
//             decoration: InputDecoration(
//               icon: Icon(Icons.email, color: Colors.green),
//               hintText: 'Enter your email address',
//               labelText: 'Email Address',
//               labelStyle: TextStyle(color: Colors.green),
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.green),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Colors.green),
//               ),
//             ),
//             style: TextStyle(color: Colors.green),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() => MyCustomFormState();
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container( // Wrap the form in a container with white background color
      color: Colors.white, // Set the background color to white
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.android, color: Colors.green),
                hintText: 'Enter your user ID',
                labelText: 'UserID',
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
              decoration: InputDecoration(
                icon: Icon(Icons.person, color: Colors.green),
                hintText: 'Enter your name',
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
              decoration: InputDecoration(
                icon: Icon(Icons.email, color: Colors.green),
                hintText: 'Enter your email address',
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
          ],
        ),
      ),
    );
  }
}
