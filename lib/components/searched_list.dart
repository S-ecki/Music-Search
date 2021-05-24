import 'package:flutter/material.dart';
import 'package:hci_a2_app/components/search_header.dart';
import 'package:hci_a2_app/components/searched_artist_list.dart';

class SearchedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Column(
          children: [
            SearchHeader(),
            SearchedArtistList(),
          ],
        ),
      ),
    );
  }
}
