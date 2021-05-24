import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hci_a2_app/provider/artist.dart';

void saveSearchedArtist(Artist artist) {
  final collectionRef =
      FirebaseFirestore.instance.collection("SearchedArtists");

  collectionRef
      .add({
        "id": artist.id,
        "name": artist.name,
        "formed": artist.formed,
        "genre": artist.genre,
      })
      .then((value) => print("success"))
      .catchError((error) => print("fail"));
}
