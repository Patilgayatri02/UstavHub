import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:main_project/admin.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    if (userEmail == null || userName == null) {
      _getCurrentUserEmail();
    }
  }

  Future<void> _getCurrentUserEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        setState(() {
          userEmail = user.email;
        });
        await fetchUserData();
      }
    } catch (e) {
      print('Error getting current user email: $e');
    }
  }

  Future<void> fetchUserData() async {
    if (userEmail == null) return;

    try {
      QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
          .instance
          .collection('User') 
          .where('email', isEqualTo: userEmail)
          .get();

      if (response.docs.isNotEmpty) {
        var userData = response.docs.first.data();
        setState(() {
          userName = userData['name'] ?? "No Name Found";
        });
      } else {
        setState(() {
          userName = "No Name Found";
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void _logout() {
    FirebaseAuth.instance.signOut().then((_) {
      setState(() {
        userName = null; 
        userEmail = null; 
      });
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Profile',
          style: GoogleFonts.quicksand(color: Colors.white, fontSize: 24),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Color.fromARGB(255, 213, 151, 224),
                    child: Icon(
                      Icons.person,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName ?? 'Fetching Name...',
                        style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userEmail ?? 'Fetching Email...',
                        style: GoogleFonts.quicksand(
                            color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          _buildProfileOption(
            icon: Icons.account_circle,
            title: 'Account',
            subtitle: 'Security notifications, change number',
          ),
          _buildProfileOption(
            icon: Icons.privacy_tip,
            title: 'Privacy',
            subtitle: 'Block contacts, disappearing messages',
          ),
          _buildProfileOption(
            icon: Icons.language,
            title: 'App Language Data',
            subtitle: 'English (device language)',
          ),
          GestureDetector(
            onTap: (){
             Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserScreen()),);
            },
            child: _buildProfileOption(
              icon: Icons.logout_sharp,
              title: 'Logout',
              subtitle: 'Logout from app',
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromARGB(255, 241, 184, 251)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.quicksand(
                    color: Colors.purple, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.quicksand(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
