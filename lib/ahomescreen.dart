import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'anotification.dart';
import 'aprofile.dart';

class AdminHomeSreen extends StatefulWidget {
  const AdminHomeSreen({Key? key}) : super(key: key);

  @override
  _AdminHomeSreenState createState() => _AdminHomeSreenState();
}

class _AdminHomeSreenState extends State<AdminHomeSreen> {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                        Text(
                   "Events till now..!",
                     style: GoogleFonts.quicksand(
                      fontSize: 20, fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 167, 129, 174) )
                   
                ),
                  
                      const SizedBox(height: 20,),
                       Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/h.jpeg'), 
                             fit: BoxFit.cover, 
                          ),
                         border: Border.all(
                         color: Colors.white, 
                         width: 2.0, 
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                     ),
                   ),
                      
                      const SizedBox(height: 20,),
                    Container(
                      height: 200,
                        width:MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/m.jpeg'), 
                             fit: BoxFit.cover, 
                          ),
                         border: Border.all(
                         color: Colors.white, 
                         width: 2.0, 
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                     ),
                   ),
                        const SizedBox(height: 20,),
                  
                         Container(
                          height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/d.jpeg'), 
                             fit: BoxFit.cover, 
                          ),
                         border: Border.all(
                         color: Colors.white, 
                         width: 2.0, 
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                     ),
                   ),
                         const SizedBox(height: 20,),
                      
                       Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/s.jpeg'), 
                             fit: BoxFit.cover, 
                          ),
                         border: Border.all(
                         color: Colors.white, 
                         width: 2.0, 
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                     ),
                   ),
                      const SizedBox(height: 20,),
                  
                        Container(
                          height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/b.jpeg'), 
                             fit: BoxFit.cover, 
                          ),
                         border: Border.all(
                         color: Colors.white, 
                         width: 2.0, 
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                     ),
                   ),
                    ],
                  ),
                ),
              ),
            ),

         
       backgroundColor: Colors.black,
      ),
    );
  }
}