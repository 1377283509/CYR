import 'package:cyr/utils/navigator/custom_navigator.dart';
import 'package:flutter/material.dart';

class NavigateTile extends StatelessWidget {
  final Icon icon;
  final String title;
  final Widget page;
  final bool showTrailing;
  NavigateTile({this.title, this.icon,this.page, this.showTrailing=true});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title, style: TextStyle(
        fontSize: 15
      ),),
      onTap: (){
        if(page!=null){
          navigateTo(context, page);
        }
      },
      trailing: Icon(Icons.keyboard_arrow_right, color: showTrailing?Colors.grey:Colors.transparent,),
    );
  }
}
