import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hci_a2_app/components/album_panel.dart';
import 'package:hci_a2_app/components/artist_card.dart';
import 'package:hci_a2_app/provider/album.dart';
import 'package:hci_a2_app/provider/artist.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    // retrieve searched artist from search_field
    final artistProvider = Provider.of<ArtistProvider>(context);

    return Expanded(
      child: Column(
        children: [
          // show Artist if an artist is searched
          // otherwise show nothing
          artistProvider.artist == null
              ? SizedBox.shrink()
              : ArtistCard(),
          // show Albums if an Artist is searched
          // otherwise show nothing
          artistProvider.artist == null
              ? SizedBox.shrink()
              : FutureBuilder(
                  future: _retrieveAlbums(artistProvider.artist.id),
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      List<Album> albums = snapshot.data;
                      if(snapshot.data == null) return SizedBox.shrink();
                      else return Expanded(
                        child: SingleChildScrollView(child: AlbumPanel(albums: albums, index: 1),),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
        ],
      ),
    );
  }

  // create List of all albums from artist with id
  Future<List<Album>> _retrieveAlbums(String id) async {
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
  dynamic _retrieveJsonResponse(String id) async {
    final url =
        Uri.parse("https://theaudiodb.com/api/v1/json/1/album.php?i=$id");
    var response = await http.get(url);
    return jsonDecode(response.body);
  }
}


