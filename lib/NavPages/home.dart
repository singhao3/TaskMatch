import 'package:flutter/material.dart';

import '../util/homegrid.dart';

// class home extends StatelessWidget {
//   const home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       body: homegrid(),
//     );
//   }
// }
class home extends StatelessWidget {
  const home({Key? key});

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
      
  //     body: Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: [
  //           Text(
  //             'Welcome to TaskMatch',
  //             style: TextStyle(
  //               fontSize: 24,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           SizedBox(height: 24),
  //           Expanded(
  //             child: homegrid(),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightGreen,
              Colors.white30,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 80.0),
              Text(
                'Welcome to TaskMatch',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto', 
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48.0),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: homegrid(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}