import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hci_a2_app/provider/artist.dart';

class FirebaseFunctions {
  // used for all functions
  static final searchedCollectionRef =
      FirebaseFirestore.instance.collection("SearchedArtists").withConverter(
            // dont have to use json not
            fromFirestore: (snapshot, _) => Artist.fromJsonFirebase(snapshot.data()),
            toFirestore: (providedArtist, _) => providedArtist.toJsonFirebase(),
          );

  // used for all functions
  static final favCollectionRef =
      FirebaseFirestore.instance.collection("FavouriteArtists").withConverter(
            // dont have to use json not
            fromFirestore: (snapshot, _) => Artist.fromJsonFirebase(snapshot.data()),
            toFirestore: (providedArtist, _) => providedArtist.toJsonFirebase(),
          );

  static void saveSearchedArtist(Artist artist) {
    searchedCollectionRef
        // sets doc id to artist id
        // this way searched artists are distinct
        .doc("${artist.id}")
        // directly pass artist because of converter
        .set(artist)
        .then((value) => print("success"))
        .catchError((error) => print("fail"));
    searchedCollectionRef.doc("${artist.id}").update({"time": Timestamp.now()});
  }

  static void addFav(Artist artist) async {
    await favCollectionRef.doc(artist.id).set(artist);
  }

  static void deleteFav(Artist artist) async {
    await favCollectionRef.doc("${artist.id}").delete();
  }
}
