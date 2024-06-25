import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skinca/core/components/app_back_button.dart';
import 'package:skinca/core/models/doctor_model.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = '/chat';

  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorModel doctor =
        ModalRoute.of(context)!.settings.arguments as DoctorModel;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dr. ${doctor.firstName} ${doctor.lastName}'),
        leading: const AppBackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ChatMessage(
              sender: 'Dr. ${doctor.firstName} ${doctor.lastName}',
              text: 'Hello, How can I help you?',
              time: 'just now',
              isDoctor: true,
              doctor: doctor,
            ),
            const Spacer(),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type message ...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () {
                    // Handle camera button
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          FloatingActionButton(
            onPressed: () {
              // Handle send button
            },
            backgroundColor: Colors.teal,
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String sender;
  final String text;
  final String time;
  final bool isDoctor;
  final String? imageUrl;
  final DoctorModel doctor;

  const ChatMessage({
    super.key,
    required this.sender,
    required this.text,
    required this.time,
    required this.isDoctor,
    this.imageUrl,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDoctor)
            CircleAvatar(
              backgroundImage: doctor.profilePicture.isNotEmpty
                  ? Image.memory(const Base64Decoder().convert(
                      doctor.profilePicture.split(',').last,
                    )).image
                  : const AssetImage('assets/images/avatar.png'),
              radius: 20.0,
            ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isDoctor ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: isDoctor
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    if (isDoctor)
                      Text(
                        sender,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                if (text.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isDoctor ? Colors.grey[200] : Colors.teal[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(text),
                  ),
                if (imageUrl != null)
                  Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    child: Image.asset(imageUrl!),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
