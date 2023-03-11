import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:image_picker/image_picker.dart';

class AddListingPage extends StatefulWidget {
  const AddListingPage({super.key});

  @override
  State<AddListingPage> createState() => _AddListingPageState();
}

class _AddListingPageState extends State<AddListingPage> {
  final formKey = GlobalKey<FormState>();
  final productNameCon = TextEditingController();
  final productDescCon = TextEditingController();

  final ImagePicker _p = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Text("Take photo"),
                  onPressed: () async {
                    XFile? img = await _p.pickImage(source: ImageSource.camera);
                    if (img == null) return;
                    image = img;
                  },
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const LargeText('I\'m selling'),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: styledTextFormField(
                              'something amazing!',
                              productNameCon,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          const LargeText('It is'),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: styledTextFormField(
                              'Describe your product',
                              productDescCon,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: colorForeground,
          child: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  String? validateNotNull(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a value';
    return null;
  }

  TextFormField styledTextFormField(
      String labelText, TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: colorHint,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      controller: controller,
      validator: validateNotNull,
    );
  }
}
