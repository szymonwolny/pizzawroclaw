import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantsPageContent extends StatelessWidget {
  const RestaurantsPageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('restaurants')
          .orderBy('rating', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final documents = snapshot.data!.docs;

          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }

          return ListView(
            children: [
              for (final document in documents) ...[
                Dismissible(
                  key: ValueKey(document.id),
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(document['name']),
                              Text(document['pizza']),
                            ],
                          ),
                          Text(document['rating'].toString()),
                        ],
                      ),
                    ),
                  ),
                  onDismissed: (_) {
                    FirebaseFirestore.instance
                        .collection('restaurants')
                        .doc(document.id)
                        .delete();
                  },
                ),
              ]
            ],
          );
        } else {
          return const Text('No data');
        }
      },
    );
  }
}
