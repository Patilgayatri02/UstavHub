import 'package:flutter/material.dart';
import 'Umanagement.dart';
import 'ahomescreen.dart';
import 'anotification.dart';
import 'aprofile.dart';
import 'eventanalytics.dart';
import 'manageeventscreen.dart';
import 'setting.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const AdminHomeSreen(),         
    const ManageEventsScreen(),
    const ManageUsersScreen(),   
    const EventAnalyticsScreen(), 
    const SettingsScreen(),      
  ];

 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; 
    });
    Navigator.pop(context); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:Text("Dashboard", 
        style: GoogleFonts.quicksand(
                      fontSize: 24,
                      color: Colors.white,
        ),
        ),
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          
          IconButton(
            icon: Icon(Icons.notifications,color: Colors.white,),
            iconSize: 30,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            }
          ),
          IconButton(
                  icon: Icon(Icons.person,color: Colors.white,),
                  iconSize: 30,
                   onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                 );
                    },
                  ),

        ],

        
      ),
      body: _screens[_selectedIndex], 
      
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purpleAccent, Colors.blueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
              
              child: Center(
                child: Text(
                  "Admin Menu",
                  style: GoogleFonts.quicksand(
                        fontSize: 24,
                        color: Colors.white,
                  ),
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home, color: Color.fromARGB(255, 223, 173, 232)),
              title: Text(
                "Home",
                style: GoogleFonts.quicksand(
                      fontSize: 17,
                      color: Colors.white,
                ),
              ),
              onTap: () {
                _onItemTapped(0);
              },
            ),

          const SizedBox(height:20),

            ListTile(
              leading: const Icon(Icons.event, color: Color.fromARGB(255, 223, 173, 232)),
              title: Text(
                "Schedule Events",
                style: GoogleFonts.quicksand(
                      fontSize: 17,
                      color: Colors.white,
                ),
              ),
              onTap: () {
                _onItemTapped(1);
              },
            ),

             const SizedBox(height:20),

            // ListTile(
            //   leading: const Icon(Icons.people, color: Color.fromARGB(255, 223, 173, 232)),
            //   title: Text(
            //     "User Management",
            //     style: GoogleFonts.quicksand(
            //           fontSize: 17,
            //           color: Colors.white,
            //     ),
            //   ),
            //   onTap: () {
            //     _onItemTapped(2);
            //   },
            // ),

             //const SizedBox(height:20),

            ListTile(
              leading: const Icon(Icons.bar_chart, color: Color.fromARGB(255, 223, 173, 232)),
              title: Text(
                "Event Analytics",
                style: GoogleFonts.quicksand(
                      fontSize: 17,
                      color: Colors.white,
                ),
              ),
              onTap: () {
                _onItemTapped(3);
              },
            ),

             const SizedBox(height:20),

            ListTile(
              leading: const Icon(Icons.settings, color: Color.fromARGB(255, 223, 173, 232)),
              title: Text(
                "Settings",
                style: GoogleFonts.quicksand(
                      fontSize: 17,
                      color: Colors.white,
                ),
              ),
              onTap: () {
                _onItemTapped(4);
              },
            ),
          ],
        ),
      ),
    );
  }
}