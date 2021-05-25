import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchedArtistList extends StatelessWidget {
  final _artistStream = FirebaseFirestore.instance
      .collection("SearchedArtists")
      .orderBy("time")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: StreamBuilder(
        stream: _artistStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error occurred loading data.");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final List<Widget> result = snapshot.data.docs.map<Widget>((doc) {
            return ListTile(
              title: Text(doc["name"]),
            );
          }).toList();

          return ListView.separated(
            itemCount: result.length,
            itemBuilder: (_, i) => result[i],
            separatorBuilder: (_, __) => Divider(),
          );
        },
      ),
    );
  }
}