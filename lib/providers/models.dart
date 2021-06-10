class ChatMessage {
  final String timetoken;
  final String channel;
  final String uuid;
  final Map message;

  ChatMessage(
      {required this.timetoken,
      required this.channel,
      required this.uuid,
      required this.message});

  factory ChatMessage.fromJson(Map json) => ChatMessage(
      timetoken: json['timetoken'],
      channel: json['channel'],
      uuid: json['uuid'],
      message: json['message']);
}

class Space {
  final String name;
  final Map? custom;
  final String? description;
  final String id;

  Space({required this.name, required this.id, this.description, this.custom});

  factory Space.fromJson(Map json) => Space(
      name: json['name'],
      id: json['id'],
      description: json['description'],
      custom: json['custom']);
}

class UserProfile {
  final String? name;
  final String uuid;
  final String? profileUrl;
  final Map? custom;

  UserProfile({required this.uuid, this.profileUrl, this.name, this.custom});

  factory UserProfile.fromJson(Map json) => UserProfile(
      uuid: json['id'],
      name: json['name'],
      profileUrl: json['profileUrl'],
      custom: json['custom']);
}

class Signal {
  final String message;
  final String sender;

  Signal({required this.message, required this.sender});
}
