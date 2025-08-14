import "package:flutter/material.dart";
import "adhomepade.dart";
import "adprofile.dart";



class RequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
     
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminHomePage(),
                            ),
                          );
       
          },
        ),
        title: const Text("Notifications",style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon:const  Icon(Icons.person, color: Colors.white),
            onPressed: () {
             Navigator.push(
              context,
                MaterialPageRoute(builder: (context) => AdminProfilePage()),
        );

            },
          ),
        ],
      ),
      body: Column(
        children: [
          
          Expanded(
            child: ListView.builder(
              itemCount: 10, 
              itemBuilder: (context, index) {
                return NotificationCard(
                  profileImage: AssetImage("assets/b.jpeg"), 
                  userName: "Sahil Bansode ${index + 1}",
                );
              },
            ),
          ),

          
          Container(
            color: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
              
                  },
                  child: Text(
                    "Pending",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                  
                  },
                  child: Text(
                    "Accepted",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class NotificationCard extends StatelessWidget {
  final ImageProvider profileImage;
  final String userName;

  NotificationCard({required this.profileImage, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: Colors.black54,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 1.5), 
        borderRadius: BorderRadius.circular(8), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            CircleAvatar(
              backgroundImage: profileImage,
              radius: 30,
            ),
            SizedBox(width: 10),

        
            Expanded(
              child: Text(
                userName,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

            Column(
              children: [
                SizedBox(
                  height: 30, 
                  width: 140,
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text(
                      "Accept",
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10), 
                SizedBox(
                  height: 30,
                  width: 140,
                  child: ElevatedButton(
                    onPressed: () {
                      
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text(
                      "Reject",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
               
              ],
            ),
          ],
        ),
      ),
    );
  }
}