import 'package:flutter/foundation.dart';
import 'app_data.dart';
import 'pubnub_instance.dart';

import 'package:pubnub/pubnub.dart';

class PresenceProvider with ChangeNotifier {
  final PubNub pubnub;
  final Subscription chatSubscription;
  Set<String> _onlineUsers = {};

  Set<String> get onlineUsers => {..._onlineUsers};

  int get occupancy {
    return onlineUsers.length;
  }

  PresenceProvider._(this.pubnub, this.chatSubscription) {
    _updateOnlineUsers();
    chatSubscription.presence.listen((presenceEvent) {
      switch (presenceEvent.action) {
        case PresenceAction.join:
          _addOnlineUser(presenceEvent.uuid!.value);
          break;
        case PresenceAction.leave:
        case PresenceAction.timeout:
          _removeOnlineUser(presenceEvent.uuid!.value);
          break;
        case PresenceAction.stateChange:
          break;
        case PresenceAction.interval:
          if (presenceEvent.join.length > 0) {
            _onlineUsers.addAll(presenceEvent.join.map((uuid) => uuid.value));
          }
          if (presenceEvent.join.length > 0) {
            _onlineUsers.removeAll(presenceEvent.leave
                .where((id) => id.value != AppData.currentUser!.uuid)
                .map((uuid) => uuid.value));
          }
          notifyListeners();
          break;
        default:
          break;
      }
    });
  }
  PresenceProvider(PubNubInstance pn) : this._(pn.instance, pn.subscription);

  void _updateOnlineUsers() async {
    var result = await pubnub.hereNow(channelGroups: {AppData.CHANNELGROUP});
    _onlineUsers.addAll(result.channels.values
        .expand((c) => c.uuids.values)
        .map((occupantInfo) => occupantInfo.uuid));
  }

  void _addOnlineUser(String uuid) {
    _onlineUsers.add(uuid);
    notifyListeners();
  }

  void _removeOnlineUser(String uuid) {
    if (uuid != AppData.currentUser!.uuid) {
      _onlineUsers.remove((uuid));
      notifyListeners();
    }
  }
}
