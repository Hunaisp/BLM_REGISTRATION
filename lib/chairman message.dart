import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textEditingController = TextEditingController();
  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(    backgroundColor: Color(0xFF54B435),
        centerTitle: true,
        title: Text('Chat with Chairman'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0.r),
                bottomRight: Radius.circular(20.0.r),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: AssetImage('assets/b7.jpg'),
                  // Replace 'assets/chairman_image.jpg' with your chairman's image path
                ),
                SizedBox(width: 16.0.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to the chat!',
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.0.h),
                      Text(
                        'How can I assist you?',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return _messages[index];
              },
            ),
          ),
          // Input field for sending messages
          Container(
            margin: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_textEditingController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String messageText) {
    if (messageText.isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            isMe: true,
            message: messageText,
          ),
        );
        _textEditingController.clear();
      });
    }
  }
}

class ChatMessage extends StatelessWidget {
  final bool isMe;
  final String message;

  const ChatMessage({
    Key? key,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 8.0.w),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isMe ? Color(0xFF54B435) : Colors.grey[300],
          borderRadius: BorderRadius.circular(20.0.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe)
              CircleAvatar(
                radius: 15.r,
                backgroundImage: AssetImage('assets/chairman_image.jpg'),
                // Replace 'assets/chairman_image.jpg' with your chairman's image path
              ),
            Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}