import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RatingPage extends StatefulWidget {
  final String taskId;

  const RatingPage({Key? key, required this.taskId}) : super(key: key);

  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double communicationRating = 0;
  double efficiencyRating = 0;
  double overallRating = 0;

  void submitRating() {
    FirebaseFirestore.instance
        .collection('task_ratings')
        .where('taskId', isEqualTo: widget.taskId)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isEmpty) {
        // No existing rating record, add a new rating
        FirebaseFirestore.instance.collection('task_ratings').add({
          'taskId': widget.taskId,
          'communication': communicationRating,
          'efficiency': efficiencyRating,
          'overall': overallRating,
        });
      } else {
        // Existing rating record found, update the existing rating
        final ratingId = snapshot.docs[0].id;
        FirebaseFirestore.instance
            .collection('task_ratings')
            .doc(ratingId)
            .update({
          'communication': communicationRating,
          'efficiency': efficiencyRating,
          'overall': overallRating,
        });
      }
    });

    // Navigate back to the task details page or perform any other action.
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate Performance'),
      ),
      body: Column(
        children: [
          Text('Communication'),
          Slider(
            value: communicationRating,
            onChanged: (value) {
              setState(() {
                communicationRating = value;
              });
            },
            min: 0,
            max: 5,
            divisions: 5,
            label: communicationRating.toStringAsFixed(1),
          ),
          Text('Efficiency'),
          Slider(
            value: efficiencyRating,
            onChanged: (value) {
              setState(() {
                efficiencyRating = value;
              });
            },
            min: 0,
            max: 5,
            divisions: 5,
            label: efficiencyRating.toStringAsFixed(1),
          ),
          Text('Overall'),
          Slider(
            value: overallRating,
            onChanged: (value) {
              setState(() {
                overallRating = value;
              });
            },
            min: 0,
            max: 5,
            divisions: 5,
            label: overallRating.toStringAsFixed(1),
          ),
          ElevatedButton(
            onPressed: submitRating,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
