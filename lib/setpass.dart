import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'adminlogin.dart';
import 'login.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  _SetNewPasswordScreenState createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _errorMessage;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  
  get email => null; 

  Future<void> _updatePassword(String newPassword) async {
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
        final userDoc = userSnapshot.docs.first;
        await userDoc.reference.update({'password': newPassword});
        _navigateToLoginScreen('user');
        return;
      }

      final adminSnapshot = await FirebaseFirestore.instance
          .collection('Admin')
          .where('email', isEqualTo: email)
          .get();

      if (adminSnapshot.docs.isNotEmpty) {
        final adminDoc = adminSnapshot.docs.first;
        await adminDoc.reference.update({'password': newPassword});
        _navigateToLoginScreen('admin');
        return;
      }

      setState(() {
        _errorMessage = "Account not found.";
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

  void _navigateToLoginScreen(String userType) {
    if (userType== 'User') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(signUpType: '',), 
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminLoginScreen(signUpType: '',), 
        ),
      );
    }
  }

  void _submitNewPassword() {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorMessage = "Please fill in all fields.";
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = "Passwords do not match.";
      });
      return;
    }

    _updatePassword(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.purpleAccent),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Set New Password',
                  style: GoogleFonts.dancingScript(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 24),
                // ElevatedButton(
                //   onPressed: _isLoading ? null : _submitNewPassword,
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.purpleAccent,
                //     minimumSize: const Size(double.infinity, 48),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //   ),
                //   child: _isLoading
                //       ? const CircularProgressIndicator(color: Colors.black)
                //       : Text(
                //           'SUBMIT',
                //           style: GoogleFonts.quicksand(
                //             fontSize: 17,
                //             fontWeight: FontWeight.bold,
                //             color: Colors.black,
                //           ),
                //         ),
                // ),
                ElevatedButton(
  onPressed: _submitNewPassword,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    padding: EdgeInsets.zero, 
  ),
  child: InkWell(
    onTap: _submitNewPassword,
    child: Ink(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purpleAccent, Colors.blueAccent], // Gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: double.infinity,
        height: 48, // Same height as the ElevatedButton
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
          const Spacer(),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
