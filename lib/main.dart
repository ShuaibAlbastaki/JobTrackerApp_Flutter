// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:time_tracker_flutter_course/app/services/auth.dart';

/// Application's starting point.
Future<void> main() async {
  // This statement ensures that Firebase is initialized before the "runApp" method is executed.
  WidgetsFlutterBinding.ensureInitialized();
  // Waiting for firebase to initialize before app is run.
  await Firebase.initializeApp();
  runApp(JobTrackerApp());
}

class JobTrackerApp extends StatelessWidget {
  const JobTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Job Tracker",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: LandingPage(),
      ),
    );
  }
}
