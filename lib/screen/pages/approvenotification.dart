import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ApproveNotification extends StatefulWidget {
  const ApproveNotification({super.key});

  @override
  State<ApproveNotification> createState() => _ApproveNotificationState();
}

class _ApproveNotificationState extends State<ApproveNotification> {
  final databaseReference = FirebaseDatabase.instance.reference();
  List<Map<dynamic, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    databaseReference.child('ApproveNotifications').onChildAdded.listen((event) {
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
