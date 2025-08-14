import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'setpass.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  Future<void> _checkEmailInFirestore(String email) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('User')
          .where('email', isEqualTo: email)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        _navigateToSetPassword();
        return;
      }

      final adminSnapshot = await FirebaseFirestore.instance
          .collection('Admin')
          .where('email', isEqualTo: email)
          .get();

      if (adminSnapshot.docs.isNotEmpty) {
        _navigateToSetPassword();
        return;
      }

      setState(() {
        _errorMessage = "Email not registered.";
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Something went wrong. Please try again.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _navigateToSetPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SetNewPasswordScreen()),
    );
  }

  void _submitForgotPassword() {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        _errorMessage = "Please enter your email.";
      });
      return;
    }

    _checkEmailInFirestore(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/act.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.purpleAccent),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: GoogleFonts.dancingScript(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Enter your email and we\'ll send you instructions',
                      style: GoogleFonts.quicksand(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _emailController,
                      style: GoogleFonts.quicksand(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: GoogleFonts.quicksand(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(137, 59, 57, 57),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _errorMessage!,
                          style: GoogleFonts.quicksand(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                   ElevatedButton(
  onPressed: _submitForgotPassword,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, 
    minimumSize: const Size(double.infinity, 48),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: EdgeInsets.zero, 
  ),
  child: InkWell(
    onTap: _submitForgotPassword,
    child: Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purpleAccent, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: double.infinity,
        height: 48, 
        alignment: Alignment.center,
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.black)
            : Text(
                'SUBMIT',
                style: GoogleFonts.quicksand(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
      ),
    ),
  ),
)
                  ],
                ),
              ),
            ],
          ),
        ),
      
      backgroundColor: Colors.black,
    );
  }
}
