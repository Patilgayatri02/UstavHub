import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageEventsScreen extends StatefulWidget {
  const ManageEventsScreen({Key? key}) : super(key: key);

  @override
  _ManageEventsScreenState createState() => _ManageEventsScreenState();
}

class _ManageEventsScreenState extends State<ManageEventsScreen> {
  List<Map<String, dynamic>> _events = [];
  TextEditingController _searchController = TextEditingController();
  String? managerEmail;

  @override
  void initState() {
    super.initState();
    _getManagerEmail();
    _loadEvents();
  }

  void _getManagerEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        managerEmail = user.email;
      });
    }
  }

  void _loadEvents() async {
    if (managerEmail != null) {
      FirebaseFirestore.instance
          .collection('events') 
          .where('createdBy', isEqualTo: managerEmail)
          .snapshots()
          .listen((snapshot) {
        setState(() {
          _events = snapshot.docs
              .map((doc) => {
                    'id': doc.id,
                    'eventName': doc['eventName'],
                    'eventDate': doc['eventDate'],
                    'eventLocation': doc['eventLocation'],
                    'clientName': doc['clientName'], // Add client name field
                    'createdBy': doc['createdBy'],
                  })
              .toList();
        });
      });
    }
  }

  void _addEvent(String eventName, String eventDate, String eventLocation, String clientName) async {
    if (managerEmail != null) {
      await FirebaseFirestore.instance.collection('events').add({
        'eventName': eventName,
        'eventDate': eventDate,
        'eventLocation': eventLocation,
        'clientName': clientName, // Store client name
        'createdBy': managerEmail,
      });
      _loadEvents();
    }
  }

  void _editEvent(String id, String eventName, String eventDate, String eventLocation, String clientName) async {
    if (managerEmail != null) {
      await FirebaseFirestore.instance.collection('events').doc(id).update({
        'eventName': eventName,
        'eventDate': eventDate,
        'eventLocation': eventLocation,
        'clientName': clientName, // Update client name
        'createdBy': managerEmail,
      });
      _loadEvents();
    }
  }

  void _deleteEvent(String id) async {
    await FirebaseFirestore.instance.collection('events').doc(id).delete();
    _loadEvents();
  }

  List<Map<String, dynamic>> _filterEvents(String query) {
    return _events.where((event) {
      return event['eventName'].toLowerCase().contains(query.toLowerCase()) ||
          event['eventLocation'].toLowerCase().contains(query.toLowerCase()) ||
          event['clientName'].toLowerCase().contains(query.toLowerCase()); // Include client name in search
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text("Schedule",
            style: GoogleFonts.quicksand(
                fontSize: 17, fontWeight: FontWeight.bold, color:const Color.fromARGB(255, 223, 173, 232))),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search events...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: _filterEvents(_searchController.text).isEmpty
                  ? Center(child: Text("No events available.",
                   style: GoogleFonts.quicksand(fontSize: 15, color: Colors.grey),
                  ))
                  : ListView.builder(
                      itemCount: _filterEvents(_searchController.text).length,
                      itemBuilder: (context, index) {
                        final event = _filterEvents(_searchController.text)[index];
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          color: const Color.fromARGB(255, 45, 45, 45),
                          child: ListTile(
                            title: Text(
                              event['clientName'], // Show Client Name first
                              style: GoogleFonts.quicksand(
                                  color: Colors.white, fontSize: 16),
                            ),
                            subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${event['eventName']}',
          style: GoogleFonts.quicksand(color: Colors.white, fontSize: 16),
        ),
        Text(
          '${event['eventLocation']}',
          style: GoogleFonts.quicksand(color: Colors.white70, fontSize: 16),
        ),
        Text(
          '${event['eventDate']}',
          style: GoogleFonts.quicksand(color: Colors.white70, fontSize: 16),
        ),
      ],
    ),
                      
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.purpleAccent),
                                  onPressed: () {
                                    _showEditEventDialog(event);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    _deleteEvent(event['id']);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _showAddEventDialog();
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New Event"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 223, 173, 232),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddEventDialog() {
    final TextEditingController eventNameController = TextEditingController();
    final TextEditingController eventDateController = TextEditingController();
    final TextEditingController eventLocationController = TextEditingController();
    final TextEditingController clientNameController = TextEditingController(); // Add controller for client name

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Event"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: clientNameController,
                decoration: const InputDecoration(labelText: 'Client Name'), // Client name first
              ),
              TextField(
                controller: eventNameController,
                decoration: const InputDecoration(labelText: 'Event Name'),
              ),
              TextField(
                controller: eventDateController,
                decoration: const InputDecoration(labelText: 'Event Date'),
              ),
              TextField(
                controller: eventLocationController,
                decoration: const InputDecoration(labelText: 'Event Location'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _addEvent(eventNameController.text, eventDateController.text, eventLocationController.text, clientNameController.text); // Pass client name
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _showEditEventDialog(Map<String, dynamic> event) {
    final TextEditingController eventNameController = TextEditingController(text: event['eventName']);
    final TextEditingController eventDateController = TextEditingController(text: event['eventDate']);
    final TextEditingController eventLocationController = TextEditingController(text: event['eventLocation']);
    final TextEditingController clientNameController = TextEditingController(text: event['clientName']); // Add controller for client name

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Event"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: clientNameController,
                decoration: const InputDecoration(labelText: 'Client Name'), // Edit input for client name
              ),
              TextField(
                controller: eventNameController,
                decoration: const InputDecoration(labelText: 'Event Name'),
              ),
              TextField(
                controller: eventDateController,
                decoration: const InputDecoration(labelText: 'Event Date'),
              ),
              TextField(
                controller: eventLocationController,
                decoration: const InputDecoration(labelText: 'Event Location'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _editEvent(event['id'], eventNameController.text, eventDateController.text, eventLocationController.text, clientNameController.text); // Pass client name
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
