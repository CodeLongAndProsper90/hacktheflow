import 'package:hacktheflow/pages/chat_room.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:hacktheflow/widgets/profile_picture.dart';
import 'package:hacktheflow/widgets/styled_text.dart';

class HomeOpenChatsPage extends StatefulWidget {
  const HomeOpenChatsPage({super.key});

  @override
  State<HomeOpenChatsPage> createState() => _HomeOpenChatsPageState();
}

class _HomeOpenChatsPageState extends State<HomeOpenChatsPage> {
  final name = 'John Doe';

  List<Map<String, dynamic>> chats = [
    {
      'name': 'Jane Doe',
      'id': 'b7891604-2cff-48bb-ad00-bc9097af1086',
      'latest': 'I heard you were selling blue posters.',
      'date': DateTime.now(),
    },
    {
      'name': 'Alice',
      'id': '',
      'latest': 'Hello world',
      'date': DateTime.now(),
    },
    {
      'name': 'Bob',
      'id': '',
      'latest': 'Hello world',
      'date': DateTime.now(),
    },
    {
      'name': 'Charlie',
      'id': '',
      'latest': 'Hello world',
      'date': DateTime.now(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LogoText('Wyzno'),
              ProfilePicture(name: name, radius: 40.0),
            ],
          ),
          const SizedBox(height: 36.0),
          Expanded(
            child: ListView.separated(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                var chat = chats[index];

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ChatRoomPage(to_id: chat['id']);
                        },
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8.0),
                  child: ListTile(
                    leading: ProfilePicture(name: chat['name'], radius: 25.0),
                    title: LargeText(chat['name']),
                    subtitle: Text(
                      chat['latest'],
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: SmallText(timestampToString(chat['date'])),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16.0);
              },
            ),
          ),
        ],
      ),
    );
  }

  String timestampToString(DateTime timestamp) {
    var now = DateTime.now();
    if (timestamp.day == now.day) {
      return DateFormat.jm().format(timestamp);
    } else {
      return DateFormat.MMMMd().format(timestamp);
    }
  }
}
