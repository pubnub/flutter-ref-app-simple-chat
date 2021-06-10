import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

import 'models.dart';

export 'models.dart';

class AppData {
  static const CHANNELGROUP = 'chat_room_8c5fc1d2-acef-11eb-8529-0242ac130003';
  static const CHANNELS = const {
    'space_bc03548bcb11eb8dcd0242c1303',
    'space_5f3547a18f448e567e84ba097db',
    'space_937989646abaa2bf3ed12dbd0a3',
    'space_515fc9a2a1b043c3847a29f29f3b3c2a',
    'space_efc5b3ef96ea4bffbde733e249c8cbb3'
  };
  static const INDICATORTIMEOUT = 10;
  static List<UserProfile>? _users;
  static UserProfile? _currentUser;
  static List<Space>? _spaces;
  static List<Space>? _directChats;
  static List<ChatMessage>? _conversations;
  static UserProfile? get currentUser => _currentUser;
  static Space? get defaultSpace => _spaces!.first;
  static List<Space>? get spaces => _spaces;
  static List<Space>? get directChats => _directChats;
  static List<Space>? get allSpaces => [..._spaces!, ..._directChats!];
  static List<UserProfile>? get users => [..._users!];
  static List<ChatMessage>? get conversations => _conversations;

  static init() async {
    const String DIRECTORY = 'assets/setup';
    final String usersJson =
        await rootBundle.loadString('$DIRECTORY/users.json');
    final String groupsJson =
        await rootBundle.loadString('$DIRECTORY/groups.json');
    final String directChatsJson =
        await rootBundle.loadString('$DIRECTORY/direct_chats.json');
    final String conversatonsJson =
        await rootBundle.loadString('$DIRECTORY/messages.json');

    final profiles = await json.decode(usersJson) as List;
    final directs = await json.decode(directChatsJson) as List;

    final chatGroups = await json.decode(groupsJson) as List;
    final chatMessages = await json.decode(conversatonsJson) as List;
    _users = profiles.map((profile) => UserProfile.fromJson(profile)).toList();
    _spaces = chatGroups.map((space) => Space.fromJson(space)).toList();

    _directChats = directs.map((space) => Space.fromJson(space)).toList();

    _currentUser = _users![Random().nextInt(_users!.length - 4)];

    _conversations = chatMessages
        .map((conversation) => ChatMessage.fromJson(conversation))
        .toList();
  }

  static UserProfile getUserById(String uuid) {
    if (uuid == 'current_user') {
      return currentUser!;
    }
    return users!.firstWhere((user) => (user.uuid == uuid));
  }

  static Space getSpaceById(String? id) {
    if (id == null) {
      return defaultSpace!;
    }
    return allSpaces!.firstWhere((space) => space.id == id);
  }
}
