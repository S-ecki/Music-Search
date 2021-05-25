import 'package:flutter/material.dart';
import 'package:hci_a2_app/provider/favourite.dart';
import 'package:provider/provider.dart';
import '../provider/artist.dart';

class ArtistCard extends StatefulWidget {
  @override
  _ArtistCardState createState() => _ArtistCardState();
}

class _ArtistCardState extends State<ArtistCard> {
  @override
  Widget build(BuildContext context) {
    final artistProvider = Provider.of<ArtistProvider>(context);
    final favouriteProvider = Provider.of<FavouriteArtistProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
                style: Theme.of(context).accentTextTheme.bodyText1,
                text: "Albums from: ",
                children: [
                  TextSpan(
                      text: "${artistProvider.artist.name}",
                      style: TextStyle(color: Theme.of(context).primaryColor))
                ]),
          ),
          IconButton(
            icon: favouriteProvider.contains(artistProvider.artist)
                ? Icon(Icons.favorite, color: Theme.of(context).primaryColor)
                : Icon(Icons.favorite_border),
            onPressed: () {
              favouriteProvider.addOrRemove(artistProvider.artist);
            },
          ),
        ],
      ),
    );
  }
}
