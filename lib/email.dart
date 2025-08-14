import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailSignInScreen extends StatefulWidget {
  const EmailSignInScreen ({super.key});

  @override
  _EmailSignInScreenState createState() => _EmailSignInScreenState();
}

class _EmailSignInScreenState extends State<EmailSignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
                                       width: 50,
                                       height: 50,
                                       decoration:const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                        image: AssetImage('assets/wrapper.png'),
                                        fit: BoxFit.cover,
                                     ),
                                   ),
                                ),
        ),
        title: Text("Sign In With Google",
        style:  GoogleFonts.quicksand(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent,
                          ),
        ),
        
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                const Icon(
                  Icons.open_in_browser, 
                  size: 30,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Text(
                  "Sign in",
                  style: GoogleFonts.quicksand(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                          ),
                ),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(height: 16),

          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading:CircleAvatar(
                    backgroundColor: Colors.purpleAccent,
                    child:  Text("A", style: GoogleFonts.quicksand(
                    fontSize:24 ,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                          ),),
                  ),
                  title: Text("abc",style:GoogleFonts.quicksand(
                    fontSize:17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                          ),) ,
                  subtitle: Text("abc123@gmail.com",style: GoogleFonts.quicksand(
                    fontSize:17 ,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                          ),),
                  onTap: () {
                  
                  },
                ),
                const Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Text("X", style: GoogleFonts.quicksand(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent,
                          ),),
                  ),
                  title: Text("XYZ",style: GoogleFonts.quicksand(
                    fontSize:17 ,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                          ),),
                  subtitle: Text("XYZ@gmail.com",style: GoogleFonts.quicksand(
                    fontSize:17 ,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                          ),),
                  onTap: () {
                    
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.person_add_alt_1, color: Colors.white),
                  title: Text("Use another account",style: GoogleFonts.quicksand(
                    fontSize:17 ,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                          ),),
                  onTap: () {
                  },
                ),
              ],
            ),
          ),

          
        
        ],
      ),
    );
  }
}