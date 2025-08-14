import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ManagerDetailsPage extends StatefulWidget {
  final Map<String, dynamic> manager;
  final DateTime selectedDate;  

  const ManagerDetailsPage({
    required this.manager,
    required this.selectedDate,  
  });

  @override
  _ManagerDetailsPageState createState() => _ManagerDetailsPageState();
}

class _ManagerDetailsPageState extends State<ManagerDetailsPage> {
  late final PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.toInt() + 1;
        if (nextPage >= 5) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> galleryImages = [
      'assets/AA.jpg',
      'assets/wed.jpg',
      'assets/b.jpeg',
      'assets/carnival.jpg',
      'assets/c.jpg',
    ];

    final List<String> reviewImages = [
      'assets/example/example1.jpg',
      'assets/BBB.jpg',
      'assets/CCC.jpg',
      'assets/DDD.jpg',
      'assets/example/example2.jpg',
    ];

    String formattedDate = "${widget.selectedDate.toLocal()}".split(' ')[0];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purpleAccent),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Profile",
          style: GoogleFonts.quicksand(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Color.fromARGB(255, 156, 48, 132), Color.fromARGB(255, 237, 229, 235)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 223, 173, 232),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.black,
                        ),
                        radius: 30,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name: ${widget.manager['name']}',
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Email: ${widget.manager['email']}',
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Working Since: ${widget.manager['workingSince']}',
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Location: ${widget.manager['location']}',
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Selected Date: $formattedDate',  
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: galleryImages.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      galleryImages[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: galleryImages.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.purpleAccent,
                    dotHeight: 8,
                    dotWidth: 8,
                    dotColor: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Past Events',
                style: GoogleFonts.quicksand(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: reviewImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          reviewImages[index],
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final userEmail = FirebaseAuth.instance.currentUser?.email;

                    if (userEmail == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('User not logged in')),
                      );
                      return;
                    }

                    final userQuerySnapshot = await FirebaseFirestore.instance
                        .collection('User')
                        .where('email', isEqualTo: userEmail)
                        .get();

                    if (userQuerySnapshot.docs.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('User data not found')),
                      );
                      return;
                    }

                    final userData = userQuerySnapshot.docs.first.data();

                    final requestData = {
                      'userName': userData['name'] ?? '',
                      'userEmail': userData['email'] ?? '',
                      'eventName': userData['eventName'] ?? '',
                      'managerName': widget.manager['name'],
                      'managerEmail': widget.manager['email'],
                      'managerLocation': widget.manager['location'],
                      'managerWorkingSince': widget.manager['workingSince'],
                      'requestDate': FieldValue.serverTimestamp(),
                      'status': 'Pending',
                      'selectedDate': widget.selectedDate,  
                    };

                    await FirebaseFirestore.instance.collection('Request').add(requestData);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Request submitted successfully!')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to submit request: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: InkWell(
                  onTap: () async {
                    try {
                      final userEmail = FirebaseAuth.instance.currentUser?.email;

                      if (userEmail == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User not logged in')),
                        );
                        return;
                      }

                      final userQuerySnapshot = await FirebaseFirestore.instance
                          .collection('User')
                          .where('email', isEqualTo: userEmail)
                          .get();

                      if (userQuerySnapshot.docs.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User data not found')),
                        );
                        return;
                      }

                      final userData = userQuerySnapshot.docs.first.data();

                      final requestData = {
                        'userName': userData['name'] ?? '',
                        'userEmail': userData['email'] ?? '',
                        'eventName': userData['eventName'] ?? '',
                        'managerName': widget.manager['name'],
                        'managerEmail': widget.manager['email'],
                        'managerLocation': widget.manager['location'],
                        'managerWorkingSince': widget.manager['workingSince'],
                        'requestDate': FieldValue.serverTimestamp(),
                        'status': 'Pending',
                        'selectedDate': widget.selectedDate,  
                      };

                      await FirebaseFirestore.instance.collection('Request').add(requestData);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Request submitted successfully!')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to submit request: $e')),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.purpleAccent, Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Send a Request to Place Order',
                      style: GoogleFonts.quicksand(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
