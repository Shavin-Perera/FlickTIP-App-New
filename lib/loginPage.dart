import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project1/createaccount.dart';
import 'package:project1/homePage.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  //login function with e-mail and password
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance; //create a firbase auth instance
    User? user; //hold user
    try {
      //sign in user with given email and pass
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      //user obj
      user = userCredential.user;
      //user not found
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found");
      }
    }
    return user; //return user
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
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
                  margin: EdgeInsets.fromLTRB(47, 0, 47, 42),
                  child: TextField(
                    controller: _passwordController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Enter your password",
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 31),
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
                      //login user with given inputs
                      User? user = await loginUsingEmailPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                          context: context);
                      print(user);
                      //check whethter user is null
                      if (user != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => homeScreen()),
                        );
                      }
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
                        'Don\'t have an account?',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const signIn()),
                          );
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Text(
                          'Create an account',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Colors.white,
                              decoration: TextDecoration.underline),
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
    );
  }
}
