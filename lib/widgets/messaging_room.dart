import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// final supabase = Supabase.instance.client;

class Messanger extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final personconnected;
  Messanger({super.key, required this.personconnected});
  // ignore: non_constant_identifier_names
  final Map<String, List<String>> person_connections = {
    "Joe": ["hello can I buy", "hello again"],
    "Mary": ["hi can i get more info? about your sell"]
  };
//  Future<void> fetchRow() async {
//   final response = await SupabaseClient("blahapi", "blahkey")
//       .from('table_name')
//       .select()
//       .eq('namecolumn', )
//       .single()
//       .execute();

//   if (response.error != null) {
//     // Handle the error here
//     return;
//   }

//   final row = response.data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.1,
      ),
      // ignore: prefer_const_constructors
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(39),
              ),
              color: colorBackground,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(45),
                child: ListView.builder(
                  itemCount:
                      person_connections[personconnected.toString()]?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      height: MediaQuery.of(context).size.height * .33,
                      child: LogoSmallText(
                        person_connections[personconnected.toString()]![index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 20,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Container(
              decoration: const BoxDecoration(
                color: colorAccent,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.elliptical(39, 50),
                  right: Radius.elliptical(39, 50),
                ),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Message here',
                  hintStyle: TextStyle(fontFamily: AutofillHints.jobTitle),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
