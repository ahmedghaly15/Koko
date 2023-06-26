import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koko/features/home/presentation/widgets/home_view_body.dart';
import 'package:tflite/tflite.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // used to check if an image is chosen or not
  bool loading = true;
  // chosen image from gallery or camera
  late File pickedImage;
  // prediction made by TensorFlow model
  late List prediction;
  // allows user to pick an image from camera or gallery
  final ImagePicker picker = ImagePicker();

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
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: HomeViewBody(
        loading: loading,
        image: pickedImage,
      ),
    );
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 5,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      prediction = output!;
      loading = false;
    });
  }

  Future<String?> loadModel() async {
    return await Tflite.loadModel(model: 'assets/tflite_model/kheva.tflite');
  }

  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return null;

    setState(() {
      pickedImage = File(image.path);
    });

    classifyImage(pickedImage);
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    setState(() {
      pickedImage = File(image.path);
    });

    classifyImage(pickedImage);
  }
}
