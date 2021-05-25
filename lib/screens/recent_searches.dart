import 'package:flutter/material.dart';
import 'package:hci_a2_app/components/searched_artist_list.dart';

class RecentSearchesScreen extends StatelessWidget {
  static const routeName = '/recent';

  @override
  Widget build(BuildContext context) {
    // final artistProvider = Provider.of<ArtistProvider>(context, listen: false);
    // final favourites = Provider.of<FavouriteArtistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Searches'),
      ),
      // builds a scrollable list with dividers
      // every tile is a artist + a button to remove from favourites
      body: SearchedArtistList()
      
    );
  }
}
