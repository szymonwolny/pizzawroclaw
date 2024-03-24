import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizzawroclaw/app/home/add_opinion/add_opinion_page_content.dart';
import 'package:pizzawroclaw/app/home/my_account/my_account_page_content.dart';
import 'package:pizzawroclaw/app/home/restaurants/restaurants_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (context) {
            if (currentIndex == 0) {
              return const Text('Opinie');
            }

            if (currentIndex == 1) {
              return const Text('Dodaj opinię');
            }
            return const Text('Moje konto');
          },
        ),
        backgroundColor: Colors.green,
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const RestaurantsPageContent();
        }

        if (currentIndex == 1) {
          return AddOpinionPageContent(
            onSave: () {
              setState(() {
                currentIndex = 0;
              });
            },
          );
        }

        return MyAccountPageContent(email: widget.user.email);
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.reviews),
            label: 'Opinie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Dodaj opinię',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Moje konto',
          ),
        ],
      ),
    );
  }
}
