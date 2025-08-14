import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> eventHistory = [
      {
        'profilePic': 'assets/user1.jpg',
        'userName': 'Sai Shinde',
        'event': 'Birthday Party',
      },
      {
        'profilePic': 'assets/user2.jpg',
        'userName': 'Soham Shinde',
        'event': 'Wedding Celebration',
      },
      {
        'profilePic': 'assets/user3.jpg',
        'userName': 'Gauri Shinde',
        'event': 'Corporate Event',
      },
      // Add more entries as needed
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Event History',
          style: GoogleFonts.quicksand(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: ListView.builder(
        itemCount: eventHistory.length,
        itemBuilder: (context, index) {
          var event = eventHistory[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 213, 151, 224),
               child: Icon(
                      Icons.person,
                      size: 25,
                      color: Colors.black,
                    ),
                radius: 50,
              ),
              title: Text(
                event['userName']!,
                style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Event: ${event['event']}',
                style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          color:Colors.grey.shade900,
          );
        },
      ),
    );
  }
}
