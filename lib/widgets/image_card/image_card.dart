import 'package:cyr/pages/page_list.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageCard extends StatelessWidget {
  final String fileId;
  ImageCard(this.fileId);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 3.6;
    FilesProvider provider = Provider.of<FilesProvider>(context);
    return FutureBuilder(
      future: provider.downLoadImage(fileId, context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return InkWell(
            onTap: () {
              navigateTo(context, ImagePage(snapshot.data));
            },
            child: Container(
              width: width,
              height: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                      image: FileImage(snapshot.data), fit: BoxFit.cover)),
            ),
          );
        } else {
          return Container(
            width: width,
            height: width,
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.2),
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}