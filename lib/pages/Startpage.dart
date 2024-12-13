
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Startpage extends StatelessWidget{
  const Startpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('DESKTOP',textAlign: TextAlign.center,),
      ),

      drawer: Drawer(
          child: Column(
            children: [

              //drawer的元素的填充
              DrawerHeader(child: Icon(
                  Icons.ac_unit)
              ),
              ListTile(
                  leading: Icon(Icons.account_balance_sharp),
                  title: Text("Startpage"),
                  onTap: (){
                    //点击函数
                    Navigator.pushNamed(context, '/Startpage');
                    // Navigator.pop(context);
                    print("点击");
                  }
              ),
              ListTile(
                  leading: Icon(Icons.account_tree_outlined),
                  title: Text("Resource"),
                  onTap: (){
                    //点击函数
                    Navigator.pushNamed(context, '/tabview/Resourcepage');
                    // Navigator.of(context).pop();
                    print("点击");
                  }
              ),
              ListTile(
                  leading: Icon(
                    PhosphorIcons.gear(PhosphorIconsStyle.fill),
                    size: 32.0,
                  ),
                  title: Text("Setting"),
                  onTap: (){
                    Navigator.pushNamed(context, '/tabview/Settingpage');
                    // Navigator.pop(context);
                    print("点击");
                  }
              )
            ],
          )
      ),
      body: Stack(
        //左右两个侧栏
        children:[
          Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //部件的缩放的选项
                    //根据屏幕的大小进行缩放
                    MediaQuery(
                      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Image.asset('assets/picture/back.jpg'),
                      ),
                    ),
                    const Text(
                      'Shot Moon AI',
                      style: TextStyle(
                        fontFamily: 'MyCustomFont', // 指定字体
                        fontSize: 80, // 字体大小
                        fontWeight: FontWeight.bold, // 字体粗细
                        color: Colors.blue, // 字体颜色
                        letterSpacing: 2, // 字间距
                        decoration: TextDecoration.underline, // 文本装饰，比如下划线
                        decorationColor: Colors.red, // 装饰颜色
                        decorationStyle: TextDecorationStyle.dashed, // 装饰风格，比如虚线
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 80.0,
                        minHeight: 80.0,
                        maxWidth: 800.0,
                        maxHeight: 200.0,
                      ),
                      child: CustomTextFieldWidget(),
                    ),
                  ],
                ),
              )
          ),


          //左侧栏
          Positioned(
            left: 20,//靠左
            top: 10,
            bottom: 0,
            child: Container(
              // height: ,在这里进行高度的调整
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  // color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text('AI',textAlign: TextAlign.center),
                        onTap: () {
                          print('Item 1 tapped');
                        },
                      ),
                      ListTile(
                        title: Text('书桌',textAlign: TextAlign.center),
                        onTap: () {
                          print('Item 2 tapped');
                        },
                      ),
                      // Add more items as needed
                    ],
                  ),
                )
            ),
          ),

          //右侧栏，后面可以加上一些别的东西
          /*Positioned(
              right: 10,
              top: 10,
              bottom: 0,
              child: Container(
                width: 80,
                // color: Colors.red,
                child: ListView(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.home),
                      onPressed: () {
                    // 处理点击事件
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.business),
                      onPressed: () {
                    // 处理点击事件
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.school),
                      onPressed: () {
                    // 处理点击事件
                      },
                    ),
                  ],
                ),
              ),
            ),*/
        ],
      ),
    );
  }

}



//搜索框
class CustomTextFieldWidget extends StatefulWidget {
  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  final _controller = TextEditingController();
  String _response="";
  final FocusNode _focusNode = FocusNode();


  Future<void> _sendRequest() async {
    String input = _controller.text;
    if (input.isEmpty) return;

    //构建请求
    Uri url = Uri.parse('http://localhost:5000/api');
    Map<String, String> queryParams = {'message': input};
    String queryString = Uri(queryParameters: queryParams).query;
    Uri requestUrl = Uri.parse('$url?$queryString');

    //发出请求
    try {
      final response = await http.get(requestUrl);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        setState(() {
          _response = responseBody['message'] ?? 'No response';
        });
      } else {
        setState(() {
          _response = 'Failed to fetch data';
        });
      }
    } catch (e) {
      setState(() {
        _response = 'Request failed: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onSubmitted: (String value) {
            // 当用户按下Enter键时执行的操作
            print('User submitted: $value');
            _response=_sendRequest().toString();
          },
          focusNode: _focusNode,
          controller: _controller, // 控制器，用于管理输入框内容
          decoration: InputDecoration(
            labelText: '开始你的问题...', // 标签文本
            hintText: '写点什么...', // 提示文本
            border: OutlineInputBorder( // 边框样式
              borderRadius: BorderRadius.circular(10.0), // 圆角边框
              borderSide: const BorderSide(
                color: Colors.blue, // 边框颜色
                width: 2.0, // 边框宽度
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueAccent, // 聚焦时边框颜色
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey, // 启用时边框颜色
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red, // 错误时边框颜色
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.redAccent, // 聚焦错误时边框颜色
              ),
            ),
            fillColor: Colors.blueGrey[100], // 输入框填充颜色
            filled: true, // 是否填充输入框
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ), // 输入框内边距
            suffixIcon: Icon(Icons.sentiment_very_satisfied), // 后缀图标
          ),
          style: TextStyle(
            color: Colors.blue, // 输入文本颜色
            fontSize: 18.0, // 输入文本字体大小
          ),
        ),
        Text('Response:$_response'), // 显示 API 返回的响应
      ],
    );
  }
}