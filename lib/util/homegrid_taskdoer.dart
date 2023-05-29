import 'package:flutter/material.dart';

class Discovergrid extends StatelessWidget {
  Discovergrid({Key? key}) : super(key: key);

  // Define a list of project data
  final List<Map<String, dynamic>> projects = [
    {
      'name': 'Mobile Health Monitoring App',
      'description':
          'An app for monitoring and tracking health metrics on mobile devices.',
      'university': 'Stanford University',
      'price': 250.0,
    },
    {
      'name': 'Smart Home Automation System',
      'description':
          'A system that automates various aspects of a home, such as lighting, security, and temperature control.',
      'university': 'Massachusetts Institute of Technology',
      'price': 150.0,
    },
    {
      'name': 'E-Commerce Platform for Local Artisans',
      'description':
          'An online platform for local artisans to sell their handmade products.',
      'university': 'University of California, Berkeley',
      'price': 100.0,
    },
    {
      'name': 'Autonomous Drone Delivery System',
      'description':
          'A system that enables autonomous drone delivery of packages.',
      'university': 'Carnegie Mellon University',
      'price': 300.0,
    },
    {
      'name': 'Climate Change Tracking and Analysis App',
      'description':
          'An app that tracks and analyzes climate change data to raise awareness and promote sustainable practices.',
      'university': 'Harvard University',
      'price': 200.0,
    },
    {
      'name': 'Virtual Reality Training Simulator for Surgeons',
      'description':
          'A virtual reality simulator for surgeons to practice complex surgical procedures.',
      'university': 'Johns Hopkins University',
      'price': 350.0,
    },
    {
      'name': 'AI-Powered Chatbot for Customer Support',
      'description':
          'An AI-powered chatbot that provides automated customer support and assistance.',
      'university': 'Stanford University',
      'price': 120.0,
    },
    {
      'name': 'Blockchain-Based Supply Chain Management System',
      'description':
          'A supply chain management system that utilizes blockchain technology for enhanced transparency and security.',
      'university': 'Massachusetts Institute of Technology',
      'price': 280.0,
    },
    {
      'name': 'Smart Traffic Management System',
      'description':
          'A system that optimizes traffic flow and reduces congestion through intelligent algorithms.',
      'university': 'University of California, Berkeley',
      'price': 180.0,
    },
    {
      'name': 'Augmented Reality Museum Guide',
      'description':
          'An augmented reality app that provides interactive museum guides and information.',
      'university': 'Carnegie Mellon University',
      'price': 150.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        // Get the project data for the current index
        final project = projects[index];

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
                          project['name'] ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          project['description'] ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          project['university'] ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${project['price'] ?? ''}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.green,
                    ),
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