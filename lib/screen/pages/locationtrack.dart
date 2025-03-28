import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:vtsapp/screen/pages/dashboardadmin.dart';
import 'package:vtsapp/screen/pages/vehicleregister.dart';
import 'package:vtsapp/screen/pages/approvebooking.dart';
import 'package:vtsapp/screen/pages/checkavadmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackLocation extends StatefulWidget {
  const TrackLocation({super.key});

  @override
  State<TrackLocation> createState() => _TrackLocationState();
}

class _TrackLocationState extends State<TrackLocation> {
  @override
  void initState(){
    super.initState();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _vehicleType;
  String? _vehicleNumber;

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
              onTap: () {Navigator.push(
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
              image: AssetImage("images/trackingimage.jpg"),
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
                        "Welcome...! Track Youre Vehicle Location",
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
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800],
                          ),
                          onPressed: () async {
                            var openAppResult = await LaunchApp.openApp(
                              androidPackageName: 'com.builtapps.wegashine',
                                iosUrlScheme: null,
                              openStore: false
                            );
                            print(
                                'openAppResult => $openAppResult ${openAppResult.runtimeType}');
                            // Enter thr package name of the App you want to open and for iOS add the URLscheme to the Info.plist file.
                            // The second arguments decide wether the app redirects PlayStore or AppStore.
                            // For testing purpose you can enter com.instagram.android
                          },
                          child: const Center(
                            child: Text(
                              "Open",
                              textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )),
                      SizedBox(height: 40,),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                          ),
                          onPressed: () async {
                            var isAppInstalledResult = await LaunchApp.isAppInstalled(
                              androidPackageName: 'com.builtapps.wegashine',
                              iosUrlScheme: null,
                              // openStore: false
                            );
                            print(
                                'isAppInstalledResult => $isAppInstalledResult ${isAppInstalledResult.runtimeType}');
                          },
                          child: const Center(
                            child: Text(
                              "Is app installed?",
                              textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 18),),
                          )),
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
  _launchURL() async {
    const url = 'https://play.google.com/store/apps/details?id=com.builtapps.wegashine';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
