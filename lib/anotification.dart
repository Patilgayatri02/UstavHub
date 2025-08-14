import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

 class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, dynamic>> fetchedUsers = [];
  String? managerEmail;
  String? managerName;

  @override
  void initState() {
    super.initState();
    getCurrentAdminEmail();
  }

  Future<void> getCurrentAdminEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        managerEmail = user.email;
      });
      await getManagerName();
      getUsersData();
    } else {
      print('No user is logged in');
    }
  }

  Future<void> getManagerName() async {
    if (managerEmail == null) return;
    try {
      var adminDoc = await FirebaseFirestore.instance
          .collection("Admin") 
          .where("email", isEqualTo: managerEmail)
          .limit(1)
          .get();

      if (adminDoc.docs.isNotEmpty) {
        setState(() {
          managerName = adminDoc.docs.first.data()['name'] ?? 'Manager';
        });
      }
    } catch (e) {
      print('Error fetching manager name: $e');
    }
  }

  Future<void> getUsersData() async {
    if (managerEmail == null) {
      return;
    }

    try {
      QuerySnapshot<Map<String, dynamic>> response =
          await FirebaseFirestore.instance
              .collection("Request")
              .where("managerEmail", isEqualTo: managerEmail)
              .get();

      for (var doc in response.docs) {
        Timestamp timestamp = doc.data()['selectedDate'];
        String formattedDate = timestamp.toDate().toLocal().toString().split(' ')[0]; 

        fetchedUsers.add({
          'id': doc.id,
          'name': doc.data()['userName'],
          'email': doc.data()['userEmail'],
          'event': doc.data()['eventName'],
          'date': formattedDate, 
        });
      }

      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> handleAction(String requestId, String action, String eventName) async {
    try {
      await FirebaseFirestore.instance
          .collection('Request')
          .doc(requestId)
          .update({'status': action});

      var requestDoc = await FirebaseFirestore.instance
          .collection('Request')
          .doc(requestId)
          .get();

      String userEmail = requestDoc.data()?['userEmail'] ?? '';
      if (userEmail.isEmpty) {
        print('Error: userEmail is missing for requestId $requestId');
        return;
      }

      String message = action == 'accepted'
          ? 'Your request has been accepted by $managerName.'
          : 'Your request has been rejected by $managerName.';

      await FirebaseFirestore.instance
          .collection('Notifications')
          .add({
        'userEmail': userEmail,
        'message': message,
        'requestId': requestId,
        'eventName': eventName,
        'actionRequired': action == 'accepted',
      });

      if (action == 'accepted') {
        setState(() {
          fetchedUsers.removeWhere((user) => user['id'] == requestId);
        });
      } else if (action == 'rejected') {
        await FirebaseFirestore.instance
            .collection('Request')
            .doc(requestId)
            .delete();

        setState(() {
          fetchedUsers.removeWhere((user) => user['id'] == requestId);
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request $action successfully!')),
      );
    } catch (e) {
      print('Error handling action: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to $action request: $e')),
      );
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.purpleAccent),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.quicksand(color: Colors.white, fontSize: 24),
        ),
      ),
    body: fetchedUsers.isEmpty
        ? Center(
            child: Text(
              'No notifications available',
              style: GoogleFonts.quicksand(color: Colors.white, fontSize: 18),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: fetchedUsers.length,
            itemBuilder: (context, index) {
              final user = fetchedUsers[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                color: Colors.grey.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                shadowColor: Colors.purpleAccent,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 35,
                            backgroundColor: Color.fromARGB(255, 223, 173, 232),
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user['name'] ?? 'Unknown Name',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  user['email'] ?? 'Unknown Email',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  user['event'] ?? 'Unknown Event',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    color: Colors.purpleAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  user['date'] ?? 'Unknown Date',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 16,
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => handleAction(
                                user['id'], 'accepted', user['event']),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 12,
                              ),
                            ),
                            child: Text(
                              'Accept',
                              style: GoogleFonts.quicksand(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => handleAction(
                                user['id'], 'rejected', user['event']),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 12,
                              ),
                            ),
                            child: Text(
                              'Reject',
                              style: GoogleFonts.quicksand(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    backgroundColor: Colors.black,
  );
}

}
