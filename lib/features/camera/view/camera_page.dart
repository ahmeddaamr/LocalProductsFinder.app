import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/features/result/result_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            image: _image!,
            isLocal: false,
            productName: 'Pepsi',
          ),
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            image: _image!,
            isLocal: true,
            productName: 'Pepsi',
          ),
        ),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 108, 106, 106),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 108, 106, 106),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacementNamed(context, Routes.home),
        ),
      ),


      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.image, color: Colors.white, size: 30),
                        onPressed: _pickImage,
                      ),
                      GestureDetector(
                        onTap: _captureImage,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera, color: Colors.black, size: 50),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh, color: Colors.white, size: 30),
                        onPressed: () {}, // Placeholder for a future function
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}














