
// import 'package:flutter/material.dart';
// import 'package:taskmatch/pages/profilepage/update_profile_page.dart';
// import 'package:taskmatch/util/profilegrid.dart';

// class RootPage extends StatelessWidget {
//   const RootPage({Key? key}) : super(key: key);

//   void navigateToUpdateProfile(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (BuildContext context) => const UpdateProfile(),
//       ),
//     );
//   }

//   Widget buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: 'Search...',
//           prefixIcon: const Icon(Icons.search, color: Colors.white),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16.0),
//           ),
//           contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
//           filled: true,
//           fillColor: Colors.white,
//           hintStyle: TextStyle(color: Colors.grey),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('TaskMatch'),
//         backgroundColor: Colors.white,
//       ),
//       body: Container(
//         color: Colors.green,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(height: 20),
//             Row(
//               children: [
//                 Text(
//                   'Profile',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const Spacer(),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(
//                         color: Colors.white,
//                         width: 2.0,
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         'Task-seekers',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: buildSearchBar(),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       MyCustomForm(),
//                       SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: () => navigateToUpdateProfile(context),
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
//                           primary: Colors.white,
//                           onPrimary: Colors.black,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                         ),
//                         child: const Text('Update Profile'),
//                       ),
//                       SizedBox(height: 10),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (BuildContext context) => const ChangePassword(),
//                             ),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
//                           primary: Colors.white,
//                           onPrimary: Colors.black,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                         ),
//                         child: const Text('Change Password'),
//                       ),
//                       SizedBox(height: 10),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:taskmatch/pages/profilepage/changepassword.dart';
import 'package:taskmatch/pages/profilepage/customform.dart';
import 'package:taskmatch/pages/profilepage/update_profile_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  void navigateToUpdateProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const UpdateProfile(),
      ),
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('TaskMatch'),
      //   backgroundColor: Colors.black,
      // ),
      body: Container(
        color: Colors.white, // Set the background color to white
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Set the text color to black
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Task-seekers',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 20),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: buildSearchBar(),
            // ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyCustomForm(),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => navigateToUpdateProfile(context),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                          primary: Colors.green, // Set the button color to green
                          onPrimary: Colors.white, // Set the text color to white
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Update Profile'),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => const ChangePassword(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                          primary: Colors.green, // Set the button color to green
                          onPrimary: Colors.white, // Set the text color to white
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Change Password'),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
