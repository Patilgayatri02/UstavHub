import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project/birthday.dart';
import 'package:main_project/corporate.dart';
import 'package:main_project/engagement.dart';
import 'package:main_project/gazzal.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> notificationsList = [];
  String? userEmail;

  final List<Map<String, dynamic>> events = [
    {
      'eventName': 'Birthday',
      'screen': BirthdayPage(),
    },
    {
      'eventName': 'Corporate Event',
      'screen': CorporatePage(),
    },
    {
      'eventName': 'Engagement',
      'screen': EngagementPage(),
    },
    {
      'eventName': 'Gazzal Night',
      'screen': GazzalPage(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentUserEmail();
  }

  Future<void> _getCurrentUserEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        setState(() {
          userEmail = user.email;
        });
        fetchNotifications();
      }
    } catch (e) {
      print('Error getting current user email: $e');
    }
  }

  Future<void> fetchNotifications() async {
    if (userEmail == null) return;
    try {
      QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
          .instance
          .collection('Notifications')
          .where('userEmail', isEqualTo: userEmail)
          .get();

      notificationsList = response.docs.map((doc) {
        return {
          'notificationId': doc.id,
          'message': doc.data()['message'],
          'actionRequired': doc.data()['actionRequired'],
          'eventName': doc.data()['eventName'],
        };
      }).toList();

      setState(() {});
    } catch (e) {
      print('Error fetching notifications: $e');
    }
  }

  void navigateToEventScreen(String eventName) {
    final matchingEvent = events.firstWhere(
      (event) => event['eventName'] == eventName,
      orElse: () => {},
    );

    if (matchingEvent.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => matchingEvent['screen'],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No screen found for event: $eventName')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.purple),
        title: Text(
          'Notifications',
          style: GoogleFonts.quicksand(color: Colors.white,fontSize: 24),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: notificationsList.isEmpty
          ? Center(
              child: Text(
                'No Notifications',
                style: GoogleFonts.quicksand(color: Colors.white),
              ),
            )
          : ListView.builder(
              itemCount: notificationsList.length,
              itemBuilder: (context, index) {
                var notification = notificationsList[index];
                return GestureDetector(
                  child: Card(
                    color: Colors.grey[800],
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                       title:Column(
                        children: [
                          Text(
                        notification['message'] ?? 'No message',
                        style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontSize: 16.0,
                        
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                     const SizedBox(height: 10,),
                      Text(
                        notification['eventName'] ?? '',
                        style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                  
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),


                        ],
                       ),
                       
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check_circle,
               
                                color: Colors.green),
                            onPressed: () {
                              if (notification['actionRequired'] == true) {
                                FirebaseFirestore.instance
                                    .collection('Notifications')
                                    .doc(notification['notificationId'])
                                    .update({
                                  'actionTaken': true,
                                });

                                final eventName =
                                    notification['eventName'];
                                if (eventName != null) {
                                  navigateToEventScreen(eventName);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                    content: Text(
                                        'No action required for this notification',
                                        style: GoogleFonts.quicksand( fontSize: 12 ),),
                                  ),
                                );
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.purple),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('Notifications')
                                  .doc(notification['notificationId'])
                                  .delete();
                              setState(() {
                                notificationsList.removeAt(index);
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Notification Deleted', style: GoogleFonts.quicksand( fontSize: 12 ),)),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}




















































































































































// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:main_project/birthday.dart';
// import 'package:main_project/corporate.dart';
// import 'package:main_project/engagement.dart';
// import 'package:main_project/guzzle.dart';

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
//   List<Map<String, dynamic>> notificationsList = [];
//   String? userEmail;

//   final List<Map<String, dynamic>> events = [
//     {
//       'eventName': 'Birthday',
//       'screen': BirthdayPage(),
//     },
//     {
//       'eventName': 'Corporate Event',
//       'screen': CorporatePage(), 
//     },
//     {
//       'eventName': 'Engagement',
//       'screen': EngagementPage(),
//     },
//     {
//       'eventName': 'Guzzle Night',
//       'screen': GuzzlePage(),
//     },
//   ];


//   @override
//   void initState() {
//     super.initState();
//     _getCurrentUserEmail(); 
//   }

//   Future<void> _getCurrentUserEmail() async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;

//       if (user != null) {
//         setState(() {
//           userEmail = user.email; 
//         });
//         fetchNotifications(); 
//       } 
//     } catch (e) {
//       print('Error getting current user email: $e');
//     }
//   }

//   Future<void> fetchNotifications() async {
//     if (userEmail == null) return;
//     try {
//       QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
//           .instance
//           .collection('Notifications')
//           .where('userEmail', isEqualTo: userEmail) 
//           .get();

//       notificationsList = response.docs.map((doc) {
//         return {
//           'notificationId': doc.id,
//           'message': doc.data()['message'], 
//           'actionRequired': doc.data()['actionRequired'],
//           'eventName':doc.data()["eventName"] 
//         };
//       }).toList();

//       setState(() {}); 
//     } catch (e) {
//       print('Error fetching notifications: $e');
//     }
//   }

//     void navigateToEventScreen(String eventName) {
//     final matchingEvent = events.firstWhere(
//       (event) => event['eventName'] == eventName,
//       orElse: () => {},
//     );

//     if (matchingEvent.isNotEmpty) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => matchingEvent['screen'],
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('No screen found for event: $eventName')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text(
//           'Notifications',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//       ),
//       body: notificationsList.isEmpty
//           ? const Center(
//               child: Text(
//                 'No Notifications',
//                 style: TextStyle(color: Colors.white),
//               ),
//             )
//           : ListView.builder(
//   itemCount: notificationsList.length,
//   itemBuilder: (context, index) {
//     var notification = notificationsList[index];
//     return GestureDetector(
//       onTap: () {
//         if (notification['actionRequired'] == true) {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: const Text('Take Action'),
//                 content: Text(notification['message']),
//                 actions: [
//                   TextButton(
//                     onPressed: () {
//                       FirebaseFirestore.instance
//                           .collection('Notifications')
//                           .doc(notification['notificationId'])
//                           .update({
//                         'actionTaken': true,
//                       });
//                       final eventName = notification['eventName'];
//                     if (eventName != null) {
//                       navigateToEventScreen(eventName);
//                     }
                      
//                     },
//                     child: const Text('Take Action'),
//                   ),
//                 ],
//               );
//             },
//           );
//         } else {
//           FirebaseFirestore.instance
//               .collection('Notifications')
//               .doc(notification['notificationId'])
//               .delete();
//           setState(() {
//             notificationsList.removeAt(index);
//           });

//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Notification Deleted')),
//           );
//         }
//       },
//       child: Card(
//         color: Colors.grey[800],
//         margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
//         child: ListTile(
//           contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//           title: Text(
//             notification['message'] ?? 'No message',
//             style: const TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w500),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),

//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.check_circle, color: Colors.green),
//                 onPressed: notification['actionRequired'] == true
//                     ? () {
//                         FirebaseFirestore.instance
//                             .collection('Notifications')
//                             .doc(notification['notificationId'])
//                             .update({
//                           'actionTaken': true,
//                         });
//                         final eventName = notification['eventName'];
//                     if (eventName != null) {
//                       navigateToEventScreen(eventName);
//                     }
                        
                        
//                       }
//                     : null,
//               ),
//               IconButton(
//                 icon: const Icon(Icons.delete, color: Colors.purple),
//                 onPressed: () {
//                   FirebaseFirestore.instance
//                       .collection('Notifications')
//                       .doc(notification['notificationId'])
//                       .delete();
//                   setState(() {
//                     notificationsList.removeAt(index);
//                   });

//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Notification Deleted')),
//                   );
//                 },
//               ),
//           ],
//           ),
//         ),
//       ),
//     );
//   },
// )

//     );
//   }
// }