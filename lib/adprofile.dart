import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({Key? key}) : super(key: key);

  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  String? adminName;
  String? adminEmail;

  @override
  void initState() {
    super.initState();
    _fetchAdminData();
  }

  Future<void> _fetchAdminData() async {
    try {
      // Get the current admin's email
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('No admin is logged in.');
        return;
      }
      adminEmail = user.email;

      // Fetch admin details from Firestore
      QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
          .instance
          .collection('Admin')
          .where('email', isEqualTo: adminEmail)
          .get();

      if (response.docs.isNotEmpty) {
        var adminData = response.docs.first.data();
        setState(() {
          adminName = adminData['name'] ?? 'No Name Found';
        });
      } else {
        print('No admin found with the email $adminEmail.');
        setState(() {
          adminName = 'No Name Found';
        });
      }
    } catch (e) {
      print('Error fetching admin data: $e');
    }
  }

  void _logout() {
    FirebaseAuth.instance.signOut().then((_) {
      setState(() {
        adminName = null;
        adminEmail = null;
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
          'Admin Profile',
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
                        adminName ?? 'Fetching Name...',
                        style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        adminEmail ?? 'Fetching Email...',
                        style: GoogleFonts.quicksand(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Example profile options
          _buildProfileOption(
            icon: Icons.account_circle,
            title: 'Account',
            subtitle: 'Manage your account details',
          ),
          _buildProfileOption(
            icon: Icons.privacy_tip,
            title: 'Privacy',
            subtitle: 'Control your privacy settings',
          ),
          GestureDetector(
            onTap: _logout,
            child: _buildProfileOption(
              icon: Icons.logout,
              title: 'Logout',
              subtitle: 'Sign out of your account',
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
                  color: Colors.purple,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
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
