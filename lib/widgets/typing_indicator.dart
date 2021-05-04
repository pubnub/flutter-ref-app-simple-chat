import 'dart:async';

import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  final String message;

  TypingIndicator(this.message);
  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TypingIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.message.isNotEmpty) _visible = true;
    Timer(Duration(seconds: 10), _hideMessage);
  }

  _hideMessage() {
    if (mounted)
      setState(() {
        if (widget.message.isNotEmpty) _visible = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return _visible
        ? Text(widget.message,
            style:
                Theme.of(context).textTheme.caption.apply(color: Colors.grey))
        : Container();
  }
}
