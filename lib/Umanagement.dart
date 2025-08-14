import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({Key? key}) : super(key: key);

  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  List<Map<String, dynamic>> _users = [];
  TextEditingController _searchController = TextEditingController();
  String? managerEmail;

  @override
  void initState() {
    super.initState();
    _getManagerEmail();
    _loadUsers();
  }

  void _getManagerEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        managerEmail = user.email;
      });
    }
  }

  void _loadUsers() async {
    if (managerEmail != null) {

      FirebaseFirestore.instance
          .collection('User')
          .where('addedBy', isEqualTo: managerEmail)
          .snapshots()
          .listen((snapshot) {
        setState(() {
          _users = snapshot.docs
              .map((doc) => {
                    'id': doc.id,
                    'name': doc['name'],
                    'email': doc['email'],
                    'addedBy': doc['addedBy'],
                  })
              .toList();
        });
      });
    }
  }

  void _addUser(String name, String email) async {
    if (managerEmail != null) {
      await FirebaseFirestore.instance.collection('User').add({
        'name': name,
        'email': email,
        'addedBy': managerEmail,  
      });
      _loadUsers();  
    }
  }

  void _editUser(String id, String name, String email) async {
    if (managerEmail != null) {
      await FirebaseFirestore.instance.collection('User').doc(id).update({
        'name': name,
        'email': email,
        'addedBy': managerEmail,  
      });
      _loadUsers();  
    }
  }

  void _deleteUser(String id) async {
    await FirebaseFirestore.instance.collection('User').doc(id).delete();
    _loadUsers();  
  }

  List<Map<String, dynamic>> _filterUsers(String query) {
    return _users.where((user) {
      return user['name'].toLowerCase().contains(query.toLowerCase()) ||
          user['email'].toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text("Manage Users",
            style: GoogleFonts.quicksand(
                fontSize: 17, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 223, 173, 232))),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search users...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: _filterUsers(_searchController.text).isEmpty
                  ?  Center(child: Text("No users available.",
                  style: GoogleFonts.quicksand(fontSize: 15, color: Colors.grey),
                  ))
                  : ListView.builder(
                      itemCount: _filterUsers(_searchController.text).length,
                      itemBuilder: (context, index) {
                        final user = _filterUsers(_searchController.text)[index];
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          color: const Color.fromARGB(255, 45, 45, 45),
                          child: ListTile(
                            title: Text(
                              user['name'],
                              style: GoogleFonts.quicksand(
                                  color: Colors.white, fontSize: 18),
                            ),
                            subtitle: Text(
                              user['email'],
                              style: GoogleFonts.quicksand(color: Colors.white70),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.purpleAccent),
                                  onPressed: () {
                                    _showEditUserDialog(user);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    _deleteUser(user['id']);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _showAddUserDialog();
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New User"),
              style: ElevatedButton.styleFrom(
                backgroundColor:  Color.fromARGB(255, 223, 173, 232),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddUserDialog() {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Fullname'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _addUser(usernameController.text, emailController.text);
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void _showEditUserDialog(Map<String, dynamic> user) {
    final TextEditingController usernameController = TextEditingController(text: user['name']);
    final TextEditingController emailController = TextEditingController(text: user['email']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Fullname'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _editUser(user['id'], usernameController.text, emailController.text);
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
