import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../blocs/blocs.dart';

class PaymentPage extends StatelessWidget {
  final String taskId;
  final double amount;

  const PaymentPage({Key? key, required this.taskId, required this.amount})
      : super(key: key);

  void updateTaskStatus(String newStatus, BuildContext context) {
    FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskId)
        .update({'status': newStatus}).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task status updated')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update task status')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            CardFormEditController controller = CardFormEditController(
              initialDetails: state.cardFieldInputDetails,
            );

            if (state.status == PaymentStatus.initial) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('tasks')
                          .doc(taskId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        }

                        final task =
                            snapshot.data?.data() as Map<String, dynamic>?;
                        final title = task?['title'] ?? '';

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Task: $title',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Amount: \$${amount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Card Form',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 20),
                    CardFormField(
                      controller: controller,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final user = FirebaseAuth.instance.currentUser;
                        final email = user?.email ?? '';

                        print('Form Complete: ${controller.details.complete}');

                        if (controller.details.complete) {
                          context.read<PaymentBloc>().add(
                                PaymentCreateIntent(
                                  billingDetails: BillingDetails(email: email),
                                  taskId: taskId,
                                ),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('The form is not complete.'),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Pay',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state.status == PaymentStatus.success) {
              updateTaskStatus('Paid', context);

              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 64,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Payment Successful',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Your payment has been successfully processed.',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/taskseekerhome');
                        },
                        child: const Text('Back to Home'),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (state.status == PaymentStatus.failure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 64,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Payment Failed',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Oops! Something went wrong with your payment.',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          context.read<PaymentBloc>().add(PaymentStart());
                        },
                        child: const Text('Back to Home'),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
