//搜索框
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

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
          // cursorColor: Colors.lightBlue,
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
            // fillColor: Colors.blueGrey[100], // 输入框填充颜色
            fillColor: Colors.white, // 输入框填充颜色
            filled: true, // 是否填充输入框
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            // 输入框内边距
            // suffixIcon:
            suffixIcon: IconButton(icon: Icon(Icons.sentiment_very_satisfied),
              onPressed: () {
                // 当用户按下Enter键时执行的操作
                // print('User submitted: $value');
                _response=_sendRequest().toString();
              },
            ), // 后缀图标
          ),
          style: TextStyle(
            color: Colors.black, // 输入文本颜色
            fontSize: 18.0, // 输入文本字体大小
          ),
        ),
        Text('$_response'), // 显示 API 返回的响应
      ],
    );
  }
}