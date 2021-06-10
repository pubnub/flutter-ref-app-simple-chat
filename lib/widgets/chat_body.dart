import 'package:flutter/material.dart';

import '../providers/models.dart';
import 'message_list.dart';
import 'new_message.dart';

class ChatBody extends StatelessWidget {
  final Space space;
  ChatBody(this.space);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blueGrey[50]),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: MessageList(space.id),
                ),
                NewMessageWidget(space.id),
              ], // Column children
            ),
          ),
        ], // Stack child
      ),
    );
  }
}
