import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hci_a2_app/provider/artist.dart';

void saveSearchedArtist(Artist artist) {
  final collectionRef =
      FirebaseFirestore.instance.collection("SearchedArtists").withConverter(
            // dont have to use json not
            fromFirestore: (snapshot, _) => Artist.fromJsonAPI(snapshot.data()),
            toFirestore: (providedArtist, _) => providedArtist.toJsonFirebase(),
          );

  collectionRef
      // directly pass artist because of converter
      .add(artist)
      .then((value) => print("success"))
      .catchError((error) => print("fail"));
}
