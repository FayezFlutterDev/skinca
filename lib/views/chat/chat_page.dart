import 'package:flutter/material.dart';
import 'package:skinca/core/components/app_back_button.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = '/chat';
  final List<ChatMessage> messages = [
    const ChatMessage(
      sender: 'Dr. Marcus Horizon',
      text: 'Hello, How can I help you?',
      time: '10 min ago',
      isDoctor: true,
    ),
    const ChatMessage(
      sender: 'Abdullah',
      text:
          'I suffer from a large brown spot with another dark spot\nA mole that changes color',
      time: '5 min ago',
      isDoctor: false,
    ),
    const ChatMessage(
      sender: 'Dr. Marcus Horizon',
      text: 'Ok, can you send a picture of this mole you talked about?',
      time: '5 min ago',
      isDoctor: true,
    ),
    const ChatMessage(
        sender: 'Abdullah',
        text: '',
        time: 'Just now',
        isDoctor: false,
        imageUrl: "assets/images/user.jpg"),
  ];

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dr. Marcus Horizon'),
        leading: const AppBackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return messages[index];
                },
              ),
            ),
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

  const ChatMessage({
    super.key,
    required this.sender,
    required this.text,
    required this.time,
    required this.isDoctor,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDoctor)
            const CircleAvatar(
              backgroundImage: AssetImage("assets/images/user.jpg"),
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
