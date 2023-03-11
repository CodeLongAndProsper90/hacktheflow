import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

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
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: (image != null
                      ? <Widget>[
                          FutureBuilder(
                            future: image!.readAsBytes(),
                            builder: (BuildContext context,
                                AsyncSnapshot<Uint8List> snapshot) {
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              }
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Image.memory(snapshot.data!),
                              );
                            },
                          )
                        ]
                      : <Widget>[]) +
                  <Widget>[
                    IconButton(
                      icon: const Icon(Icons.photo_camera_outlined),
                      color: colorForeground,
                      onPressed: () async {
                        XFile? img =
                            await _p.pickImage(source: ImageSource.camera);
                        if (img == null) return;
                        setState(() {
                          image = img;
                        });
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
                              const LargeText('What is it?'),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 30.0,
          bottom: 30.0,
        ),
        child: SizedBox(
          height: 80.0,
          child: TextButton(
            onPressed: () {
              // Magic
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                const StadiumBorder(),
              ),
              backgroundColor: MaterialStateProperty.all(
                colorForeground,
              ),
            ),
            child: const BodyText(
              'List my item',
              style: TextStyle(color: colorBackground),
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
