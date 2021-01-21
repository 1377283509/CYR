import 'dart:io';
import 'package:cyr/pages/page_list.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/util_list.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpLoadImageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width/4.5;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: MediaQuery.of(context).size.width,
      child: Consumer<FilesProvider>(
        builder: (_, provider, __) {
          List<Widget> children = provider.doneList
              .map((e) => InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ImagePage(e.file);
                  });
            },
            onLongPress: () async {
              bool res = await showConfirmDialog(context, "确定要删除吗?");
              if (res) {
                await provider.deleteFile(e, context);
              }
            },
            child: Container(
                width: width,
                height: width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 2),
                    image: DecorationImage(
                        image: FileImage(e.file), fit: BoxFit.cover)),
                child: e.process == 1
                    ? Container(
                  width: double.infinity,
                  color: Colors.black38,
                  child: const Text(
                    "上传成功",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                )
                    : CircularProgressIndicator(
                  value: e.process,
                  backgroundColor: Colors.redAccent,
                )),
          ))
              .toList();
          children.add(InkWell(
            onTap: (){
              _upLoad(context);
            },
            child: Container(
              width: width,
              height: width,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(
                Icons.add,
                color: Colors.black54,
                size: 42,
              ),
            ),
          ));
          return Wrap(
            runAlignment:WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            runSpacing: 8,
            spacing: 6,
            children: children,
          );
        },
      ),
    );
  }

  _upLoad(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).pop([0]);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("相机拍摄"),
                trailing: const Icon(Icons.keyboard_arrow_right),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pop([1]);
                },
                leading: const Icon(Icons.collections),
                title: const Text("相册选择"),
                trailing: const Icon(Icons.keyboard_arrow_right),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    title: "取消"),
              ),
              SizedBox(height: 12,),
            ],
          );
        }).then((value) async {
      if (value == null) {
        return;
      }
      FilesProvider provider =
      Provider.of<FilesProvider>(context, listen: false);
      File file = await pickImage(value[0] == 0);
      await provider.upLoadFile(file);
    });
  }
}
