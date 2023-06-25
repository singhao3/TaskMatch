import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationGridTaskSeeker extends StatelessWidget {
  final String userName;
  final String latitude;
  final String longitude;
  final String address;
  final List<String> taskDoerIds;

  LocationGridTaskSeeker({
    required this.userName,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.taskDoerIds,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Doer IDs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildUserName(),
            SizedBox(height: 8),
            buildLatitude(),
            SizedBox(height: 8),
            buildLongitude(),
            SizedBox(height: 8),
            buildAddress(),
            SizedBox(height: 24),
            buildTaskDoerIDs(),
          ],
        ),
      ),
    );
  }

  Widget buildUserName() {
    return Text(
      'User Name: $userName',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget buildLatitude() {
    return Text(
      'Latitude: $latitude',
      style: TextStyle(fontSize: 18),
    );
  }

  Widget buildLongitude() {
    return Text(
      'Longitude: $longitude',
      style: TextStyle(fontSize: 18),
    );
  }

  Widget buildAddress() {
    return Text(
      'Address: $address',
      style: TextStyle(fontSize: 18),
    );
  }

  Widget buildTaskDoerIDs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Task Doer IDs:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: taskDoerIds.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(taskDoerIds[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class LocationTaskSeeker extends StatelessWidget {
  const LocationTaskSeeker({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Data'),
        centerTitle: true, // Center the title
      ),
      body: buildLocationDataStream(),
    );
  }

  Widget buildLocationDataStream() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('locations').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
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

            return buildLocationCard(data);
          },
        );
      },
    );
  }

  Widget buildLocationCard(Map<String, dynamic> data) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2, // Add a subtle shadow
      child: ListTile(
        title: Text(
          data['userName'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text('Latitude: ${data['latitude']}'),
            SizedBox(height: 4),
            Text('Longitude: ${data['longitude']}'),
            SizedBox(height: 4),
            Text('Address: ${data['address']}'),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }


}

