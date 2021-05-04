import 'package:flutter/foundation.dart';
import 'package:pubnub/pubnub.dart';

import 'app_data.dart';
import 'models.dart';
import 'pubnub_instance.dart';

export 'models.dart';

class MessageProvider with ChangeNotifier {
  final PubNub pubnub;
  final Subscription subscription;
  List<ChatMessage> _messages;

  List<ChatMessage> get messages =>
      ([..._messages]..sort((m1, m2) => m2.timetoken.compareTo(m1.timetoken)))
          .toList();

  MessageProvider._(this.pubnub, this.subscription) {
    _messages = [...AppData.conversations];

    subscription.messages.listen((m) {
      if (m.messageType == MessageType.normal) {
        _addMessage(ChatMessage(
            timetoken: m.originalMessage['p']['t'],
            channel: m.channel,
            uuid: m.uuid.value,
            message: m.content));
      }
    });
  }
  MessageProvider(PubNubInstance pn) : this._(pn.instance, pn.subscription);

  getMessagesById(String spaceId) =>
      messages.where((message) => message.channel == spaceId).toList();

  _addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }

  sendMessage(String channel, String message) async {
    await pubnub.publish(channel, {'text': '$message'});
  }

  sendSignal(String signal, String channel) async {
    await pubnub.signal(channel, signal);
  }

  @override
  void dispose() async {
    this.subscription.cancel();
    await this.pubnub.announceLeave(channelGroups: {AppData.CHANNELGROUP});
    super.dispose();
  }
}
