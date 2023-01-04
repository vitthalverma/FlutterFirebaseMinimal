import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.showLoginPage});
  final VoidCallback showLoginPage;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (_emailController.text.isEmpty &&
        _passwordController.text.isEmpty &&
        _ageController.text.isEmpty &&
        _firstnameController.text.isEmpty &&
        _lastnameController.text.isEmpty &&
        _confirmPasswordController.text.isEmpty) {
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              backgroundColor: Colors.grey.shade200,
              content: Container(
                height: 40,
                child: Center(
                    child: Text(
                  'Fill all the details!! ',
                  style: GoogleFonts.bebasNeue(fontSize: 22),
                )),
              ),
            );
          }));
    }
    if (passwordConfirmed()) {
      //creates user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      //add user details
      addUserDetails(
        _firstnameController.text.trim(),
        _lastnameController.text.trim(),
        _emailController.text,
        int.parse(_ageController.text.trim()),
      );
    } else {
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              backgroundColor: Colors.grey.shade200,
              content: Container(
                height: 40,
                child: Center(child: Text('Mismatching Passwords!!!')),
              ),
            );
          }));
    }
  }

  Future addUserDetails(
      String firstName, String lastName, String email, int age) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'age': age,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text == _confirmPasswordController.text) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: Colors.grey.shade300),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 80),
                Center(
                  child: Text(
                    'Hello There!',
                    style: GoogleFonts.bebasNeue(fontSize: 50),
                  ),
                ),
                Text(
                  'Register below with your details',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                  ),
                  child: TextField(
                    controller: _firstnameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'First Name',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                  ),
                  child: TextField(
                    controller: _lastnameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Last Name',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                  ),
                  child: TextField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Age',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                  ),
                  child: TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Confirm Password',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: signUp,
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.deepPurple,
                    ),
                    child: const Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('I am a member ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        'Login Now',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
