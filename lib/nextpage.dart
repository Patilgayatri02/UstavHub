import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  final QueryDocumentSnapshot notification; 

  const NextPage({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Details'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification['title'],
              style: const TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              notification['message'],
              style: const TextStyle(color: Colors.white70, fontSize: 16.0),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
