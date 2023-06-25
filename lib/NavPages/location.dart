import 'package:flutter/material.dart';
import 'package:taskmatch/util/locationgrid.dart';

class locationtaskdoer extends StatelessWidget {
  const locationtaskdoer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: LocationGrid(),
    );
  }
}