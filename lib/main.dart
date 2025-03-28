import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtsapp/screen/pages/adminLog.dart';
import 'package:vtsapp/screen/pages/approvebooking.dart';
import 'package:vtsapp/screen/pages/booking.dart';
import 'package:vtsapp/screen/pages/bookingthird.dart';
import 'package:vtsapp/screen/pages/bookinnext.dart';
import 'package:vtsapp/screen/pages/checkavadmin.dart';
import 'package:vtsapp/screen/pages/checkavailability.dart';
import 'package:vtsapp/screen/pages/dashboard.dart';
import 'package:vtsapp/screen/pages/dashboardadmin.dart';
import 'package:vtsapp/screen/pages/fristp.dart';
import 'package:vtsapp/screen/pages/login.dart';
import 'package:vtsapp/screen/pages/login.dart';
import 'package:vtsapp/screen/pages/loginadmin.dart';
import 'package:vtsapp/screen/pages/vehicleregister.dart';
import 'package:vtsapp/screen/pages/locationtrack.dart';
import "package:firebase_core/firebase_core.dart";
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'My Flutter App',
        themeMode: ThemeMode.dark,
        home: BookingScreen(),
    );
  }
}
