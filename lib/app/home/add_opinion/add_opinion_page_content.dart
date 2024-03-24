import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddOpinionPageContent extends StatefulWidget {
  const AddOpinionPageContent({super.key, required this.onSave});

  final Function onSave;

  @override
  State<AddOpinionPageContent> createState() => _AddOpinionPageContentState();
}

class _AddOpinionPageContentState extends State<AddOpinionPageContent> {
  var restaurantName = '';
  var pizzaName = '';
  var rating = 1.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (newValue) {
                setState(() {
                  restaurantName = newValue;
                });
              },
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.lightGreen,
                hintText: 'Restaurant name:',
                hintStyle: TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              onChanged: (newValue) {
                setState(() {
                  pizzaName = newValue;
                });
              },
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.lightGreen,
                hintText: 'Pizza name:',
                hintStyle: TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(height: 10),
            Slider(
                value: rating,
                divisions: 10,
                min: 1.0,
                max: 6.0,
                label: rating.toString(),
                onChanged: (newValue) {
                  setState(() {
                    rating = newValue;
                  });
                }),
            ElevatedButton(
              onPressed: restaurantName.isEmpty || pizzaName.isEmpty
                  ? null
                  : () {
                      FirebaseFirestore.instance.collection('restaurants').add({
                        'name': restaurantName,
                        'pizza': pizzaName,
                        'rating': rating
                      });
                      widget.onSave();
                    },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
