import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1/homePage.dart';
import 'package:project1/loginPage.dart';
import 'package:project1/main.dart';

void main() {
  runApp(FlickTip());
}

class signIn extends StatelessWidget {
  const signIn({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return MaterialApp(
      title: "CreateAccount",
      home: Scaffold(
        backgroundColor: const Color(0xFF000000),
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/blackimg.jpg"), fit: BoxFit.cover),
            ),
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 78,
                      width: 195,
                      margin: EdgeInsets.fromLTRB(0, 68, 0, 30),
                      child: Image.asset(
                        'images/logoimg.png',
                        fit: BoxFit.cover,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(47, 0, 262, 0),
                    child: Text(
                      'First name',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 41,
                    width: 292,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.fromLTRB(47, 0, 47, 21),
                    child: TextField(
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.person_outlined,
                          color: Colors.black,
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(47, 0, 293, 0),
                    child: Text(
                      'E-mail',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 41,
                    width: 292,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.fromLTRB(47, 0, 47, 21),
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Enter your e-mail",
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(47, 0, 267, 0),
                    child: Text(
                      'Password',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 41,
                    width: 292,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.fromLTRB(47, 0, 47, 21),
                    child: TextField(
                      controller: _passwordController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Enter a password",
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 21),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(122, 40),
                          backgroundColor: Color.fromRGBO(108, 92, 213, 1),
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          textStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      onPressed: () async {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text)
                            .then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginPage()),
                          );
                        }).onError((error, stackTrace) {
                          print("Error ${error.toString()}");
                        });
                      },
                      child: Text('Log in'),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          'have an account?',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                      Align(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const loginPage()),
                              );
                            },
                            style:
                                TextButton.styleFrom(padding: EdgeInsets.zero),
                            child: Text(
                              'Log in',
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
