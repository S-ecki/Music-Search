import 'package:flutter/material.dart';
import 'package:hci_a2_app/provider/album.dart';
import '../firestore/functions.dart';

class AlbumFilters extends StatelessWidget {
  static const routeName = '/filters';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Some Firebase Queries'),
        ),
        body: FutureBuilder(
            future: getGroupQueryListTiles(),
            builder: (_, AsyncSnapshot<List<Widget>> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    Text(
                        "Group Query of all albums for a specific Release Year"),
                    ...snapshot.data,
                    Divider(
                      thickness: 2,
                    ),
                  ],
                );
              } else
                return CircularProgressIndicator();
            }),
      ),
    );
  }
}

Future<List<Widget>> getGroupQueryListTiles() async {
  final List<Album> albums = await FirebaseFunctions.getAlbumsByRelease("1999");

  return albums
      .map((album) => ListTile(
            title: Text(album.name),
            subtitle: Text(album.releaseYear),
          ))
      .toList();
}
