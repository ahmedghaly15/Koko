import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final List<Color> colorizeColors = <Color>[
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  File? _pickedImage;
  // prediction made by TensorFlow model
  List<dynamic>? _prediction;
  // allows user to pick an image from camera or gallery
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Chicken Feces Classification",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: (_pickedImage == null && _prediction == null)
          ? const Center(
              child: Text(
                "Choose an image to classify",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            )
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _pickedImage == null
                      ? Container()
                      : Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.55,
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.file(
                                    _pickedImage!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Theme.of(context).primaryColor,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _pickedImage = null;
                                    _prediction = null;
                                  });
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(height: 20),
                  _prediction != null &&
                          double.parse(_prediction![0]["confidence"]
                                  .toStringAsFixed(1)) >
                              0.5
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Status: ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0,
                                  ),
                                ),
                                AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      '${_prediction![0]["label"]}',
                                      textAlign: TextAlign.center,
                                      speed: const Duration(milliseconds: 100),
                                      textStyle: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            AnimatedTextKit(
                              animatedTexts: [
                                ColorizeAnimatedText(
                                  'Confidence: ${(_prediction![0]['confidence'].toStringAsFixed(1))}',
                                  textStyle: const TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  colors: colorizeColors,
                                ),
                              ],
                            ),
                          ],
                        )
                      : const Text(
                          "There's no disease",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _optiondialogbox,
        backgroundColor: Colors.purple,
        child: const Icon(Icons.image),
      ),
    );
  }

  Future<void> _optiondialogbox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.purple,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (_pickedImage != null && _prediction != null) {
                        setState(() {
                          _pickedImage = null;
                          _prediction = null;
                        });
                      }
                      pickImage();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Take a Picture",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(10.0)),
                  GestureDetector(
                    onTap: () {
                      if (_pickedImage != null && _prediction != null) {
                        setState(() {
                          _pickedImage = null;
                          _prediction = null;
                        });
                      }
                      pickGalleryImage();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Select image ",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
    );

    setState(() {
      _prediction = output;
    });
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/tflite_model/kheva4.tflite',
      labels: 'assets/tflite_model/labels.txt',
    );
  }

  Future<void> pickImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    setState(() {
      _pickedImage = File(image.path);
    });

    classifyImage(_pickedImage!);
  }

  Future<void> pickGalleryImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    setState(() {
      _pickedImage = File(image.path);
    });

    classifyImage(_pickedImage!);
  }
}
