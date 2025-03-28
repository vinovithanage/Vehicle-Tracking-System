import 'package:flutter/material.dart';
import 'package:vtsapp/screen/pages/dashboardadmin.dart';
import 'package:vtsapp/screen/pages/checkavadmin.dart';
import 'package:vtsapp/screen/pages/locationtrack.dart';
import 'package:vtsapp/screen/pages/approvebooking.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class VehicleRegister extends StatefulWidget {
  @override
  _VehicleRegisterState createState() => _VehicleRegisterState();
}

class _VehicleRegisterState extends State<VehicleRegister> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _vehicleNumberController = TextEditingController();
  final TextEditingController _chassiNumberController = TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();

  // Dropdown button for vehicle type

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
                    fontSize: 20,
                    fontWeight: FontWeight.bold
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold
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
      body: Stack(
        children: <Widget>[

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/vregi.png"),
                opacity: 0.5,
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Please Register Vehicle ...!",
                        style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 35, left: 30, right: 30),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: _vehicleNumberController,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black ),
                                  fillColor: Colors.black12,
                                  filled: true,
                                  labelText: 'Vehicle Number',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a vehicle number';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                controller: _vehicleTypeController,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black ),
                                  labelText: 'Chassi Number',
                                  fillColor: Colors.black12,
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a chassi number';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30),
                              TextFormField(
                                controller: _chassiNumberController,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black ),
                                  labelText: 'Vehicle Type',
                                  fillColor: Colors.black12,
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Vehicle Type';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

      Positioned(
        top: 520,
        left: 50,
        right: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[900],
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Register button pressed
              String vehicleNumber = _vehicleNumberController.text;
              String chassiNumber = _chassiNumberController.text;
              String vehicleType = _vehicleTypeController.text;

              // Send data to Firebase Cloud Firestore
              FirebaseFirestore.instance.collection('vehicles').add({
                'vehicleNumber': vehicleNumber,
                'chassiNumber': chassiNumber,
                'vehicleType': vehicleType,
              }).then((value) {
                print('Vehicle registered successfully!');
                // Clear the form
                _formKey.currentState!.reset();
                _vehicleNumberController.clear();
                _chassiNumberController.clear();
                _vehicleTypeController.clear();

                // Show SnackBar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Registered successfully!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }).catchError((error) {
                print('Error registering vehicle: $error');
              });
            }
          },
          child: Text(
            'Register',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
      ],
      ),
    );
  }

  @override
  void dispose() {
    _vehicleNumberController.dispose();
    _chassiNumberController.dispose();
    super.dispose();
  }
}