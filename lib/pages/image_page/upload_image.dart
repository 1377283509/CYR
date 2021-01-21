import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:cyr/widgets/upload/upload_image.dart';
import 'package:cyr/widgets/widget_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片上传"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UpLoadImageCard(),
              SizedBox(
                height: 72,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Consumer<FilesProvider>(
                  builder: (_, provider, __) {
                    return CustomButton(
                        onTap: () {
                          if(provider.process!=1){
                            showToast("图片未上传完成", context);
                            return;
                          }
                          List<String> images = provider.getFileIdList();
                          Navigator.of(context).pop([...images]);
                        },
                        title: "保存");
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text("请等待上传完成再保存", style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
