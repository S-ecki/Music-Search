import 'package:flutter/material.dart';
import 'package:hci_a2_app/provider/album.dart';
import '../provider/artist.dart';

class AlbumPanel extends StatefulWidget {
  const AlbumPanel({
    @required this.albums,
    @required this.index,
  });

  final List<Album> albums;
  final int index;

  @override
  _AlbumPanelState createState() => _AlbumPanelState();
}

class _AlbumPanelState extends State<AlbumPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ExpansionPanelList(
          expandedHeaderPadding: EdgeInsets.all(0),
      // expand on tap of chevron and refresh state
      expansionCallback: (index, isExpanded) {
        setState(
          () {
            widget.albums[index].isExpanded = !isExpanded;
          },
        );
      },
      // make ExpansionPanelList from album list
      children: widget.albums.map<ExpansionPanel>((item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          // header: always seen
          headerBuilder: (ctx, _) {
            return ListTile(title: Text(item.name ?? ""), leading: Icon(Icons.album));
          },
          // seen when Panel is expanded
          body: ExpansionPanelBody(item),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    ));
  }
}

class ExpansionPanelBody extends StatelessWidget {
  final Album album;
  ExpansionPanelBody(this.album);
  static const bodyHeight = 380.00;

  @override
  Widget build(BuildContext context) {
    // stack Image and Container with text over each other
    return Stack(
      children: [
        Image.network(
          // if no album photo is provided, show generic "not found" picture
          album.photo ??
              "https://www.thermaxglobal.com/wp-content/uploads/2020/05/image-not-found.jpg",
          height: bodyHeight,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Container(
          // same size as Image
          height: bodyHeight,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.topLeft,
          // "background" color
          color: Colors.black54,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionPanelBodyText(album: album),
          ),
        ),
      ],
    );
  }
}

class ExpansionPanelBodyText extends StatelessWidget {
  const ExpansionPanelBodyText({@required this.album,});

  final Album album;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 0,
          // "genre" is bold while content is normal
          // same for all 3 properties
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
                text: "Genre: ",
                style: Theme.of(context).accentTextTheme.headline2,
                children: [
                  TextSpan(
                    // genre is never null, but ""
                    text: album.genre.isEmpty
                        ? "not available"
                        : "${album.genre}",
                    style: Theme.of(context).accentTextTheme.bodyText2,
                  )
                ]),
          ),
        ),
        SizedBox(height: 10),
        Flexible(
          flex: 0,
          child: RichText(
            text: TextSpan(
                text: "Release Year: ",
                style: Theme.of(context).accentTextTheme.headline2,
                children: [
                  TextSpan(
                    // may be null
                    text: album.releaseYear ?? "not available",

                    style: Theme.of(context).accentTextTheme.bodyText2,
                  )
                ]),
          ),
        ),
        SizedBox(height: 10),
        Flexible(
          // description can be too long - make that part scrollable
          child: SingleChildScrollView(
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                  text: "Description: ",
                  style: Theme.of(context).accentTextTheme.headline2,
                  children: [
                    TextSpan(
                      // may be null
                      text: album.description ?? "not available",
                      style: Theme.of(context).accentTextTheme.bodyText2,
                    )
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
