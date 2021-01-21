import 'package:flutter/material.dart';

class SingleTile extends StatelessWidget {
  final String title;
  final String buttonLabel;
  final String value;
  final Function onTap;

  SingleTile(
      {this.title, this.buttonLabel = "输入", this.value, this.onTap, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      alignment: Alignment.center,
      constraints: BoxConstraints(minHeight: 54),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2)))),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
              flex: 7,
              child: Align(
                alignment: Alignment.centerRight,
                child: value == null
                    ? RaisedButton(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          buttonLabel,
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if(onTap!=null){
                            await onTap();
                          }
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
              )),
        ],
      ),
    );
  }
}
