import 'package:flutter/material.dart';

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
}