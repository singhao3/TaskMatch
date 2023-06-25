import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmatch/pages/taskseeker/taskseeker_homepage.dart';
import 'package:taskmatch/pages/taskdoer/taskdoer_homepage.dart';
import 'package:taskmatch/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter_stripe/flutter_stripe.dart";
import 'package:taskmatch/.env';

import 'blocs/blocs.dart';// Import your PaymentBloc

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentBloc>(
      create: (context) => PaymentBloc(), // Create an instance of your PaymentBloc
      child: MaterialApp(
        title: 'TaskMatch',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const WidgetTree(),
          '/taskdoerhome': (context) => const TaskDoerHome(),
          '/taskseekerhome': (context) => const TaskSeekerHome(),
        },
      ),
    );
  }
}
