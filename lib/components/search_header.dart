import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All Searched Artists",
              style: Theme.of(context).accentTextTheme.bodyText1,
            ),
            IconButton(icon: Icon(Icons.save_outlined), onPressed: () {},),
          ],
        ),
      ),
    );
  }
}
