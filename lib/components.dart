import 'package:flutter/material.dart';


class RoundedButton extends StatelessWidget {
  RoundedButton({required this.title,required this.color, required this.onPressed});
  final String title;
  final Color color;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class BubbleMessage extends StatelessWidget {
  BubbleMessage({required this.message, required this.sender, required this.isMe});
  final String message;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isMe ? '' : sender,
            style: const TextStyle(
              color: Colors.black54,
            ),
          ),
          Material(
              elevation: 10.0,
              borderRadius: BorderRadius.only(
                  topLeft: isMe ? Radius.circular(30.0) : Radius.circular(0),
                  topRight: isMe ? Radius.circular(0) : Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)),
              color: isMe ? Colors.lightBlueAccent : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black54,
                    fontSize: 15.0,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}