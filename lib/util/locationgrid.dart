import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmatch/NavPages/locationtaskseeker.dart';
import 'locationgridtaskseeker.dart';

class MessageGridController extends GetxController {
  var latitude = 'Getting Latitude..'.obs;
  var longitude = 'Getting Longitude..'.obs;
  var address = 'Getting Address..'.obs;
  late StreamSubscription<Position> streamSubscription;

  @override
  void onClose() {
    streamSubscription.cancel();
    super.onClose();
  }

  void getLocation() async {
    bool serviceEnabled;

    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      latitude.value = 'Latitude: ${position.latitude}';
      longitude.value = 'Longitude: ${position.longitude}';
      getAddressFromLatLang(position);
    });
  }

  Future<void> getAddressFromLatLang(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    address.value = 'Address: ${place.locality}, ${place.country}';
  }
}

class LocationGrid extends StatelessWidget {
  final messageGrid = Get.put(MessageGridController());
  final TextEditingController nameController = TextEditingController();

  void submitLocation(BuildContext context) {
    String userName = nameController.text;
    String latitude = messageGrid.latitude.value;
    String longitude = messageGrid.longitude.value;
    String address = messageGrid.address.value;

    FirebaseFirestore.instance
        .collection('locations')
        .add({
      'userName': userName,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    })
        .then((value) => FirebaseFirestore.instance
        .collection('taskdoer')
        .get()
        .then((querySnapshot) {
      List<String> documentIds = [];
      querySnapshot.docs.forEach((doc) {
        documentIds.add(doc.id);
      });

      // Show snackbar message to indicate completion
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location submitted successfully.'),
        ),
      );

      // Navigate to the desired screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LocationTaskSeeker(),
        ),
      );
    })
        .catchError((error) => print("Failed to fetch task doer IDs: $error")))
        .catchError((error) => print("Failed to submit location: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Display'),
        backgroundColor: Colors.green, // Set app bar background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
              ),
            ),

            SizedBox(height: 16),
            Obx(() {
              return Text(
                messageGrid.latitude.value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),

            SizedBox(height: 16),
            Obx(() {
              return Text(
                messageGrid.longitude.value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),

            SizedBox(height: 16),
            Obx(() {
              return Text(
                messageGrid.address.value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                messageGrid.getLocation();
              },
              child: Text('Get Location'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                primary: Colors.green, // Set button background color
                onPrimary: Colors.white, // Set button text color
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => submitLocation(context),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
                primary: Colors.green, // Set button background color
                onPrimary: Colors.white, // Set button text color
              ),
              child: Text(
                'Submit',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}






