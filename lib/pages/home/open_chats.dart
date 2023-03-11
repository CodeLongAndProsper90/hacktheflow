import 'package:flutter/cupertino.dart';
import 'package:hacktheflow/pages/chat_room.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:hacktheflow/widgets/profile_picture.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:hacktheflow/backend/message.dart';
import 'package:hacktheflow/backend/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class HomeOpenChatsPage extends StatefulWidget {
  const HomeOpenChatsPage({super.key});

  @override
  State<HomeOpenChatsPage> createState() => _HomeOpenChatsPageState();
}

class _HomeOpenChatsPageState extends State<HomeOpenChatsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          getUser(supabase.auth.currentUser!.id),
          getAllMessages(),
          getAllUsers(),
        ]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          AppUser user = snapshot.data![0];
          List<Message> all_messages = snapshot.data![1];
          List<AppUser> all_users = snapshot.data![2];

          Map<AppUser, List<Message>> msgs = {};
          for (AppUser u in all_users) {
            msgs[u] = [];
            for (Message m in all_messages) {
              if (m.rec_id == u.id) msgs[u]!.add(m);
            }
          }

          List<Map<String, dynamic>> chats = [];
          for (AppUser u in msgs.keys) {
            print(msgs[u]!.length);
            if (msgs[u]!.isNotEmpty) {
              List<Message> messages = msgs[u]!;
              messages.sort((a, b) => a.created_at.compareTo(b.created_at));

              final final_msg = messages[0];
              chats.add({
                "name": u.name,
                "id": u.id,
                "latest": final_msg.content,
                "date": final_msg.created_at
              });
            }
          }
          print(chats);

          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LogoText('Wynzo'),
                    ProfilePicture(name: user.name, radius: 40.0),
                  ],
                ),
                const SizedBox(height: 36.0),
                if (all_messages.isEmpty)
                  Center(
                    child: Column(
                      children: const [
                        Icon(CupertinoIcons.zzz, size: 64.0),
                        SizedBox(height: 10.0),
                        SubheaderText("It's quiet around here...")
                      ],
                    ),
                  )
                else
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
                            leading: ProfilePicture(
                                name: chat['name'], radius: 25.0),
                            title: LargeText(chat['name']),
                            subtitle: Text(
                              chat['latest'],
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: SmallText(
                                timestampToString(chat['date'].toLocal())),
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
        });
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
