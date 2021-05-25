import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hci_a2_app/firestore/functions.dart';
import 'package:hci_a2_app/provider/artist.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
        child: Row(
          children: [
            Expanded(
              child: Material(
                elevation: 4,
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  cursorColor: Colors.grey[700],
                  controller: _controller,
                  validator: _requiredValidator,
                  decoration: InputDecoration(
                    hintText: "Enter Artist or Band",
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.music_note,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                  ),
                ),
              ),
            ),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () => _searchArtist(context)),
          ],
        ),
      ),
    );
  }

  // sets searched artist to be provided to search_results
  void _searchArtist(BuildContext ctx) async {
    final artistProvider = Provider.of<ArtistProvider>(context, listen: false);
    // only search if field is filled out
    if (_formKey.currentState.validate()) {
      // if there is no such artist, http.get has thrown an exception
      // so we can assume artist is not null
      Artist artist = await _retrieveArtist();
      // update the provider with the searched artist
      artistProvider.set(artist);

      FirebaseFunctions.saveSearchedArtist(artist);
    }
  }


  // searches artist and parses json to Artist object
  Future<Artist> _retrieveArtist() async {
    try {
      // ask API for artist in text field
      final url = Uri.parse(
          "https://www.theaudiodb.com/api/v1/json/1/search.php?s=${_controller.text}");
      final response = await http.get(url);
      // create Artist object from retrieved json
      Artist artist = Artist.fromJsonAPI(jsonDecode(response.body));
      return artist;
    } on NoSuchMethodError catch (_) {
      // show error if no results were found
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("There is no Artist/Band with this name."),
      ));
    }
  }

  // custom validator to ensure field is filled out
  String _requiredValidator(String entry) {
    FocusScope.of(context).unfocus();
    if (entry == null || entry.isEmpty)
      return 'This field is required';
    else
      return null;
  }
}
