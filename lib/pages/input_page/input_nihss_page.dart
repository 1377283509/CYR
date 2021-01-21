import 'dart:async';
import 'package:cyr/utils/time_format/time_format.dart';
import 'package:cyr/widgets/divider/custom_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NIHSScoreItem {
  final String title;
  final List<int> scores;

  NIHSScoreItem(this.title, this.scores);
}

List<NIHSScoreItem> nihssData = [
  NIHSScoreItem("1a 意识", [0, 1, 2, 3]),
  NIHSScoreItem("1b 提问", [0, 1, 2]),
  NIHSScoreItem("1c 指令", [0, 1, 2]),
  NIHSScoreItem("2 凝视", [0, 1, 2]),
  NIHSScoreItem("3 视野", [0, 1, 2, 3]),
  NIHSScoreItem("4 面瘫", [0, 1, 2, 3]),
  NIHSScoreItem("5a 左上", [0, 1, 2, 3, 4, 9]),
  NIHSScoreItem("5b 右上", [0, 1, 2, 3, 4, 9]),
  NIHSScoreItem("6a 左下", [0, 1, 2, 3, 4, 9]),
  NIHSScoreItem("6b 右下", [0, 1, 2, 3, 4, 9]),
  NIHSScoreItem("7 共济", [0, 1, 2, 9]),
  NIHSScoreItem("8 感觉", [0, 1, 2]),
  NIHSScoreItem("9 失语", [0, 1, 2, 3]),
  NIHSScoreItem("10 构音", [0, 1, 2, 9]),
  NIHSScoreItem("11 忽视", [0, 1, 2]),
];

class InputNIHSSPage extends StatefulWidget {
  final DateTime startTime;
  InputNIHSSPage(this.startTime);

  @override
  _InputNIHSSPageState createState() => _InputNIHSSPageState();
}

class _InputNIHSSPageState extends State<InputNIHSSPage> {
  int totalScore = 0;

  StreamController<List<int>> _controller;

  @override
  void initState() {
    super.initState();
    _controller = StreamController();
    _controller.stream.listen((event) {
      totalScore += (event[1] - event[0]);
      setState(() {
      });
    });
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
        title: Text("NIHSS评分"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("开始时间"),
              trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    formatTime(widget.startTime),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: nihssData.length,
                separatorBuilder: (BuildContext context, int index){
                  return CustomDivider();
                },
                itemBuilder: (BuildContext context, int index) {
                  return SingleScoreTile(
                      title: nihssData[index].title,
                      scores: nihssData[index].scores,
                      scoreController: _controller);
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 80,
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  height: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(12),
                          right: Radius.circular(12)),
                      color: Theme.of(context).primaryColor),
                  child: Text(
                    "总评分:   $totalScore 分",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              Expanded(
                flex: 3,
                child: Container(
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(12),
                            left: Radius.circular(12)),
                        color: Colors.green),
                    child: TextButton(
                      child: Text(
                        "提交",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.pop(context, [totalScore]);
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 单行的分数选择
class SingleScoreTile extends StatefulWidget {
  final String title;
  final List<int> scores;
  final StreamController<List<int>> scoreController;

  SingleScoreTile(
      {@required this.title,
      @required this.scores,
      @required this.scoreController});

  @override
  _SingleScoreTileState createState() => _SingleScoreTileState();
}

class _SingleScoreTileState extends State<SingleScoreTile> {
  int curValue;

  @override
  void initState() {
    super.initState();
    curValue = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: widget.scores
                    .map((e) => InkWell(
                        onTap: () {
                          widget.scoreController.add([curValue, e]);
                          setState(() {
                            curValue = e;
                          });
                        },
                        child: RoundRadio(value: e, groupValue: curValue)))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 单个圆圈
class RoundRadio extends StatelessWidget {
  final int groupValue;
  final int value;

  RoundRadio({@required this.value, @required this.groupValue});

  @override
  Widget build(BuildContext context) {
    bool isSelected = value == groupValue;
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
          color: isSelected ? Colors.indigo : Colors.indigo.withOpacity(0.1),
          borderRadius: BorderRadius.circular(50)),
      child: Text(
        "$value",
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
