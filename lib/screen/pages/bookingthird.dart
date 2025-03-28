import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vtsapp/screen/pages/dashboard.dart';
import 'package:vtsapp/screen/pages/booking.dart';
import 'package:vtsapp/screen/pages/checkavailability.dart';
import 'package:vtsapp/screen/pages/dashboardadmin.dart';
import 'package:firebase_database/firebase_database.dart';

class BookingThird extends StatefulWidget {
  const BookingThird({super.key});

  @override
  State<BookingThird> createState() => _BookingThirdState();
}

class _BookingThirdState extends State<BookingThird> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final _formKey = GlobalKey<FormState>();

  String? _applicantName;
  String? _vehicleType;
  String? _vehicleInCharge;
  DateTime? _dateOfRequired;
  TimeOfDay? _timeOfRequired;
  String? _requirement;
  String? _natureOfDuty;
  String? _Address;
  String? _Distance;
  String? _timeToBeSpent;
  DateTime? _dateOfArrival;
  String? _numOfOffices;
  String? _numOfLecAndCivil;
  String? _numOfInstructors;
  String? _numOfCadets;
  String? _numOfDayScholar;
  String? _totalCount;
  String? _routeToFollow;

  bool _showSendNotificationButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 35, 102, 1),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("images/kdu-logo.png"),
              width: 200.0,
              height: 100.0,
            ),
            SizedBox(width: 8),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
            color: Colors.white,
          ),
          IconButton(
            icon: Icon(Icons.account_circle_sharp),
            onPressed: () {},
            color: Colors.white,
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color.fromRGBO(0, 17, 58, 116),
        elevation: 140.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 38, 86, 130),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Check Availability',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckAvailability()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Booking Vehicle',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 35, right: 35, bottom: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Number Of Lectures And Civil Staff',
                        filled: true,
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.type_specimen_outlined, color: Colors.blue[900]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Number Of Lectures And Civil Staff';
                        }
                        return null;
                      },
                      onSaved: (value) => _numOfLecAndCivil = value,
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Number Of Instructors',
                        filled: true,
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.type_specimen_outlined, color: Colors.blue[900]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Number Of Instructors';
                        }
                        return null;
                      },
                      onSaved: (value) => _numOfInstructors = value,
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Number of Cadets',
                        filled: true,
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.type_specimen_outlined, color: Colors.blue[900]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Number of Cadets';
                        }
                        return null;
                      },
                      onSaved: (value) => _numOfCadets = value,
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Number of Day Scholars',
                        filled: true,
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.type_specimen_outlined, color: Colors.blue[900]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Number of Day Scholars';
                        }
                        return null;
                      },
                      onSaved: (value) => _numOfDayScholar = value,
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Total Count',
                        filled: true,
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.type_specimen_outlined, color: Colors.blue[900]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Total Count';
                        }
                        return null;
                      },
                      onSaved: (value) => _totalCount = value,
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Route To Follow',
                        filled: true,
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.type_specimen_outlined, color: Colors.blue[900]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Route To Follow';
                        }
                        return null;
                      },
                      onSaved: (value) => _routeToFollow = value,
                    ),
                    SizedBox(height: 40),
                   Center(
                     child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[900],
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  try {
                                    final data = {
                                      if (_applicantName != null)
                                        'applicant_name': _applicantName,
                                      if (_vehicleType != null)
                                        'vehicle_type': _vehicleType,
                                      if (_vehicleInCharge != null)
                                        'vehicle_in_charge': _vehicleInCharge,
                                      if (_dateOfRequired != null)
                                        'date_of_required':
                                        Timestamp.fromDate(_dateOfRequired!),
                                      if (_timeOfRequired != null)
                                        'time_of_required':
                                        Timestamp.fromDate(DateTime(_timeOfRequired!.hour, _timeOfRequired!.minute)),
                                      if (_requirement != null)
                                        'requirement': _requirement,
                                      if (_natureOfDuty != null)
                                        'nature_of_duty': _natureOfDuty,
                                      if (_Address != null)
                                        'address': _Address,
                                      if (_Distance != null)
                                        'distance': _Distance,
                                      if (_dateOfArrival != null)
                                        'date_of_arrival':
                                        Timestamp.fromDate(_dateOfArrival!),
                                      if (_timeToBeSpent != null)
                                        'time_to_be_spent': _timeToBeSpent,
                                      if (_numOfOffices != null)
                                        'num_of_officers': _numOfOffices,
                                      if (_numOfLecAndCivil != null)
                                        'num_of_lectures_and_civil':
                                        _numOfLecAndCivil,
                                      if (_numOfInstructors != null)
                                        'num_of_instructors': _numOfInstructors,
                                      if (_numOfCadets != null)
                                        'num_of_cadets': _numOfCadets,
                                      if (_numOfDayScholar != null)
                                        'num_of_day_scholars': _numOfDayScholar,
                                      if (_totalCount != null)
                                        'total_count': _totalCount,
                                      if (_routeToFollow != null)
                                        'route_to_follow': _routeToFollow,
                                    };

                                    print('Data to be added:');
                                    print(data);
                                    databaseReference.child('BookingData').push().set(data);
                                    // Send notification message to admin
                                    databaseReference.child('Notifications').push().set({
                                      'title': 'New Booking',
                                      'body': 'A new booking has been made.',
                                      'timestamp': DateTime.now().millisecondsSinceEpoch,
                                    });
                                    print('Data sent to Realtime Database');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => BookingThird()),
                                    );
                                  } catch (e) {
                                    print('Error sending data to Realtime Database: $e');
                                  }
                                }
                              },
                              child: Text(
                                'Book',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                   ),
            ],
                ),
          ),
          ],
        ),
    ),
    ),
    );
  }
}
