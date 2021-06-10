import 'package:flutter/foundation.dart';
import 'package:pubnub/pubnub.dart';

import './models.dart';
import 'pubnub_instance.dart';

export './models.dart';

class SignalProvider with ChangeNotifier {
  final Subscription subscription;
  Map<String, Signal> signals = <String, Signal>{};

  SignalProvider._(this.subscription) {
    subscription.messages.listen((envelope) {
      if (envelope.messageType == MessageType.signal) {
        signals[envelope.channel] =
            Signal(message: envelope.content, sender: envelope.uuid.value);
        notifyListeners();
      }
    });
  }
  SignalProvider(PubNubInstance pn) : this._(pn.subscription);
}
