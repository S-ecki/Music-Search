import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hci_a2_app/provider/album.dart';
import 'package:hci_a2_app/provider/artist.dart';

class FirebaseFunctions {
  // used for all functions
  static final _searchedCollectionRef =
      FirebaseFirestore.instance.collection("SearchedArtists").withConverter(
            // dont have to use json not
            fromFirestore: (snapshot, _) =>
                Artist.fromJsonFirebase(snapshot.data()),
            toFirestore: (providedArtist, _) => providedArtist.toJsonFirebase(),
          );

  // used for all functions
  static final _favCollectionRef =
      FirebaseFirestore.instance.collection("FavouriteArtists").withConverter(
            // dont have to use json not
            fromFirestore: (snapshot, _) =>
                Artist.fromJsonFirebase(snapshot.data()),
            toFirestore: (providedArtist, _) => providedArtist.toJsonFirebase(),
          );

  static void saveSearchedArtist(Artist artist) {
    // save id of created document to add timestamp later
    final _docRef = _searchedCollectionRef.doc();
    // directly pass artist because of converter
    _docRef
        .set(artist)
        .then((value) => print("success"))
        .catchError((error) => print("fail"));
    // add timestamp field for ordering - with saved doc if
    _docRef.update({"time": Timestamp.now()});
  }

  static void addFav(Artist artist) async {
    // create a doc with artist
    _favCollectionRef.doc(artist.id).set(artist);
    // retrieve all albums of artist from API
    final List<Album> albums = await Album.retrieveAlbums(artist.id);
    // create reference to subcollection of artist with albums
    final albumsCollectionRef = FirebaseFirestore.instance
        .collection("FavouriteArtists")
        .doc(artist.id)
        .collection("Albums")
        .withConverter(
            fromFirestore: (snapshot, _) =>
                Album.fromJsonFirebase(snapshot.data()),
            toFirestore: (album, _) => album.toJsonFirebase());

    albums.forEach((album) {
      albumsCollectionRef.doc().set(album);
    });
  }

  static void deleteFav(Artist artist) async {
    await _favCollectionRef.doc(artist.id).delete();
  }

  static Future<List<Album>> getAlbumsByRelease(String releaseYear) async {
    // list of albums with release year
    List<Album> returnList = [];

    // access all albums (from every artist)
    final groupColRef = FirebaseFirestore.instance
        .collectionGroup("Albums")
        .withConverter(
            fromFirestore: (snapshot, _) =>
                Album.fromJsonFirebase(snapshot.data()),
            toFirestore: (album, _) => album.toJsonFirebase());

    // query and save data to return list
    await groupColRef
        .where("releaseYear", isEqualTo: releaseYear)
        .orderBy("name")
        .get()
        .then((snapshot) {
      print(snapshot.size);
      snapshot.docs.forEach((albumSnapshot) {
        returnList.add(albumSnapshot.data());
      });
    });
    print(returnList.length);
    return returnList;
  }
}
