import 'package:flutter/material.dart';
import 'package:taskmatch/util/historygrid.dart';

class history extends StatelessWidget {
  const history({super.key});
@override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: HistoryGrid(),
    );
  }
}