import 'package:skinca/core/models/doctor_model.dart';

class ChatResponse {
  final bool status;
  final Chat chat;

  ChatResponse({required this.status, required this.chat});

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      status: json['status'],
      chat: Chat.fromJson(json['chat']),
    );
  }
}

class Chat {
  final int id;
  final List<DoctorModel> users;

  Chat({required this.id, required this.users});

  factory Chat.fromJson(Map<String, dynamic> json) {
    var usersList = json['users'] as List;
    List<DoctorModel> users = usersList.map((i) => DoctorModel.fromJson(i)).toList();

    return Chat(
      id: json['id'],
      users: users,
    );
  }
}


