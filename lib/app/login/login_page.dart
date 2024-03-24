import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    super.key,
  });

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isCreatingAccount = false;
  var errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Najlepsza pizza we Wrocławiu'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isCreatingAccount == true
                  ? 'Zarejestruj się'
                  : 'Zaloguj się'),
              const SizedBox(height: 10),
              TextField(
                controller: widget.emailController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.lightGreen,
                  hintText: 'E-mail:',
                  hintStyle: TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: widget.passwordController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.lightGreen,
                  hintText: 'Password:',
                  hintStyle: TextStyle(fontSize: 15),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Text(errorMessage),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (isCreatingAccount == true) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: widget.emailController.text,
                              password: widget.passwordController.text);
                    } catch (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                    }
                  } else {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: widget.emailController.text,
                          password: widget.passwordController.text);
                    } catch (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                    }
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text(
                  isCreatingAccount == true ? 'Zarejestruj się' : 'Zaloguj się',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              if (isCreatingAccount == true) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = false;
                    });
                  },
                  child: const Text('Masz już konto?'),
                ),
              ],
              if (isCreatingAccount == false) ...[
                TextButton(
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = true;
                    });
                  },
                  child: const Text('Zarejestruj się'),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
