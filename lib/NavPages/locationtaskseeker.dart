import 'package:flutter/material.dart';
import 'package:taskmatch/util/locationgrid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../util/locationgridtaskseeker.dart';

class locationtaskseeker extends StatelessWidget {
  const locationtaskseeker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: LocationData(),
    );
  }
}


class LocationData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Data'),
        backgroundColor: Colors.green, // Set app bar background color
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('locations').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data =
                  documents[index].data() as Map<String, dynamic>;

              return Card(
                elevation: 2, // Add elevation to the card for a raised effect
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                    data['userName'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(
                        'Latitude: ${data['latitude']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Longitude: ${data['longitude']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Address: ${data['address']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

