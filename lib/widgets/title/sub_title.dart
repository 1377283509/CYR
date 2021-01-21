import 'package:flutter/material.dart';

class SubTitle extends StatelessWidget {
  final String title;
  final Function moreCallback;
  final bool showMore;
  final String moreText;

  SubTitle({this.title,this.moreCallback,this.showMore=true, this.moreText="更多"});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.centerLeft,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  border:
                  Border(left: BorderSide(color: Colors.indigo, width: 6))),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
            ),
            TextButton(
              child: Text(
                showMore?moreText:"",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: moreCallback,
            )
          ],
        ));
  }
}
