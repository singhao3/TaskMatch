import 'package:flutter/material.dart';
import 'package:taskmatch/util/homegrid.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: homegrid(),
    );
  }
}