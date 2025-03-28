import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vtsapp/screen/pages/bookingthird.dart';
import 'package:vtsapp/screen/pages/dashboard.dart';
import 'package:vtsapp/screen/pages/booking.dart';
import 'package:vtsapp/screen/pages/checkavailability.dart';
import 'package:firebase_database/firebase_database.dart';

class BookingNext extends StatefulWidget {
  const BookingNext({super.key});

  @override
  State<BookingNext> createState() => _BookingNextState();
}

class _BookingNextState extends State<BookingNext> {
  final _formKey = GlobalKey<FormState>();
  final databaseReference = FirebaseDatabase.instance.reference();

  String? _natureOfDuty;
  String? _Address;
  String? _Distance;
  String? _timeToBeSpent;
  DateTime? _dateOfArrival;
  String? _numOfOffices;

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
                        labelText: 'Nature Of Duty (Official/Private)',
                        filled: true,
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.type_specimen_outlined, color: Colors.blue[900]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Nature Of Duty';
                        }
                        return null;
                      },
                      onSaved: (value) => _natureOfDuty = value,
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Address To Go',
                        filled: true,
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.type_specimen_outlined, color: Colors.blue[900]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Address';
                        }
                        return null;
                      },
                      onSaved: (value) => _Address = value,
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Distance',
                        filled: true,
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.type_specimen_outlined, color: Colors.blue[900]),
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Distance';
                        }
                        return null;
                      },
                      onSaved: (value) => _Distance = value,
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.date_range_outlined, color: Colors.blue[900]),
                        labelText: 'Date Of Arrival',
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _dateOfArrival ?? DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2030),
                        );
                        if (picked != null) {
                          setState(() {
                            _dateOfArrival = picked;
                          });
                        }
                      },
                      readOnly: true,
                      initialValue: _dateOfArrival != null
                          ? DateFormat('yyyy-MM-dd').format(_dateOfArrival!)
                          : '',
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Time To Be Spent',
                        filled: true,
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.type_specimen_outlined, color: Colors.blue[900]),
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Time To Be Spent';
                        }
                        return null;
                      },
                      onSaved: (value) => _timeToBeSpent = value,
                    ),
                    SizedBox(height: 25),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Number of Officers',
                        filled: true,
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.description_outlined, color: Colors.blue[900]),
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Number of Officers';
                        }
                        return null;
                      },
                      onSaved: (value) => _numOfOffices = value,
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10), // Adjust the padding as needed
                        ),
                        onPressed: () {
                          _submitForm();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue[900],
                          ),
                          padding: EdgeInsets.all(10), // Adjust the padding as needed
                          child: Icon(
                            Icons.arrow_forward,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      )
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

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        Map<String, dynamic> data = {
          'natureOfDuty': _natureOfDuty,
          'address': _Address,
          'distance': _Distance,
          'date_of_arrival': _dateOfArrival != null ? _dateOfArrival!.toIso8601String() : null,
          'time_to_be_spent': _timeToBeSpent,
          'num_of_officers': _numOfOffices,
        };
        await databaseReference.child('BookingData').push().set(data);
        print("Data sent to Realtime Database!");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingThird()),
        );
      } catch (e) {
        print("Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error sending data to Realtime Database'),
        ));
      }
    }
  }
}

