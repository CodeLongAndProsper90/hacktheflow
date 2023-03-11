import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

class MessageBubble extends StatelessWidget {
  final String sender_name;
  final String contents;
  final DateTime sent_at;
  MessageBubble(
      {Key? key,
      required this.sender_name,
      required this.contents,
      required this.sent_at});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          leading: const Icon(Icons.chat_bubble),
          title: Text(sender_name),
          subtitle: Text(contents)),
    );
  }
}
