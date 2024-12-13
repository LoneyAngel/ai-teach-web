import 'package:http/http.dart' as http;
import 'dart:convert';




//获取到python的后端返回的信息
Future<String> getHello() async {
  final response = await http.get(Uri.parse('http://localhost:5000/hello'));
  if (response.statusCode == 200) {
    // 如果服务器返回200 OK，则打印响应体
    print(jsonDecode(response.body));
    return jsonDecode(response.body)['message'];
  } else {
    // 如果服务器返回错误
    print('Request failed with status: ${response.statusCode}.');
    return "";
  }
}

Future<void> sendData() async {
  final response = await http.post(
    Uri.parse('http://localhost:5000/api_get'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'key': 'value',
    }),
  );
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));//正确解析的结果
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

void main() {
  getHello();
  sendData();
}


