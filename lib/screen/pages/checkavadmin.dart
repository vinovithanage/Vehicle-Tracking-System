import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vtsapp/screen/pages/dashboardadmin.dart';
import 'package:vtsapp/screen/pages/vehicleregister.dart';
import 'package:vtsapp/screen/pages/approvebooking.dart';
import 'package:vtsapp/screen/pages/locationtrack.dart';

class CheckAdminAvailablity extends StatefulWidget {
  const CheckAdminAvailablity({super.key});

  @override
  _CheckAdminAvailablityState createState() => _CheckAdminAvailablityState();
}

class _CheckAdminAvailablityState extends State<CheckAdminAvailablity> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  String? _selectedVehicleType;
  bool _isBooked = false;

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
                  MaterialPageRoute(builder: (context) => DashboardAdmin()),
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
                  MaterialPageRoute(builder: (context) => CheckAdminAvailablity()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Register Vehicle',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VehicleRegister()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Approve Vehicle Booking',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Approve()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Track Location',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrackLocation()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("images/availability.jpg"),
              opacity: 0.7,
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Hello ... ! Check Vehicle Availability",
                        style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Vehicle Type',
                          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.blue[800] ),
                          filled: true,
                          fillColor: Colors.blue[100],
                          prefixIcon: Icon(Icons.car_crash_outlined, color: Colors.blue[900]),
                        ),
                        value: _selectedVehicleType,
                        items: ['Staff Bus 01', 'Staff Bus 02', 'Van 01','Van 02','Van o3','Wheel 01','Wheel 02']
                            .map((label) => DropdownMenuItem(
                          value: label,
                          child: Text(label),
                        ))
                            .toList(),
                        onChanged: (value)=> setState(() => _selectedVehicleType = value),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                        ),
                        onPressed: () async {
                          if (_selectedVehicleType != null) {
                            DatabaseEvent event = await _databaseReference
                                .child('BookingData')
                                .orderByChild('vehicle_type')
                                .equalTo(_selectedVehicleType)
                                .once();

                            DataSnapshot snapshot = event.snapshot;

                            if (snapshot.value != null) {
                              setState(() {
                                _isBooked = true;
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Vehicle Status'),
                                    content: Text('The selected vehicle type is booked.'),
                                    actions: [
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              setState(() {
                                _isBooked = false;
                              });
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Vehicle Status'),
                                    content: Text('The selected vehicle type is available.'),
                                    actions: [
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                        child: Text(
                          'Check',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

