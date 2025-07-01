import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/features/result/result_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/core/const/config.dart';
import 'package:flutter_application_1/core/models/product.dart';


class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

 Future predict(File image) async {
    var request = http.MultipartRequest('POST', Uri.parse('${config.URI}/predict')); 
    request.files.add(await http.MultipartFile.fromPath('file', image.path)); 

    try {
      var response = await request.send(); 
      // Convert StreamedResponse to String
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
          print("✅ Image uploaded successfully!");
          print(response);
          final json = jsonDecode(responseBody);
          return Product.fromJson(json); // Assuming Product.fromJson is defined to parse the response
      } else {
          print("Failed to upload image: ${response.statusCode}"); 
      }
    } catch (e) {
      print("Error uploading image: $e"); 
      return jsonEncode({"error": e.toString()});
    }
  }


  Future<void> _captureImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        // print(pickedFile.path);
      });
      var product = await predict(_image!);
      print(product);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            // image: _image!,
            // isLocal:  (jsonResponse['local'] == 'Yes'?true:false),
            // productName: jsonResponse['predicted_label'],
            // productId: jsonResponse['product_id'],
            product:product,
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

      var product = await predict(_image!);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            // image: _image!,
            // isLocal:  (jsonResponse['local'] == 'Yes'?true:false),
            // productName: jsonResponse['predicted_label'],
            // productId: jsonResponse['product_id'],
            product: product,
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
                          decoration: const BoxDecoration(
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














