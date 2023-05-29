//taskdoer_home.dart
import 'package:flutter/material.dart';
import 'package:taskmatch/util/homegrid_taskdoer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightGreen[400]!,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 5.0), 
              Center(
                child: Text(
                  'Explore Your Tasks', 
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.0), 
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                    padding: const EdgeInsets.all(12.0), // Decreased padding
                    child: Discovergrid(),
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
