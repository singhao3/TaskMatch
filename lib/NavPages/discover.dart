import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmatch/util/discovergrid.dart';
import 'package:rxdart/rxdart.dart';


class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  late TextEditingController _searchController;
  late Stream<QuerySnapshot> _searchResultsStream;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchResultsStream = FirebaseFirestore.instance
        .collection('tasks')
        .snapshots();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _startSearch() {
  String searchTerm = _searchController.text.trim();
  if (searchTerm.isNotEmpty) {
    setState(() {
      String searchTermEnd = searchTerm + 'z';

      // Query for 'title' field
      var titleQuery = FirebaseFirestore.instance
          .collection('tasks')
          .where('title', isGreaterThanOrEqualTo: searchTerm)
          .where('title', isLessThan: searchTermEnd)
          .snapshots();

      // Query for 'description' field
      var descriptionQuery = FirebaseFirestore.instance
          .collection('tasks')
          .where('description', isGreaterThanOrEqualTo: searchTerm)
          .where('description', isLessThan: searchTermEnd)
          .snapshots();

      // Merge the results of both queries
      _searchResultsStream = Rx.merge([titleQuery, descriptionQuery]);
    });
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _startSearch,
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _searchResultsStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

                if (documents.isEmpty) {
                  return Center(child: Text('No results found'));
                }

                return DiscoverGrid(documents: documents);
              },
            ),
          ),
        ],
      ),
    );
  }
}
