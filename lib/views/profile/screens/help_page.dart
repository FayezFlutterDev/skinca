import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  static const String routeName = '/help';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help centre'),
            subtitle: const Text('Terms and Privacy Policy'),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Terms and Privacy Policy'),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('App info'),
            onTap: () {
              // Handle tap
            },
          ),
        ],
      ),
    );
  }
}
