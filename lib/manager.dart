import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'managerdetails.dart';

class ManagerPage extends StatefulWidget {
  final String selectedCity;
  final DateTime selectedDate;  

  const ManagerPage({
    super.key,
    required this.selectedCity,
    required this.selectedDate,  
  });

  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  final List<Map<String, dynamic>> fetchedManagers = [];

  

  @override
  void initState() {
    super.initState();
    getManagerData();
  }

  Future<void> getManagerData() async {
    QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore.instance
        .collection("Admin")
        .where("location", isEqualTo: widget.selectedCity) 
        .get();

    for (var doc in response.docs) {
      fetchedManagers.add({
        'name': doc['name'],
        'email': doc['email'],
        "workingSince": doc['workingSince'],
        "location": doc['location'],
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purpleAccent),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Event Managers',
          style: GoogleFonts.quicksand(color: Colors.white, fontSize: 24),
        ),
      ),
      body: ListView.builder(
        itemCount: fetchedManagers.length,
        itemBuilder: (context, index) {
          final manager = fetchedManagers[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Color.fromARGB(255, 223, 173, 232),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            manager['name'],
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            manager['email'],
                            style: GoogleFonts.quicksand(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            manager['workingSince'],
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            manager['location'],
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward, color: Colors.purpleAccent),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManagerDetailsPage(manager: manager,  selectedDate:widget.selectedDate),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}

