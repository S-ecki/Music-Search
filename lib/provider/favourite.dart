// to keep track of favourites
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hci_a2_app/provider/artist.dart';
import '../firestore/functions.dart';

class FavouriteArtistProvider with ChangeNotifier {
  List<Artist> _favourites = [];

  final collectionRef;

  FavouriteArtistProvider()
      : collectionRef = FirebaseFirestore.instance
            .collection("FavouriteArtists")
            .withConverter(
              // dont have to use json not
              fromFirestore: (snapshot, _) =>
                  Artist.fromJsonFirebase(snapshot.data()),
              toFirestore: (providedArtist, _) =>
                  providedArtist.toJsonFirebase(),
            ) {
    listenToFavourites();
  }

  List<Artist> get list {
    // spread and make list again to copy instead of pass ptr
    return [..._favourites];
  }

  // to override comparison when new artist is created
  bool contains(Artist artist) {
    bool contains = false;
    if (_favourites.isNotEmpty) {
      _favourites.forEach((favArtist) {
        if (favArtist.id == artist.id) {
          contains = true;
        }
      });
    }
    return contains;
  }

  // add to favs if it not there yet
  // remove if is there
  void addOrRemove(Artist artist) async {
    this.contains(artist)
        ? FirebaseFunctions.deleteFav(artist)
        : FirebaseFunctions.addFav(artist);
    // notifyListeners();
  }

  /// rerenders every time collection gets changed \
  /// favourites list gets filled with database
  void listenToFavourites() {
    collectionRef.orderBy("name").snapshots()
        // do this on every change
        .listen(
      (snapshot) {
        _favourites = [];
        snapshot.docs.forEach((doc) => _favourites.add(doc.data()));
    notifyListeners();
      },
    );
  }
}
