import 'package:flutter/material.dart';
import 'package:vtsapp/screen/pages/dashboardadmin.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginAdminScreen extends StatefulWidget {
  const LoginAdminScreen({super.key});

  @override
  State<LoginAdminScreen> createState() => LoginAdminScreen_State();
}

class LoginAdminScreen_State extends State<LoginAdminScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isVisible = true;

  final formKey = GlobalKey<FormState>();
  Future<void> _login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Navigate to dashboard upon successful login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardAdmin()),
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An error occurred';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        } else {
          errorMessage = e.message ?? errorMessage;
        }
        // Show error message if authentication fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        print('Error: $e');
        // Show generic error message if authentication fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/piclogin.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Hello",
                      style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: Text(
                        "Sign In !",
                        style: TextStyle(color: Colors.white, fontSize: 35,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        image: DecorationImage(
                          image: AssetImage("images/signin.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 25,
                      left: 110,
                      child: Image.asset(
                        "images/usericon.png",
                        width: 180,
                        height: 180,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 180, left: 30, right: 30),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Email is Required";
                                    }
                                    return null;
                                  },
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white24,
                                    prefixIcon:
                                        Icon(Icons.email, color: Colors.blue),
                                    labelText: 'Email',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                SizedBox(height: 35),
                                TextFormField(
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Password is Required";
                                    }
                                    return null;
                                  },
                                  obscureText: isVisible,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white24,
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.blue),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      icon: Icon(
                                        isVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.white10,
                                      ),
                                    ),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 380,
                      right: 30,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Forgot Your Password?',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 400,
                      left: 30,
                      right: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600],
                          ),
                          onPressed: () {
                            _login(context);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 18),
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
    );
  }
}
