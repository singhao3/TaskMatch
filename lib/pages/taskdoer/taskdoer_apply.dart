import 'package:flutter/material.dart';

class taskdoerApply extends StatefulWidget {
	
	@override
	_taskdoerApplyState createState() => _taskdoerApplyState();
}

class _taskdoerApplyState extends State<taskdoerApply> {
	
	@override
	Widget build(BuildContext context) {
		final urlImage1 = 'image/image1.jpg';
		
		return Scaffold(
			body: Container(
				decoration: BoxDecoration(
					gradient: LinearGradient(
						colors: [
							Colors.lightGreen[400]!,
							Colors.white,
						],
						begin: Alignment.topCenter,
						end: Alignment.bottomCenter,
					),
				),
				child: Padding(
					padding: const EdgeInsets.all(16.0),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.stretch,
						children: [
							Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									Image.asset(
										urlImage1,
										height: 100,
									),
									SizedBox(height: 10),
									Text(
										'Task Title',
										style: TextStyle(
											fontSize: 16,
											fontWeight: FontWeight.bold,
										),
									),
									SizedBox(height: 16),
									Text(
										'Description: ',
										style: TextStyle(
											fontSize: 16,
											fontWeight: FontWeight.bold,
										),
									),
									SizedBox(width: 4),
									Text(
										'Some description',
										style: TextStyle(
											fontSize: 12,
										),
									),
									SizedBox(height: 12),
									Text(
										'Date: ',
										style: TextStyle(
											fontSize: 16,
											fontWeight: FontWeight.bold,
										),
									),
									SizedBox(width: 4),
									Text(
										'Some Date',
										style: TextStyle(
											fontSize: 12,
										),
									),
									SizedBox(height: 12),
									Text(
										'Time: ',
										style: TextStyle(
											fontSize: 16,
											fontWeight: FontWeight.bold,
										),
									),
									SizedBox(width: 4),
									Text(
										'Some Time',
										style: TextStyle(
											fontSize: 12,
										),
									),
									SizedBox(height: 12),
									Text(
										'Location: ',
										style: TextStyle(
											fontSize: 16,
											fontWeight: FontWeight.bold,
										),
									),
									SizedBox(width: 4),
									Text(
										'Some Location',
										style: TextStyle(
											fontSize: 12,
										),
									),
									SizedBox(height: 12),
									Text(
										'Reward: ',
										style: TextStyle(
											fontSize: 16,
											fontWeight: FontWeight.bold,
										),
									),
									SizedBox(width: 4),
									Text(
										'Some Reward',
										style: TextStyle(
											fontSize: 12,
										),
									),
									SizedBox(height: 24),
									ElevatedButton(
              						onPressed: () {},
              						style: ElevatedButton.styleFrom(
                						backgroundColor: Colors.white,
              						),
              						child: Text(
                						'Chat Now',
                						style: TextStyle(
                  						color: Colors.black,
                						),
              						),
            					),
									SizedBox(width: 8),
									ElevatedButton(
              						onPressed: () {},
              						style: ElevatedButton.styleFrom(
                						backgroundColor: Colors.white,
              						),
              						child: Text(
                						'Apply Now',
                						style: TextStyle(
                  						color: Colors.black,
                						),
              						),
            					),
								]
							)
						]
					)
				)
			)
		)
	}
}
