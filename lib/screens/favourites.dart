import 'package:flutter/material.dart';
import 'package:hci_a2_app/provider/artist.dart';
import 'package:hci_a2_app/screens/home.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatelessWidget {
  static const routeName = '/favourites';

  @override
  Widget build(BuildContext context) {
    final artistProvider = Provider.of<ArtistProvider>(context, listen: false);
    final favourites = Provider.of<FavouriteArtistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      // builds a scrollable list with dividers
      // every tile is a artist + a button to remove from favourites
      body: ListView.separated(
        separatorBuilder: (_, __) => Divider(),
        itemCount: favourites.list.length,
        itemBuilder: (_, index) {
          return InkWell(
            // go back to homescreen
            onTap: () {
              artistProvider.set(favourites.list[index]);
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            },
            child: ListTile(
              title: Text(favourites.list[index].name),
              trailing: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Theme.of(context).primaryColor,
                ),
                // remove from favourites
                onPressed: () {
                  favourites.addOrRemove(favourites.list[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
