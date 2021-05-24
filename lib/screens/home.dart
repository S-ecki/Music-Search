import 'package:flutter/material.dart';
import 'package:hci_a2_app/components/footer.dart';
import 'package:hci_a2_app/components/search_field.dart';
import 'package:hci_a2_app/components/search_result.dart';
import 'package:hci_a2_app/components/searched_list.dart';
import 'package:hci_a2_app/screens/favourites.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // prevent Footer coming up with keyboard
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Home',
            style: Theme.of(context).accentTextTheme.headline1,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                Navigator.of(context).pushNamed(FavouritesScreen.routeName);
              },
            )
          ],
        ),
        body: Column(
          children: [
            // takes as much space as it needs
            SearchField(),
            // takes as much space as is left
            SearchResult(),
            // 
            SearchedList(),
            // takes as much space as it needs
            Footer(),
          ],
        ));
  }
}
