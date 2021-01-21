import 'dart:async';

import 'package:cyr/config/assets/images.dart';
import 'package:flutter/material.dart';

class AspectItemModel {
  String value;
  bool selected;
  AspectItemModel(this.value, this.selected);
}

class InputAspectPage extends StatefulWidget {
  @override
  _InputAspectPageState createState() => _InputAspectPageState();
}

class _InputAspectPageState extends State<InputAspectPage> {
  StreamController<AspectItemModel> _controller;
  // 除去四项的分数
  int score;
  // 不除去四项的分数
  int totalScore;
  final List<String> exceptList = ["A", "P", "Po", "Cb"];
  String result;

  @override
  void initState() {
    score = 0;
    totalScore = 0;
    _controller = StreamController.broadcast();
    result = "点击对应按钮进行评分";
    _controller.stream.listen((event) {
      if (event.selected) {
        // 如果不在除去的列表，score + 1
        if (!exceptList.contains(event.value)) {
          score += 1;
        }
        totalScore += 1;
      } else {
        // 如果取消选择，减分
        // 如果不在除去的列表，score -1
        if (!exceptList.contains(event.value)) {
          score -= 1;
        }
        totalScore -= 1;
      }
      if (score > 7) {
        result = "病人三个月后很有希望独立生活";
      } else if (score == 0) {
        result = "弥漫性缺血累及整个大脑中动脉";
      } else {
        result = "病人不能独立生活或死亡的可能性大";
      }
      // 更新下状态
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aspect评分"),
        actions: [
          TextButton(
            child: Text("提交", style: TextStyle(
              color: Colors.white
            ),),
            onPressed: (){
              Navigator.of(context).pop<List<String>>([totalScore.toString(), score.toString(), result]);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 第一行分数
              _buildScoreTile("评分总分", "$totalScore 分"),

              // 第二行分数
              _buildScoreTile("去除 ${exceptList.toString()} 得分", "$score 分"),

              // 结果
              _buildScoreTile(result),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AspectItemCard(
                imagePath: AssetImages.aspect_01,
                items: ["M1", "M2", "M3", "I", "L", "C", "IC", "P"],
                controller: _controller,
              ),
              AspectItemCard(
                imagePath: AssetImages.aspect_02,
                items: ["A", "M4", "M5", "M6"],
                controller: _controller,
              ),
              AspectItemCard(
                imagePath: AssetImages.aspect_03,
                items: ["Po", "Cb"],
                controller: _controller,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreTile(String title, [String value]) {
    return Container(
      color: Colors.indigo,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            value ?? "",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class AspectItemCard extends StatelessWidget {
  final List<String> items;

  final String imagePath;

  final StreamController controller;

  AspectItemCard(
      {@required this.items,
      @required this.imagePath,
      @required this.controller,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              child: AspectImage(imagePath),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: items
                    .map((e) => ChoiceItem(
                          e,
                          controller,
                          key: ValueKey(e),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChoiceItem extends StatefulWidget {
  final String value;
  ChoiceItem(this.value, this.controller, {Key key}) : super(key: key);
  final StreamController controller;
  @override
  _ChoiceItemState createState() => _ChoiceItemState();
}

class _ChoiceItemState extends State<ChoiceItem> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(widget.value),
      selected: selected,
      onSelected: (value) {
        setState(() {
          selected = value;
        });
        widget.controller.add(AspectItemModel(widget.value, selected));
      },
    );
  }
}

class AspectImage extends StatelessWidget {
  final String assetImagePath;
  AspectImage(this.assetImagePath);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Image.asset(
        assetImagePath,
        fit: BoxFit.contain,
      ),
    );
  }
}
