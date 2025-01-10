// import 'package:flutter/material.dart';
// import 'package:phosphor_flutter/phosphor_flutter.dart';
//
//
//
//
// /**
//  * 1.调整页面的结构，搜索框沿用之前的那个
//  * 2.调整聊天的逻辑
//  * 3.完成和ai的交互
//  * 4.初步使用数据库进行数据的存放
//  * 5.完善ai的能力
//  * */
//
//
// class Connectpage extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<Connectpage> {
//   final List<Message> _messages = [];
//   final TextEditingController _textController = TextEditingController();
//   bool _isComposing = false;
//
//   void _handleSubmitted(String text) {
//     if (text.isNotEmpty) {
//       setState(() {
//         _messages.insert(0, Message(text: text, isSender: true));//判断消息是谁发出的
//         _textController.clear();
//         _isComposing = false;
//       });
//     }
//   }
//
//   void _handleChanged(String text) {
//     setState(() {
//       _isComposing = text.isNotEmpty;
//     });
//   }
//
//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//         children: <Widget>[
//           Flexible(
//             child: ListView.builder(
//               padding: EdgeInsets.all(8.0),
//               reverse: true,
//               itemCount: _messages.length,
//               itemBuilder: (_, int index) {
//                 Message message = _messages[index];
//                 return MessageBubble(message: message);
//               },
//             ),
//           ),
//           Container(
//             decoration: BoxDecoration(color: Colors.white),
//             child: Padding(
//               padding: EdgeInsets.all(4.0),
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: TextField(
//                       controller: _textController,
//                       onChanged: _handleChanged,
//                       onSubmitted: _handleSubmitted,
//                       decoration: InputDecoration(
//                         hintText: 'Send a message',
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   if (_isComposing)
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 4.0),
//                       //留下来用于上传图片
//                       child: IconButton(
//                         icon: Icon(Icons.photo_camera),
//                         onPressed: () {},
//                       ),
//                     ),
//
//                   SizedBox(
//                     width: 48.0,
//                     child: Tooltip(
//                       message: "点击",
//                       preferBelow: false, // 不优先在下方显示
//                       child: IconButton(
//                         icon: Icon(
//                           PhosphorIcons.mouseSimple(PhosphorIconsStyle.regular),
//                           size: 32.0,
//                         ),
//                         onPressed: () => _handleSubmitted(_textController.text),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//     );
//   }
// }
//
// class Message {
//   final String text;
//   final bool isSender;
//   Message({required this.text, required this.isSender});
// }
//
// class MessageBubble extends StatelessWidget {
//   final Message message;
//
//   MessageBubble({required this.message});
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isSender = message.isSender;
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           if (!isSender) ...[
//             Text(
//               'Sender Name',
//               style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//             ),
//             SizedBox(height: 4.0),
//           ],
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: <Widget>[
//               if (!isSender) ...[
//                 Container(
//                   constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
//                   margin: EdgeInsetsDirectional.only(start: isSender ? 16.0 : 64.0),
//                   padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     message.text,
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ] else ...[
//                 Flexible(
//                   child: Container(
//                     constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
//                     margin: EdgeInsetsDirectional.only(end: 64.0),
//                     padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                     decoration: BoxDecoration(
//                       color: Colors.pinkAccent.shade100,
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Text(
//                       message.text,
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 ),
//               ],
//               if (isSender) ...[
//                 SizedBox(width: 64.0),
//               ],
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }



//**********************************************************************************************************************//**********************************************************************************************************************
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:phosphor_flutter/phosphor_flutter.dart';
//
// class Connectpage extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<Connectpage> {
//   final List<Message> _messages = [];
//   final TextEditingController _textController = TextEditingController();
//   bool _isComposing = false;
//   String _response = "";
//
//   Future<void> _sendRequest() async {
//     String input = _textController.text;
//     if (input.isEmpty) return;
//
//     Uri url = Uri.parse('http://localhost:5000/api');
//     Map<String, String> queryParams = {'message': input};
//     String queryString = Uri(queryParameters: queryParams).query;
//     Uri requestUrl = Uri.parse('$url?$queryString');
//
//     try {
//       final response = await http.get(requestUrl);
//       if (response.statusCode == 200) {
//         var responseBody = jsonDecode(response.body);
//         setState(() {
//           _response = responseBody['data'] ?? 'No response';
//           // Add the response to the chat messages
//           _messages.add(Message(text: _response, isSender: false));
//         });
//       } else {
//         setState(() {
//           _response = 'Failed to fetch data';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _response = 'Request failed: $e';
//       });
//     }
//     _textController.clear; // Clear the text field after sending the request
//   }
//
//   void _handleSubmitted(String text) {
//     if (text.isNotEmpty) {
//       setState(() {
//         _messages.insert(0, Message(text: text, isSender: true)); // Add user message
//         _textController.clear;
//         _isComposing = false;
//         _sendRequest(); // Send the request to the API
//       });
//     }
//   }
//
//   void _handleChanged(String text) {
//     setState(() {
//       _isComposing = text.isNotEmpty;
//     });
//   }
//
//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Flexible(
//           child: ListView.builder(
//             padding: EdgeInsets.all(8.0),
//             reverse: true,
//             itemCount: _messages.length,
//             itemBuilder: (_, int index) {
//               Message message = _messages[index];
//               return MessageBubble(message: message);
//             },
//           ),
//         ),
//         Container(
//           decoration: BoxDecoration(color: Colors.white),
//           child: Padding(
//             padding: EdgeInsets.all(4.0),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     onChanged: _handleChanged,
//                     onSubmitted: _handleSubmitted,
//                     decoration: InputDecoration(
//                       hintText: 'Send a message',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 if (_isComposing)
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 4.0),
//                     child: IconButton(
//                       icon: Icon(Icons.photo_camera),
//                       onPressed: () {},
//                     ),
//                   ),
//
//                 SizedBox(
//                   width: 48.0,
//                   child: Tooltip(
//                     message: "Send",
//                     preferBelow: false,
//                     child: IconButton(
//                       icon: Icon(PhosphorIcons.mouseSimple(PhosphorIconsStyle.regular),
//                         size: 32.0,),
//                       onPressed: () => _handleSubmitted(_textController.text),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class Message {
//   final String text;
//   final bool isSender;
//   Message({required this.text, required this.isSender});
// }
//
// class MessageBubble extends StatelessWidget {
//   final Message message;
//
//   MessageBubble({required this.message});
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isSender = message.isSender;
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           if (!isSender)
//             Text(
//               'AI Assistant',
//               style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//             ),
//           SizedBox(height: 4.0),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: <Widget>[
//               if (!isSender)
//                 Container(
//                   constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
//                   margin: EdgeInsetsDirectional.only(start: isSender ? 16.0 : 64.0),
//                   padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     message.text,
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//               if (isSender)
//                 Flexible(
//                   child: Container(
//                     constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
//                     margin: EdgeInsetsDirectional.only(end: 64.0),
//                     padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                     decoration: BoxDecoration(
//                       color: Colors.pinkAccent.shade100,
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Text(
//                       message.text,
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:phosphor_flutter/phosphor_flutter.dart';
//
// class Connectpage extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<Connectpage> {
//   final List<Message> _messages = [];
//   final TextEditingController _textController = TextEditingController();
//   bool _isComposing = false;
//   String _response = "";
//
//   Future<void> _sendRequest() async {
//     String input = _textController.text;
//     if (input.isEmpty) return;
//
//     Uri url = Uri.parse('http://localhost:5000/api');
//     Map<String, String> queryParams = {'message': input};
//     String queryString = Uri(queryParameters: queryParams).query;
//     Uri requestUrl = Uri.parse('$url?$queryString');
//
//     try {
//       final response = await http.get(requestUrl);
//       if (response.statusCode == 200) {
//         var responseBody = jsonDecode(response.body);
//         setState(() {
//           _response = responseBody['data'] ?? 'No response';
//           // Add the response to the chat messages
//           _messages.add(Message(text: _response, isSender: false));
//         });
//       } else {
//         setState(() {
//           _response = 'Failed to fetch data';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _response = 'Request failed: $e';
//       });
//     }
//   }
//
//   void _handleSubmitted(String text) {
//     if (text.isNotEmpty) {
//       setState(() {
//         _messages.add(Message(text: text, isSender: true)); // Add user message
//         _textController.clear;
//         _isComposing = false;
//         _sendRequest(); // Send the request to the API
//       });
//     }
//   }
//
//   void _handleChanged(String text) {
//     setState(() {
//       _isComposing = text.isNotEmpty;
//     });
//   }
//
//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Flexible(
//           child: ListView.builder(
//             padding: EdgeInsets.all(8.0),
//             reverse: false, // Set to false to display messages from top to bottom
//             itemCount: _messages.length,
//             itemBuilder: (_, int index) {
//               Message message = _messages[index];
//               return MessageBubble(message: message);
//             },
//           ),
//         ),
//         Container(
//           decoration: BoxDecoration(color: Colors.white),
//           child: Padding(
//             padding: EdgeInsets.all(4.0),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     onChanged: _handleChanged,
//                     onSubmitted: _handleSubmitted,
//                     decoration: InputDecoration(
//                       hintText: 'Send a message',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 if (_isComposing)
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: 4.0),
//                     child: IconButton(
//                       icon: Icon(Icons.photo_camera),
//                       onPressed: () {},
//                     ),
//                   ),
//                 SizedBox(
//                   width: 48.0,
//                   child: Tooltip(
//                     message: "Send",
//                     preferBelow: false,
//                     child: IconButton(
//                       icon: Icon(PhosphorIcons.mouseSimple(PhosphorIconsStyle.regular),
//                           size: 32.0,),
//                       onPressed: () => _handleSubmitted(_textController.text),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class Message {
//   final String text;
//   final bool isSender;
//   Message({required this.text, required this.isSender});
// }
//
// class MessageBubble extends StatelessWidget {
//   final Message message;
//
//   MessageBubble({required this.message});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: <Widget>[
//           if (!message.isSender) ...[
//             Container(
//               constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
//               margin: EdgeInsetsDirectional.only(start: 64.0),
//               padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: Text(
//                 message.text,
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//           ] else ...[
//             Flexible(
//               child: Container(
//                 constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
//                 margin: EdgeInsetsDirectional.only(end: 64.0),
//                 padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                 decoration: BoxDecoration(
//                   color: Colors.pinkAccent.shade100,
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Text(
//                   message.text,
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;

class Connectpage extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<Connectpage> {
  final List<Message> _messages = [];
  final TextEditingController _textController = TextEditingController();

  Future<void> _sendRequest(String input) async {
    if (input.isEmpty) return;

    Uri url = Uri.parse('http://localhost:5000/api');
    Map<String, String> queryParams = {'message': input};
    String queryString = Uri(queryParameters: queryParams).query;
    Uri requestUrl = Uri.parse('$url?$queryString');

    try {
      final response = await http.get(requestUrl);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        setState(() {
          _messages.add(Message(text: responseBody['data'] ?? 'No response', isSender: false));
        });
      } else {
        setState(() {
          _messages.add(Message(text: 'Failed to fetch data', isSender: false));
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(Message(text: 'Request failed: $e', isSender: false));
      });
    }
  }

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(Message(text: text, isSender: true));
      });
      _sendRequest(text);
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connecting...')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (_, int index) {
                return MessageBubble(message: _messages[index]);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isSender;
  Message({required this.text, required this.isSender});
}

class MessageBubble extends StatelessWidget {
  final Message message;

  MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Align(
        // alignment: message.isSender ? Alignment._end : Alignment._start,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: message.isSender ? Colors.blue : Colors.pinkAccent.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child:
          // SingleChildScrollView(
          //   child: Markdown(
          //     data: message.text,
          //     styleSheet: MarkdownStyleSheet(
          //       // Define styles for different Markdown elements
          //       h1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //       h2: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //       p: TextStyle(fontSize: 16),
          //       code: TextStyle(fontSize: 14, backgroundColor: Colors.grey[200]),
          //       // Add other styles as needed
          //     ),
          //   ),
          // )
          Text(
            message.text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}