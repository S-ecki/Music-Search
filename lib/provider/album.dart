import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Album {
  final String _name;
  final String _photo;
  final String _releaseYear;
  final String _gerne;
  final String _description;
  bool isExpanded = false;

  Album(
      {@required name,
      @required photo,
      @required releaseYear,
      @required genre,
      @required description})
      : this._name = name,
        this._photo = photo,
        this._releaseYear = releaseYear,
        this._gerne = genre,
        this._description = description;


  factory Album.fromJson(Map<String, dynamic> json, int index) {
    return Album(
      name: json["album"][index]["strAlbum"],
      photo: json["album"][index]["strAlbumThumb"],
      releaseYear: json["album"][index]["intYearReleased"],
      genre: json["album"][index]["strGenre"],
      description: json["album"][index]["strDescriptionEN"],
    );
  }

  // for type safety on firebase
  Album.fromJsonFirebase(Map<String, Object> json)
      : this(
          name: json["name"] as String,
          photo: json["photo"] as String,
          releaseYear: json["releaseYear"] as String,
          genre: json["genre"] as String,
          description: json["description"] as String,
        );

  // for type safety on firebase
  Map<String, Object> toJsonFirebase() {
    return {
      "name": name,
      "photo": photo,
      "releaseYear": releaseYear,
      "genre": genre,
      "description": description,
    };
  }

  String get name {
    return _name;
  }

  String get photo {
    return _photo;
  }

  String get releaseYear {
    return _releaseYear;
  }

  String get genre {
    return _gerne;
  }

  String get description {
    return _description;
  }

  // create List of all albums from artist with id
  static Future<List<Album>> retrieveAlbums(String id) async {
    dynamic response = await _retrieveJsonResponse(id);

    // add all albums from json to List
    List<Album> albums = [];
    for (var i = 0; i < response["album"].length; ++i) {
      albums.add(Album.fromJson(response, i));
    }
    return albums;
  }

  // search for albums of artist with id
  // return decoded json body
  static dynamic _retrieveJsonResponse(String id) async {
    final url =
        Uri.parse("https://theaudiodb.com/api/v1/json/1/album.php?i=$id");
    var response = await get(url);
    return jsonDecode(response.body);
  }
}
