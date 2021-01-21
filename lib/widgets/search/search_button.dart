import 'package:cyr/pages/page_list.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final bool needBack;
  SearchButton({this.needBack=false});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search, color: Colors.white,),
      onPressed: (){
        showSearch(context: context, delegate: SearchPatientsPage(needBack: needBack));
      },
    );
  }
}
