import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("示例3：随机单词(包管理)")),
        body: Center(child: RandomWordsWidget()));
  }
}

class RandomWordsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RandomWordsState();
}

class RandomWordsState extends State {
  var _wordPair = WordPair.random().toString();

  void refreshWords() {
    _wordPair = WordPair.random().toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_wordPair),
        ElevatedButton(onPressed: refreshWords, child: Text("刷新"))
      ], //使用逗号结尾，能使自动化格式更好看
    );
  }
}
