import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget trailing;

  const CustomListTile({this.leading, this.title, this.trailing, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leading ?? Container(),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: title ?? Container(),
          )),
          SizedBox(
            width: 16,
          ),
          trailing ?? Container(),
        ],
      ),
    );
  }
}
