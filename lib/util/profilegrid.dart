import 'package:flutter/material.dart';

class ProfileDashboard extends StatelessWidget {
  const ProfileDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildGridItem(
                    icon: Icons.person,
                    title: 'Personal Info',
                    color: Colors.lightGreen[300]!,
                    onTap: () {
                      // TODO: Implement navigation to personal info page
                    },
                  ),
                  _buildGridItem(
                    icon: Icons.work,
                    title: 'Work Experience',
                    color: Colors.lightBlue[300]!,
                    onTap: () {
                      // TODO: Implement navigation to work experience page
                    },
                  ),
                  _buildGridItem(
                    icon: Icons.school,
                    title: 'Education',
                    color: Colors.orange[300]!,
                    onTap: () {
                      // TODO: Implement navigation to education page
                    },
                  ),
                  _buildGridItem(
                    icon: Icons.favorite,
                    title: 'Favourite',
                    color: Colors.pink[300]!,
                    onTap: () {
                      // TODO: Implement navigation to hobbies page
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

