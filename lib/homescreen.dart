import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_project/location.dart';
import 'package:main_project/notifications.dart';
import 'package:main_project/user_history.dart';
import 'package:main_project/user_profile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State createState() => _EventScreenState();
}

class _EventScreenState extends State {
  List<Map<String, List<String>>> eventsName = [
    {
      'Discover Events': [
        'assets/img1.jpg',
        'assets/img2.jpg',
        'assets/img3.jpg',
        'assets/img4.jpg',
        'assets/img5.jpg',
      ],
    },
  ];

  List<PageController> pageControllers = [];
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < eventsName.length; i++) {
      pageControllers.add(PageController(viewportFraction: 0.8));
      autoScroll(pageControllers[i], eventsName[i].values.first.length);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isVisible = true;
      });
    });
  }

  void autoScroll(PageController controller, int itemCount) {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (controller.hasClients) {
        int nextPage = controller.page!.toInt() + 1;
        if (nextPage >= itemCount) {
          nextPage = 0;
        }
        controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> _signUp(String eventName) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        String userEmail = currentUser.email!;
        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('User')
            .where('email', isEqualTo: userEmail)
            .get();
        if (userSnapshot.docs.isNotEmpty) {
          DocumentReference userDoc = userSnapshot.docs[0].reference;
          await userDoc.update({
            'eventName': eventName,
          });
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
         iconTheme: const IconThemeData(color: Colors.purple),
        title: Text("Discover Event",
         style: GoogleFonts.quicksand(
          fontSize: 24,
          color: Colors.white,
         ),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: eventsName.length + 1,
        itemBuilder: (context, index) {
          if (index < eventsName.length) {
            String eventName = eventsName[index].keys.first;
            List<String> images = eventsName[index][eventName]!;
            PageController pageController = pageControllers[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: images.length,
                    itemBuilder: (context, imageIndex) {
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(images[imageIndex]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: images.length,
                    effect: const WormEffect(
                      activeDotColor: Colors.purple,
                      dotColor: Colors.white,
                      dotHeight: 8.0,
                      dotWidth: 8.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          } else {
            List<String> storeNames = [
              'Birthday',
              'Gazzal Night',
              'Corporate Event',
              'Engagement',
              'Baby Shower',
              'Anniversary',
              'House Warming',
              'Carnival'
            ];
            List<List<Color>> gradientColors = [
              [Colors.purple.withOpacity(0.8), Colors.transparent],
              [Colors.red.withOpacity(0.8), Colors.transparent],
              [Colors.blue.withOpacity(0.8), Colors.transparent],
              [Colors.teal.withOpacity(0.8), Colors.transparent],
              [Colors.pinkAccent.withOpacity(0.8), Colors.transparent],
              [Colors.grey.withOpacity(0.8), Colors.transparent],
              [Colors.teal.withOpacity(0.8), Colors.transparent],
              [Colors.purple.withOpacity(0.8), Colors.transparent],
            ];
            List<String> eventDescriptions = [
              'Celebrate your special day with a grand bash!',
              'An exciting night filled with music and fun!',
              'A perfect gathering for your business needs.',
              'Make your engagement unforgettable with us!',
              'A joyful baby shower celebration awaits!',
              'Celebrate your anniversary in style and love!',
              'A warm gathering for house warming events!',
              'Join us for a fun and colorful carnival!',
            ];
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: storeNames.length,
              itemBuilder: (context, newIndex) {
                return Container(
                  margin: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      elevation: 5,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.black,
                    ),
                    onPressed: () {
                      _signUp(storeNames[newIndex]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventManagerPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(
                          image: AssetImage('assets/example/example${newIndex + 1}.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.topRight,
                                colors: gradientColors[newIndex % gradientColors.length],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 16,
                            child: Text(
                              storeNames[newIndex],
                              style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 50,
                            left: 16,
                            right: 16,
                            child: Text(
                              eventDescriptions[newIndex],
                              style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 16,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                              ),
                              child: Text(
                                'Enter ->',
                                style: GoogleFonts.quicksand(
                                  color: Colors.purple,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
  backgroundColor: Colors.grey[900],
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.white,
  showSelectedLabels: true,
  showUnselectedLabels: true,
  type: BottomNavigationBarType.fixed,
  selectedLabelStyle: GoogleFonts.quicksand(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  ),
  unselectedLabelStyle: GoogleFonts.quicksand(
    fontSize: 12,
    fontWeight: FontWeight.w300,
  ),
  items: [
    BottomNavigationBarItem(
      icon: IconButton(
        icon: const Icon(Icons.home, color: Colors.white, ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EventScreen()),
          );
        },
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: IconButton(
        icon: const Icon(Icons.history, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HistoryScreen()),
          );
        },
      ),
      label: 'History',
    ),
    BottomNavigationBarItem(
      icon: IconButton(
        icon: const Icon(Icons.account_circle, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
        },
      ),
      label: 'Profile',
    ),
  ],
),
    );
  }
}
