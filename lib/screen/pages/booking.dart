import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vtsapp/screen/pages/bookinnext.dart';
import 'package:vtsapp/screen/pages/dashboard.dart';
import 'package:vtsapp/screen/pages/checkavailability.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  String? _applicantName;
  String? _vehicleType;
  String? _vehicleInCharge;
  DateTime? _dateOfRequired;
  TimeOfDay? _timeOfRequired;
  String? _requirement;
  String? _routeToFollow;
  String? _totalCount;
  DateTime? _dateOfArrival;
  String? _Address;
  String? _natureOfDuty;

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
        padding: const EdgeInsets.only(top: 20, left: 35, right: 35, bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Applicant Name',filled: true,
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.type_specimen_outlined, color: Colors.blue[900]),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the applicant name';
                        }
                        return null;
                      },
                      onSaved: (value) => _applicantName = value,
                    ),
                    SizedBox(height: 10,),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Vehicle Type',
                        filled: true,
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.car_crash_outlined, color: Colors.blue[900]),
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      value: _vehicleType,
                      items: ['Staff Bus 01', 'Staff Bus 02', 'Van 01','Van 02','Van 03','Wheel 01','Wheel 02']
                          .map((label) => DropdownMenuItem(
                        value: label,
                        child: Text(label),
                      ))
                          .toList(),
                      onChanged: (value)=> setState(() => _vehicleType = value),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Vehicle In Charge',
                        filled: true,
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.type_specimen_outlined, color: Colors.blue[900]),
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the vehicle in charge';
                        }
                        return null;
                      },
                      onSaved: (value) => _vehicleInCharge = value,
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.blue[100],
                            child: TextButton(
                              onPressed: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2015),
                                  lastDate: DateTime(2050),
                                );
                                if (picked != null) {
                                  setState(() => _dateOfRequired = picked);
                                }
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                textStyle: TextStyle(fontSize: 15),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, color: Colors.blue[900]),
                                  SizedBox(width: 3),
                                  Text(_dateOfRequired == null
                                      ? 'Required Date'
                                      : DateFormat('yyyy-MM-dd').format(_dateOfRequired!),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Material(
                            color: Colors.blue[100],
                            child: TextButton(
                              onPressed: () async {
                                final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (picked != null) {
                                  setState(() => _timeOfRequired = picked);
                                }
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                textStyle: TextStyle(fontSize: 15),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.access_time,color: Colors.blue[900]),
                                  SizedBox(width: 2),
                                  Text(_timeOfRequired == null
                                      ? 'Required Time'
                                      : '${_timeOfRequired!.hour}:${_timeOfRequired!.minute}'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Requirement',
                        filled: true,
                        fillColor: Colors.blue[100],
                        prefixIcon: Icon(Icons.description_outlined, color: Colors.blue[900]),
                        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the requirement';
                        }
                        return null;
                      },
                      onSaved: (value) => _requirement = value,
                    ),
                    SizedBox(height: 10,),
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
                    SizedBox(height: 10,),
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
                    SizedBox(height: 10,),
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
                    SizedBox(height: 10,),
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
                    SizedBox(height: 20),
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
                            child:Text(
                              'Book',
                              style: TextStyle(color: Colors.white, fontSize: 18),
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
          'applicant_name': _applicantName,
          'vehicle_type': _vehicleType,
          'vehicle_in_charge': _vehicleInCharge,
          'date_of_required': _dateOfRequired != null ? _dateOfRequired!.toIso8601String() : null,
          'time_of_required': _timeOfRequired != null ? _formatTime(_timeOfRequired!) : null,
          'requirement': _requirement,
          'route_to_follow': _routeToFollow,
          'nature_of_duty': _natureOfDuty,
          'address': _Address,
          'date_of_arrival': _dateOfArrival != null ? _dateOfArrival!.toIso8601String() : null,
          'total_count': _totalCount,

        };
        print("Data to be sent: $data");
        await databaseReference.child('BookingData').push().set(data);
        print("Data sent to Realtime Database!");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingScreen()),
        );
      } catch (e) {
        print("Error: $e");
        // Display an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error sending data to Realtime Database'),
        ));
      }
    }
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(dateTime);
  }
}
