import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hci_a2_app/provider/artist.dart';
import 'package:hci_a2_app/screens/home.dart';
import 'package:provider/provider.dart';

class RecentSearchesScreen extends StatelessWidget {
  static const routeName = '/recent';

  @override
  Widget build(BuildContext context) {
    final artistProvider = Provider.of<ArtistProvider>(context);
    // we obtain all searched artists in order of search request
    final _artistStream = FirebaseFirestore.instance
        .collection("SearchedArtists")
        .withConverter(
            fromFirestore: (snapshot, _) => Artist.fromJsonFirebase(snapshot.data()),
            toFirestore: (providedArtist, _) => providedArtist.toJsonFirebase())
        .orderBy("time")
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Searches'),
      ),
      body: Container(
        color: Colors.white,
        // rebuilds on every change of searched artists
        child: StreamBuilder(
          stream: _artistStream,
          // ! static type here with artist makes it possible to work with 
          // ! artist types instead of dynamic when getting data of snapshot
          builder: (context, AsyncSnapshot<QuerySnapshot<Artist>> snapshot) {
            if (snapshot.hasError) {
              return Text("Error occurred loading data.");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            // every doc (-> artist) gets mapped to a ListTile
            // those ListTiles build the ListView
            final result = snapshot.data.docs.map<Widget>((doc) {
              return InkWell(
                // go back to homescreen
                onTap: () {
                  artistProvider.set(doc.data());
                  Navigator.of(context).pushNamed(HomeScreen.routeName);
                },
                child: ListTile(
                  title: Text(doc["name"]),
                ),
              );
            }).toList();

            return ListView.separated(
              itemCount: result.length,
              itemBuilder: (_, i) => result[i],
              separatorBuilder: (_, __) => Divider(),
            );
          },
        ),
      ),
    );
  }
}
