import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:pubnub/networking.dart';
import 'package:pubnub/pubnub.dart';
import 'app_data.dart';

class PubNubInstance {
  late PubNub _pubnub;
  late Subscription _subscription;

  PubNub get instance => _pubnub;

  Subscription get subscription => _subscription;

  static Timer? _heartbeatTimer;

  PubNubInstance() {
    _pubnub = PubNub(
        networking: NetworkingModule(retryPolicy: RetryPolicy.exponential()),
        defaultKeyset: Keyset(
            subscribeKey: dotenv.env['PUBNUB_SUBSCRIBE_KEY']!,
            publishKey: dotenv.env['PUBNUB_PUBLISH_KEY'],
            uuid: UUID(AppData.currentUser!.uuid)));
    _pubnub.channelGroups
        .addChannels(AppData.CHANNELGROUP, AppData.CHANNELS)
        .then((result) {});

    _subscription = _pubnub
        .subscribe(channelGroups: {AppData.CHANNELGROUP}, withPresence: true);
    _subscription.resume();

    startHeartbeats();
  }

  startHeartbeats() {
    if (_heartbeatTimer == null)
      _heartbeatTimer = Timer.periodic(Duration(seconds: 60), _heartbeatCall);
  }

  dispose() async {
    stopHeartbeats();
    await _pubnub.announceLeave(channelGroups: {AppData.CHANNELGROUP});
    if (!_subscription.isCancelled) await _subscription.cancel();
  }

  stopHeartbeats() {
    if (_heartbeatTimer != null && _heartbeatTimer!.isActive) {
      _heartbeatTimer!.cancel();
      _heartbeatTimer = null;
    }
  }

  Future<void> _heartbeatCall(Timer timer) async =>
      await _pubnub.announceHeartbeat(channelGroups: {AppData.CHANNELGROUP});

  void announceLeave() async =>
      await _pubnub.announceLeave(channelGroups: {AppData.CHANNELGROUP});

  void resume() => _subscription.resume();
}
