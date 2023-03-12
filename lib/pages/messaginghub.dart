import 'package:flutter/material.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import '../colors.dart';
import '../widgets/messagepreview.dart';
import '../widgets/messaging_room.dart';

class MessagingHub extends StatefulWidget {
  // final List<Map<int, dynamic>> list_of_people;
  final namesList = ["charles", "mary", "john"];
  final Map<String, String> listOfPeople = {
    "charles": "descriptions",
    "mary": "descriptions2",
    "john": "descriptions3"
  };
  @override
  MessagingHub createState() => MessagingHub();}
  class MessagingHub extends State<MessagingHub> {
  // list -> int ->  to list of name of person and his description
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.check),
            label: "recent Connections",
          ),
          NavigationDestination(
            icon: Icon(Icons.people),
            label: "PeopleOfHouston",
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.33,
            width: double.maxFinite,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 48),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorAccent, width: 1.5),
                    color: colorForeground,
                    borderRadius: BorderRadiusDirectional.circular(40),
                  ),
                  child: Row(
                    children: [
                      
                      const Divider(
                        thickness: 2.0,
                        color: colorForegroundAlt,
                      ),
                      Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const HeaderText(text: "George"),
                          const SizedBox(height: 5),
                          const SmallText("listOfPeople[namesList[index]] as String")
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                        onPressed: () {
                          // ignore: invalid_use_of_protected_member
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        child: const Icon(Icons.message_outlined),
                      ),
                AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0, 
                  duration: const Duration(milliseconds: 200), 
                  child: Messagepreveiw(),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
}
