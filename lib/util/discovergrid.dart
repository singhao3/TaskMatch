// import 'package:flutter/material.dart';

// class discovergrid extends StatelessWidget {
//   const discovergrid({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 10,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Card(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Project Name $index',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'Description $index',
//                           style: TextStyle(fontSize: 14),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'UNiversity name $index',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Text(
//                     '\$10.00',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class DiscoverGrid extends StatelessWidget {
//   const DiscoverGrid({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 10,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Card(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Project Name $index',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'Description $index',
//                           style: TextStyle(fontSize: 14),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'University name $index',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Text(
//                     '\$10.00',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: Colors.green,
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.favorite_border),
//                     onPressed: () {
//                       // TODO: Add project to wishlist
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class DiscoverGrid extends StatelessWidget {
//   const DiscoverGrid({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 10,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Card(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Project Name $index',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'Description $index',
//                           style: TextStyle(fontSize: 14),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'University name $index',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Text(
//                     '\$10.00',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: Colors.green,
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.favorite_border),
//                     onPressed: () {
//                       // Add the item to the wishlist
//                       // You can implement your desired logic here
//                       // For simplicity, let's just print a message
//                       print('Added to wishlist: Project $index');
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

class DiscoverGrid extends StatefulWidget {
  const DiscoverGrid({Key? key});

  @override
  _DiscoverGridState createState() => _DiscoverGridState();
}

class _DiscoverGridState extends State<DiscoverGrid> {
  List<bool> isFavoriteList = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Project Name $index',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Description $index',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'University name $index',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$10.00',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: isFavoriteList[index] ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavoriteList[index] = !isFavoriteList[index];
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
