
import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xFFDADADA),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'OR',
            style: TextStyle(
              color: Color(0xFFDADADA),
              fontSize: 24,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xFFDADADA),
          ),
        ),
      ],
    );
  }
}