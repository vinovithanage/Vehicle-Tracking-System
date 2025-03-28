import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  final databaseReference = FirebaseDatabase.instance.reference();
  List<Map<dynamic, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    databaseReference.child('Notifications').onChildAdded.listen((event) {
      setState(() {
        notifications.add(event.snapshot.value as Map<dynamic, dynamic>);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index]['title']),
            subtitle: Text(notifications[index]['body']),
            trailing: Text(
              DateTime.fromMillisecondsSinceEpoch(
                notifications[index]['timestamp'],
              ).toString(),
            ),
          );
        },
      ),
    );
  }
}
