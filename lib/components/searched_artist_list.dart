import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hci_a2_app/provider/artist.dart';

class SearchedArtistList extends StatelessWidget {
  final _artistStream = FirebaseFirestore.instance
      .collection("SearchedArtists")
      .orderBy("name")
      .snapshots()
      .distinct();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: StreamBuilder(
          stream: _artistStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(":(");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            final List<Widget> result = snapshot.data.docs.map<Widget>((doc) {
              return ListTile(
                title: Text(doc["name"]),
              );
            }).toList();

            return ListView.separated(
              itemCount: result.length,
              itemBuilder: (_, i) => result[i],
              separatorBuilder: (_, __) => Divider(),
            );
          },
        ),
      ),
    );
  }
}

// class UserInformation extends StatefulWidget {
//   @override
//   _UsetInfomation createState() => _UserInfomationState();
// }

// class _UserInformationState extends State<UserInformation> {
//   final Stream<QuerySnapshot> _usersStream =
//       FirebaseFirestore.instance.collection('users').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _usersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text("Loading");
//         }

//         return new ListView(
//           children: snapshot.data.docs.map((DocumentSnapshot document) {
//             return new ListTile(
//               title: new Text(document.data()['full_name']),
//               subtitle: new Text(document.data()['company']),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }
