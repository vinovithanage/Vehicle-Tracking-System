import 'package:flutter/material.dart';
import 'package:vtsapp/screen/pages/dashboardadmin.dart';
import 'package:vtsapp/screen/pages/vehicleregister.dart';
import 'package:vtsapp/screen/pages/locationtrack.dart';
import 'package:vtsapp/screen/pages/checkavadmin.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Approve extends StatefulWidget {
  const Approve({super.key});

  @override
  State<Approve> createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child('BookingData');
  List<Map<String, dynamic>> bookingList = [];
  Set<String> removedBookings = {};

  @override
  void initState() {
    super.initState();
    _loadRemovedBookings();
  }

  Future<void> _loadRemovedBookings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      removedBookings = prefs.getStringList('removedBookings')?.toSet() ?? {};
    });
  }

  Future<void> _saveRemovedBookings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('removedBookings', removedBookings.toList());
  }

  Future<void> approveBooking(String id) async {
    await _databaseReference.child(id).update({'status': 'Approved'});
  }

  Future<void> notApproveBooking(String id) async {
    await _databaseReference.child(id).update({'status': 'Not Approved'});
  }

  void removeBookingFromList(String id) {
    setState(() {
      removedBookings.add(id);
      _saveRemovedBookings();
    });
  }

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
      body: Container(
        child: StreamBuilder<DatabaseEvent>(
          stream: _databaseReference.onValue,
          builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            Map<dynamic, dynamic>? bookingData = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
            if (bookingData == null) {
              return Center(
                child: Text("No data available"),
              );
            }

            if (bookingList.isEmpty) {
              bookingData.forEach((key, value) {
                bookingList.add({'id': key, ...value});
              });
            }

            List<Map<String, dynamic>> filteredList = bookingList.where((booking) => !removedBookings.contains(booking['id'])).toList();

            return ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> data = filteredList[index];
                String documentId = data['id'];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Applicant Name: ${data['applicant_name']}', style: TextStyle(fontSize: 12, color: Colors.black)),
                      Text('Date of Required: ${data['date_of_required']}', style: TextStyle(fontSize: 12, color: Colors.black)),
                      Text('Requirement: ${data['requirement']}', style: TextStyle(fontSize: 12, color: Colors.black)),
                      Text('Time of Required: ${data['time_of_required']}', style: TextStyle(fontSize: 12, color: Colors.black)),
                      Text('Vehicle in Charge: ${data['vehicle_in_charge']}', style: TextStyle(fontSize: 12, color: Colors.black)),
                      Text('Vehicle Type: ${data['vehicle_type']}', style: TextStyle(fontSize: 12, color: Colors.black)),
                      Text('Address: ${data['address']}', style: TextStyle(fontSize: 12, color: Colors.black)),
                      Text('Date of Arrival: ${data['date_of_arrival']}', style: TextStyle(fontSize: 12, color: Colors.black)),
                //      Text('Distance: ${data['distance']}', style: TextStyle(fontSize: 12, color: Colors.black)),
                     Text('Duty Type: ${data['natureOfDuty']}', style: TextStyle(fontSize: 12, color: Colors.black)),
                //      Text('Num of Officers: ${data['num_of_officers']}', style: TextStyle(fontSize: 12, color: Colors.black)),
               //       Text('Time to be Spent: ${data['time_to_be_spent']}', style: TextStyle(fontSize: 12, color: Colors.black)),
                //      Text('Num of Cadets: ${data['num_of_cadets']}', style: TextStyle(fontSize: 12, color: Colors.black)),
                //      Text('Num of Day Scholars: ${data['num_of_day_scholars']}', style: TextStyle(fontSize: 12, color: Colors.black)),
               //       Text('Num of Instructions: ${data['num_of_instructors']}', style: TextStyle(fontSize: 12, color: Colors.black)),
                //      Text('Num of Lectures And Civil Staff: ${data['num_of_lectures_and_civil']}', style: TextStyle(fontSize: 12, color: Colors.black)),
                      Text('Route To Follow: ${data['route_to_follow']}', style: TextStyle(fontSize: 12, color: Colors.black)),
                      Text('Total Count: ${data['total_count']}', style: TextStyle(fontSize: 12, color: Colors.black)),




                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                databaseReference.child('ApproveNotifications').push().set({
                                  'title': 'Not Approve Booking',
                                  'body': 'Your Booking is Not Approve',
                                  'timestamp': DateTime.now().millisecondsSinceEpoch,
                                });
                                notApproveBooking(documentId);
                                removeBookingFromList(documentId);
                              },
                              child: Text('Not Approve'),
                            ),
                            SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: ()  {
                                databaseReference.child('ApproveNotifications').push().set({
                                  'title': 'Approve Booking',
                                  'body': 'Your Booking is Approve',
                                  'timestamp': DateTime.now().millisecondsSinceEpoch,
                                });
                                approveBooking(documentId);
                                removeBookingFromList(documentId);
                              },
                              child: Text('Approve'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}




