import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<String> wishlistItems = [
    'Project 1',
    'Project 2',
    'Project 3',
    'Project 4',
    'Project 5',
  ]; // Sample wishlist items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final wishlistItem = wishlistItems[index];
          return ListTile(
            title: Text(wishlistItem),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  wishlistItems.removeAt(index);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
