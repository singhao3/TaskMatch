import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmatch/util/discovergrid.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DiscoverState createState() => _DiscoverState();
}

enum SearchOption {
  Title,
  Description,
}

class _DiscoverState extends State<Discover> {
  late TextEditingController _searchController;
  late SearchOption _searchOption;
  late Stream<QuerySnapshot> _searchResultsStream;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchOption = SearchOption.Title; // Default search option
    _searchResultsStream =
        FirebaseFirestore.instance.collection('tasks').snapshots();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _startSearch() {
    String searchTerm = _searchController.text.trim();
    if (searchTerm.isNotEmpty) {
      // Perform the search
      setState(() {
        String searchTermEnd = searchTerm + 'z';

        // Perform search based on the selected option
        switch (_searchOption) {
          case SearchOption.Title:
            _searchResultsStream = FirebaseFirestore.instance
                .collection('tasks')
                .where('title', isGreaterThanOrEqualTo: searchTerm.toLowerCase())
                .where('title', isLessThanOrEqualTo: searchTermEnd.toLowerCase())
                .snapshots();
            break;
          case SearchOption.Description:
            _searchResultsStream = FirebaseFirestore.instance
                .collection('tasks')
                .where('description', isGreaterThanOrEqualTo: searchTerm.toLowerCase())
                .where('description', isLessThanOrEqualTo: searchTermEnd.toLowerCase())
                .snapshots();
            break;
        }
      });
    } else {
      // Reset the search results stream to the default query
      setState(() {
        _searchResultsStream =
            FirebaseFirestore.instance.collection('tasks').snapshots();
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _startSearch,
                ),
                DropdownButton<SearchOption>(
                  value: _searchOption,
                  onChanged: (SearchOption? newValue) {
                    setState(() {
                      _searchOption = newValue!;
                    });
                  },
                  items: const [
                    DropdownMenuItem<SearchOption>(
                      value: SearchOption.Title,
                      child: Text('Search Title'),
                    ),
                    DropdownMenuItem<SearchOption>(
                      value: SearchOption.Description,
                      child: Text('Search Description'),
                    ),
                  ],
                ),
              ],
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
                  return const CircularProgressIndicator();
                }

                List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

                if (documents.isEmpty) {
                  return const Center(child: Text('No results found'));
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

