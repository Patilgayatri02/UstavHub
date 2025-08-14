import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:main_project/adminlogin.dart';
import 'package:main_project/login.dart';
import 'package:animated_text_kit/animated_text_kit.dart'; // For animated text

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.signUpType});
  final String signUpType;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _workingSinceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _showPassword = false;

  void _signUp() async {
    final fullname = _fullnameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final workingSince = _workingSinceController.text.trim();
    final location = _locationController.text.trim();

    if (fullname.isEmpty || email.isEmpty || password.isEmpty) {
      _showMessage("Please fill in all fields.");
    } else {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (widget.signUpType == "Admin") {
          await FirebaseFirestore.instance.collection("Admin").add({
            "name": fullname,
            "email": email,
            "password": password,
            "workingSince": workingSince,
            "location": location,
          });
          _showMessage("Account created successfully!");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminLoginScreen(signUpType: "Admin"),
            ),
          );
        } else if (widget.signUpType == "User") {
          await FirebaseFirestore.instance.collection("User").add({
            "name": fullname,
            "email": email,
            "password": password,
          });
          _showMessage("Account created successfully!");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(signUpType: "User"),
            ),
          );
        }
      } catch (e) {
        _showMessage(e.toString());
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 320),
                  painter: CustomWavePainter(),
                ),
                Positioned.fill(
                  child: ClipPath(
                    clipper: CustomWaveClipper(),
                    child: Container(
                      height: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/act.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: DefaultTextStyle(
                style: GoogleFonts.dancingScript(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    FadeAnimatedText('Create Account'),
                    FadeAnimatedText('Sign Up Now!'),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  _buildTextField(
                    controller: _fullnameController,
                    hintText: 'Fullname',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 16),
                  _buildPasswordField(),
                  const SizedBox(height: 16),
                  widget.signUpType == "Admin"
                      ? _buildTextField(
                          controller: _workingSinceController,
                          hintText: 'Working Since',
                        )
                      : const SizedBox(),
                  const SizedBox(height: 16),
                  widget.signUpType == "Admin"
                      ? _buildTextField(
                          controller: _locationController,
                          hintText: 'Location',
                        )
                      : const SizedBox(),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: _signUp,
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purpleAccent, Colors.blueAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'SIGN UP',
                        style: GoogleFonts.quicksand(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LoginScreen(signUpType: ""),
                        ),
                      );
                    },
                    child: Text(
                      "Already have an account? Log In",
                      style: GoogleFonts.quicksand(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller, required String hintText}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
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
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: !_showPassword,
      style: const TextStyle(color: Colors.white),
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
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
          child: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}

class CustomWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.purpleAccent;

    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.25, size.height,
      size.width * 0.5, size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.6,
      size.width, size.height * 0.8,
    );
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CustomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.25, size.height,
      size.width * 0.5, size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.6,
      size.width, size.height * 0.8,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; 
  }
}

