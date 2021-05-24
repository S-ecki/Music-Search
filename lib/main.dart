import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hci_a2_app/music_provider_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebase,
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return Text("uups");
        } else if (snapshot.hasData) {
          return MusicProviderApp();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
