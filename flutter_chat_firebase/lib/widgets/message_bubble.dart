import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String createdAt;
  final String userImage;
  final bool belongsToMe;
  final String userName;
  final Key key;

  const MessageBubble(
      {this.message,
      this.belongsToMe,
      this.key,
      this.userName,
      this.userImage,
      this.createdAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              belongsToMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: belongsToMe
                      ? Colors.grey[300]
                      : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: belongsToMe
                          ? Radius.circular(12)
                          : Radius.circular(0),
                      bottomRight: belongsToMe
                          ? Radius.circular(0)
                          : Radius.circular(12))),
              width: 140,
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                  crossAxisAlignment: belongsToMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: belongsToMe
                              ? Colors.black
                              : Theme.of(context)
                                  .accentTextTheme
                                  .headline1
                                  .color),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                          color: belongsToMe
                              ? Colors.black
                              : Theme.of(context)
                                  .accentTextTheme
                                  .headline1
                                  .color),
                      textAlign: belongsToMe ? TextAlign.end : TextAlign.start,
                    ),
                  ]),
            )
          ],
        ),
        Positioned(
            top: 0,
            left: belongsToMe ? null : 128,
            right: belongsToMe ? 128 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            )),
        // Positioned(
        //   bottom: 15,
        //   left: belongsToMe ? null : 90,
        //   right: belongsToMe ? 90 : null,
        //   child: Text(createdAt ?? "2020",
        //       style: TextStyle(
        //           fontSize: 10,
        //           fontStyle: FontStyle.italic,
        //           color: belongsToMe
        //               ? Colors.black
        //               : Theme.of(context).accentTextTheme.headline1.color)),
        // )
      ],
    );
  }
}
