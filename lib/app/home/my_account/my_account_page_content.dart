import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyAccountPageContent extends StatelessWidget {
  const MyAccountPageContent({
    super.key,
    required this.email,
  });

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Jesteś zalogowany jako $email'),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              'Wyloguj się',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
