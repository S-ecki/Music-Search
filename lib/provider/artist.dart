import 'package:flutter/foundation.dart';

// holds info for single Artist to display
class Artist {
  final String _id;
  final String _name;
  final String _formed;
  final String _genre;

  Artist({
    @required id,
    @required name,
    @required formed,
    @required genre,
  })  : this._id = id,
        this._name = name,
        this._formed = formed,
        this._genre = genre;

  // for conventient parsing
  factory Artist.fromJsonAPI(Map<String, dynamic> json) {
    return Artist(
      id: json['artists'][0]['idArtist'],
      name: json['artists'][0]['strArtist'],
      formed: json['artists'][0]['intFormedYear'],
      genre: json['artists'][0]['strGenre'],
    );
  }

  // for type safety on firebase
  Artist.fromJsonFirebase(Map<String, Object> json)
      : this(
          id: json["id"] as String,
          name: json["name"] as String,
          formed: json["formed"] as String,
          genre: json["genre"] as String,
        );

  // for type safety on firebase
  Map<String, Object> toJsonFirebase() {
    return {
      "id": id,
      "name": name,
      "formed": formed,
      "genre": genre,
    };
  }

  String get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String get formed {
    return _formed;
  }

  String get genre {
    return _genre;
  }
}

// to provide the artist that is being searched
class ArtistProvider with ChangeNotifier {
  Artist _searched;
  bool isSet = false;

  void set(Artist searched) {
    isSet = true;
    _searched = searched;
    notifyListeners();
  }

  Artist get artist {
    return _searched;
  }
}

// to keep track of favourites
class FavouriteArtistProvider with ChangeNotifier {
  List<Artist> _favourites = [];

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

  void _remove(Artist artist) {
    _favourites.removeWhere((favArtist) {
      return favArtist.id == artist.id;
    });
  }

  // add to favs if it not there yet
  // remove if is there
  void addOrRemove(Artist artist) {
    this.contains(artist) ? this._remove(artist) : _favourites.add(artist);
    notifyListeners();
  }
}
