import 'package:flutter/material.dart';
import 'package:taskmatch/util/discovergrid.dart';

class discover extends StatelessWidget {
  const discover({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: discovergrid(),
    );
  }
}