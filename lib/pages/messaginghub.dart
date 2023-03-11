import 'package:flutter/material.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import '../colors.dart';
import '../widgets/messaging_room.dart';
class MessagingHub extends StatelessWidget {
  // ignore: non_constant_identifier_names
  // final List<Map<int, dynamic>> list_of_people;
  // ignore: non_constant_identifier_names
  final List1 = ["charles", "mary", "john"];
  // ignore: non_constant_identifier_names
  final Map<String, String> list_of_people = {"charles": "descriptions", "mary":"descriptions2", "john": "descriptions3"};
  // ignore: non_constant_identifier_names
  // list -> int ->  to list of name of person and his description
  // ignore: non_constant_identifier_names
  MessagingHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(destinations: const [NavigationDestination(icon: Icon(Icons.check), label: "recent Connections"), NavigationDestination(icon: Icon(Icons.people), label: "PeopleOfHouston")]),
      body:(ListView.builder(itemCount: list_of_people.length, itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.33,
          width: double.maxFinite,
          child: Column(
            children: [Container(
              margin: const EdgeInsets.symmetric(horizontal: 48),
              decoration: BoxDecoration( 
              border: Border.all(color: colorAccent, width: 1.5),
              color: colorForeground,
              borderRadius: BorderRadiusDirectional.circular(40)
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Messanger(personconnected: list_of_people[index],);
                  },
                  child: const Icon(Icons.message_outlined),
                ),
                const Divider(thickness: 2.0,
                  color: colorForegroundAlt,),
                Column(
                  children: [
                    HeaderText(List1[index]), 
                    const SizedBox(height: 5), 
                    SmallText(list_of_people[List1[index]] as String)
                  ],
                ),
              ],
            ),
            ), 
            const Spacer()
            ]
            // ignore: prefer_const_constructors
            
            ),
          
        );
      }, ))
    );
  }
}
