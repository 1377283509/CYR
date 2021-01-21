import 'package:cyr/pages/page_list.dart';
import 'package:cyr/providers/provider_list.dart';
import 'package:cyr/providers/utils/utils_provider.dart';
import 'package:cyr/utils/navigator/custom_navigator.dart';
import 'package:cyr/utils/toast/toast.dart';
import 'package:cyr/widgets/buttons/normal_button.dart';
import 'package:cyr/widgets/form/text_input.dart';
import 'package:cyr/widgets/upload/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedBackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("功能反馈",style: Theme.of(context).textTheme.headline1,),
          ),
          body: FeedBackBody()),
    );
  }
}

class FeedBackBody extends StatefulWidget {
  @override
  _FeedBackBodyState createState() => _FeedBackBodyState();
}

class _FeedBackBodyState extends State<FeedBackBody> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _builtTitle("反馈内容"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: InputTextArea(
              controller: _textEditingController,
              label: "反馈内容",
              placeHolder: "有什么想反馈的呢",
            ),
          ),
          _builtTitle("相关截图"),
          UpLoadImageCard(),
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Consumer<FilesProvider>(
              builder: (_, utilsProvider, __) {
                return CustomButton(
                  loading: _loading,
                    onTap: () async {
                    setState(() {
                      _loading = true;
                    });
                      List<String> images = utilsProvider.getFileIdList();
                      String content = _textEditingController.text;
                      bool res = await utilsProvider.feedBack(content, images);
                      if (!res) {
                        showToast("发布失败", context);
                      } else {
                        navigateReplacement(
                            context,
                            ResultPage(
                              content: "反馈成功",
                              state: true,
                            ));
                        utilsProvider.clearImageList();
                      }
                      setState(() {
                        _loading = false;
                      });
                    },
                    title: "提交");
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _builtTitle(String title) {
    return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.indigo.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.only(left: 12, top: 4, bottom: 4),
        margin: const EdgeInsets.only(left: 12, top: 16, bottom: 12, right: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.clear_all,
              color: Colors.white,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ));
  }
}
