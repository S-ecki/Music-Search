import 'package:flutter/material.dart';
import 'package:hci_a2_app/provider/artist.dart';
import 'package:hci_a2_app/provider/favourite.dart';
import 'package:hci_a2_app/screens/album_filters.dart';
import 'package:hci_a2_app/screens/favourites.dart';
import 'package:hci_a2_app/screens/home.dart';
import 'package:hci_a2_app/screens/recent_searches.dart';
import 'package:hci_a2_app/theme/theme.dart';
import 'package:provider/provider.dart';

class MusicProviderApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ArtistProvider()),
        ChangeNotifierProvider(create: (_) => FavouriteArtistProvider()),
      ],
      builder: (_, __) => MaterialApp(
        title: 'Musicians App',
        // hide debug label
        debugShowCheckedModeBanner: false,
        // custom theme
        theme: theme(),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          FavouritesScreen.routeName: (ctx) => FavouritesScreen(),
          RecentSearchesScreen.routeName: (ctx) => RecentSearchesScreen(),
          AlbumFilters.routeName: (ctx) => AlbumFilters(),
        },
      ),
    );
  }
}