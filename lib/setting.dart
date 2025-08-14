import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project/admin.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _selectedLanguage = "English";
  bool _notificationsEnabled = true;


  String _adminUsername = "Admin";
  String _adminEmail = "admin@gmail.com";

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = _adminUsername;
    _emailController.text = _adminEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
        title:Text("Settings", style: GoogleFonts.quicksand(
                fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 223, 173, 232)),
        
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildProfileSection(),

            _buildThemeSection(),

            _buildLanguageSection(),

            _buildNotificationSection(),

            _buildBackupSection(),

            _buildHelpSection(),

           // _buildLogOutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[900],
      child: ListTile(
        title:Text("Profile", style: GoogleFonts.quicksand(
                fontSize: 16, color:Colors.white)),
        subtitle: Text("Username: $_adminUsername\nEmail: $_adminEmail", style: GoogleFonts.quicksand(
                fontSize: 12, color:Colors.white)),
        trailing: const Icon(Icons.edit, color: Color.fromARGB(255, 223, 173, 232),),
        onTap: () {
          _showEditProfileDialog();
        },
      ),
    );
    
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _adminUsername = _usernameController.text;
                _adminEmail = _emailController.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSection() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[900],
      child: SwitchListTile(
        title: Text("Dark Mode", style: GoogleFonts.quicksand(
                fontSize: 16, color:Colors.white)),
        subtitle: Text(_isDarkMode ? "Enabled" : "Disabled", style: GoogleFonts.quicksand(
                fontSize: 12, color:Colors.white)),
        value: _isDarkMode,
        onChanged: (value) {
          setState(() {
            _isDarkMode = value;
          });
        },
      ),
    );
  }

  Widget _buildLanguageSection() {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text("Language", style: GoogleFonts.quicksand(
                fontSize: 16, color:Colors.white)),
        subtitle: Text("Selected: $_selectedLanguage", style: GoogleFonts.quicksand(
                fontSize: 12, color:Colors.white)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Color.fromARGB(255, 223, 173, 232),),
        onTap: () {
          _showLanguageDialog();
        },
      ),
    );
    
  }

  Widget _buildNotificationSection() {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: SwitchListTile(
        title:Text("Notifications", style: GoogleFonts.quicksand(
                fontSize: 16, color:Colors.white)),
        subtitle: Text(_notificationsEnabled ? "Enabled" : "Disabled", style: GoogleFonts.quicksand(
                fontSize: 12, color:Colors.white)),
        value: _notificationsEnabled,
        onChanged: (value) {
          setState(() {
            _notificationsEnabled = value;
          });
        },
      ),
    );
  }

  Widget _buildBackupSection() {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text("Backup & Sync", style: GoogleFonts.quicksand(
                fontSize: 16, color:Colors.white)),
        subtitle: Text("Sync your data to the cloud.", style: GoogleFonts.quicksand(
                fontSize: 12, color:Colors.white)),
        trailing: const Icon(Icons.cloud_upload, color: Color.fromARGB(255, 223, 173, 232),),
        onTap: () {
          _showBackupConfirmationDialog();
        },
      ),
    );
  }

  Widget _buildHelpSection() {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title:Text("Help & Support", style: GoogleFonts.quicksand(
                fontSize: 16, color:Colors.white)),
        subtitle: Text("Get help with using the app.", style: GoogleFonts.quicksand(
                fontSize: 12, color:Colors.white)),
        trailing: const Icon(Icons.help_outline, color: Color.fromARGB(255, 223, 173, 232),),
        onTap: () {
          _showHelpDialog();
        },
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Help & Support", style: GoogleFonts.quicksand(
                fontSize: 16, color:Colors.white)),
        content: Text("For assistance, please contact support@yourapp.com or visit our website.", style: GoogleFonts.quicksand(
                fontSize: 12, color:Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // Widget _buildLogOutButton() {
  //   return Card(
  //     color: Colors.grey[900],
  //     margin: const EdgeInsets.symmetric(vertical: 8),
  //     child: ListTile(
  //       title:Text("Log Out", style: GoogleFonts.quicksand(
  //               fontSize: 16, color:Colors.white)),
  //       onTap: () {
  //         Navigator.pop(context); 
  //       },
  //     ),
  //   );
  // }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Language"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("English"),
              onTap: () {
                setState(() {
                  _selectedLanguage = "English";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Marathi"),
              onTap: () {
                setState(() {
                  _selectedLanguage = "Marathi";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Hindi"),
              onTap: () {
                setState(() {
                  _selectedLanguage = "Hindi";
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBackupConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Backup Data"),
        content: const Text("Are you sure you want to back up your data to the cloud?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showBackupSuccess();
            },
            child: const Text("Back Up"),
          ),
        ],
      ),
    );
  }

  void _showBackupSuccess() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Backup Successful"),
        content: const Text("Your data has been successfully backed up to the cloud."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserScreen()),
      ),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}