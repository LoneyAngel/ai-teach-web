import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/Search_box.dart';

class Searchpage extends StatelessWidget{
  //一些展示的文本

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //部件的缩放的选项
          //根据屏幕的大小进行缩放
          MediaQuery(
            data: MediaQuery.of(context as BuildContext).copyWith(textScaler: TextScaler.linear(1.0)),
            child: Container(
              width: MediaQuery.of(context as BuildContext).size.width * 0.3,
              height: MediaQuery.of(context as BuildContext).size.height * 0.3,
              child: Image.asset('picture/back.jpg'),
            ),
          ),
          //一些文字和提示类的东西
          const Text(
            '''\nNice to meet you
                ''',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'MyCustomFont', // 指定字体
              fontSize: 20, // 字体大小
              fontWeight: FontWeight.bold, // 字体粗细
              color: Colors.blue, // 字体颜色
              letterSpacing: 2, // 字间距
              // decoration: TextDecoration.underline, // 文本装饰，比如下划线
              // decorationColor: Colors.red, // 装饰颜色
              decorationStyle: TextDecorationStyle.dashed, // 装饰风格，比如虚线
            ),
          ),
          const Text(
            '''在这里我们将帮助你更好的进行知识的探索，\n
                  输入高数试试......
                ''',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'MyCustomFont', // 指定字体
              fontSize: 15, // 字体大小
              fontWeight: FontWeight.w100, // 字体粗细
              color: Colors.blue, // 字体颜色
              letterSpacing: 2, // 字间距
              // decoration: TextDecoration.underline, // 文本装饰，比如下划线
              // decorationColor: Colors.red, // 装饰颜色
              decorationStyle: TextDecorationStyle.dashed, // 装饰风格，比如虚线
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 80.0,
                minHeight: 80.0,
                maxWidth: 800.0,
                maxHeight: 200.0,
              ),
              child: CustomTextFieldWidget(),
            ),
          ),
        ],
      ),
    );
  }

}