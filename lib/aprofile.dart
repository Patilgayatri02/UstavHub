import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project/admin.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
              icon:  Icon(Icons.arrow_back,color: Colors.purple,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
        title: Text(
          'Profile',
          style: GoogleFonts.quicksand(color: Colors.white,fontSize: 24)
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
               
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(12),
                  ),
              
              padding: const EdgeInsets.symmetric(vertical: 12),
                    
              child:  Row(
                
                children: [
                  const SizedBox(width:10),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color.fromARGB(255, 213, 151, 224),
                    child: Icon(
                      Icons.person,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sai Shinde',
                        style: GoogleFonts.quicksand(color: Colors.white,fontSize: 18,fontWeight:FontWeight.bold)
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                Icon(Icons.account_circle, color: Color.fromARGB(255, 241, 184, 251)),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Account', style: GoogleFonts.quicksand(color: Colors.purple,fontSize: 16)),
                    SizedBox(height: 4),
                    Text(
                      'Security notifications, change number',
                      style: GoogleFonts.quicksand(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                Icon(Icons.privacy_tip, color: Color.fromARGB(255, 241, 184, 251)),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Privacy', style:GoogleFonts.quicksand(color: Colors.purple,fontSize: 16,)),
                    SizedBox(height: 4),
                    Text(
                      'Block contacts, disappearing messages',
                      style: GoogleFonts.quicksand(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                Icon(Icons.language, color: Color.fromARGB(255, 241, 184, 251)),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('App Language Data', style: GoogleFonts.quicksand(color: Colors.purple,fontSize: 16)),
                    SizedBox(height: 4),
                    Text('English (device language)', style: GoogleFonts.quicksand(color: Colors.white,)),
                  ],
                ),
              ],
            ),
          ),

          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: Row(
                children: [
                  Icon(Icons.logout_sharp, color: Color.fromARGB(255, 241, 184, 251)),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Logout', style: GoogleFonts.quicksand(color: Colors.purple,fontSize: 16,)),
                      SizedBox(height: 4),
                      Text('Logout from app', style: GoogleFonts.quicksand(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserScreen()),
      
                        
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
