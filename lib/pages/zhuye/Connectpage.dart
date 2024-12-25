import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';




/**
 * 1.调整页面的结构，搜索框沿用之前的那个
 * 2.调整聊天的逻辑
 * 3.完成和ai的交互
 * 4.初步使用数据库进行数据的存放
 * 5.完善ai的能力
 * */


class Connectpage extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<Connectpage> {
  final List<Message> _messages = [];
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.insert(0, Message(text: text, isSender: true));//判断消息是谁发出的
        _textController.clear();
        _isComposing = false;
      });
    }
  }

  void _handleChanged(String text) {
    setState(() {
      _isComposing = text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) {
                Message message = _messages[index];
                return MessageBubble(message: message);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      onChanged: _handleChanged,
                      onSubmitted: _handleSubmitted,
                      decoration: InputDecoration(
                        hintText: 'Send a message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (_isComposing)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      //留下来用于上传图片
                      child: IconButton(
                        icon: Icon(Icons.photo_camera),
                        onPressed: () {},
                      ),
                    ),

                  SizedBox(
                    width: 48.0,
                    child: Tooltip(
                      message: "点击",
                      preferBelow: false, // 不优先在下方显示
                      child: IconButton(
                        icon: Icon(
                          PhosphorIcons.mouseSimple(PhosphorIconsStyle.regular),
                          size: 32.0,
                        ),
                        onPressed: () => _handleSubmitted(_textController.text),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
    final bool isSender = message.isSender;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!isSender) ...[
            Text(
              'Sender Name',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            SizedBox(height: 4.0),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              if (!isSender) ...[
                Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                  margin: EdgeInsetsDirectional.only(start: isSender ? 16.0 : 64.0),
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ] else ...[
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                    margin: EdgeInsetsDirectional.only(end: 64.0),
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
              if (isSender) ...[
                SizedBox(width: 64.0),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
