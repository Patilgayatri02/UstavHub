import 'package:flutter/material.dart';
import 'package:main_project/admin.dart';

import 'adrequest.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
         leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          iconSize:30,
          onPressed: () {
            Navigator.pop(context); 
          },
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.notifications,color: Colors.white,),
            iconSize: 30,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RequestPage()),
              );
            }
          ),
        ],

          backgroundColor: Colors.purple,
        ),

        body:SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                       const Text(
                   "Organized Events",
                    style: TextStyle(
                        fontSize: 24.0, 
                        fontWeight: FontWeight.bold,
                       color: Colors.purple, 
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
                    ],
                  ),
                ),
              ),
            ),

          
           bottomNavigationBar: BottomAppBar(
            color:Colors.purple,
            elevation: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.history,color: Colors.white,),
                    iconSize: 30,
                    onPressed: () {
                     // showHistoryDialog(context); 
                    },
                  ),
                  IconButton(
                  icon: Icon(Icons.person,color: Colors.white,),
                  iconSize: 30,
                   onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserScreen()),
                 );
                    },
                  ),
              
                ],
              ),
            ),
        
       backgroundColor: Colors.black,
      ),
    );
  }
}