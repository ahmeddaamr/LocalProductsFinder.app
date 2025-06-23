import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileHeader extends StatefulWidget {
  final String userName;
  final String? initialImagePath;
  final double imageRadius;
  final double nameFontSize;
  final void Function(File?)? onImageChanged;

  const ProfileHeader({
    super.key,
    required this.userName,
    this.initialImagePath,
    this.onImageChanged,    
    this.imageRadius = 40,
    this.nameFontSize = 20,
  });

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  File? _selectedImage;

 Future<void> _pickImage(ImageSource source) async {
  final pickedFile = await ImagePicker().pickImage(
    source: source,
    imageQuality: 75,
  );


    if (pickedFile != null) {
  setState(() {
    _selectedImage = File(pickedFile.path);
  });
  widget.onImageChanged?.call(_selectedImage);
}

  }


  void _showImageOptions() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
             
          padding: const EdgeInsets.all(16.0),
          child: Wrap(

            children: [
              
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Edit Image'),
                onTap: () {
                  Navigator.pop(context);
                   _pickImage(ImageSource.gallery);
                },
              ),
              if (_selectedImage != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Delete Image'),
                 onTap: () {
                    setState(() {
                      _selectedImage = null;
                    });
                    widget.onImageChanged?.call(null);
                    Navigator.pop(context);
                
                  },
                ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Cancel'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }


  void _showFullImage() {
    if (_selectedImage != null || widget.initialImagePath != null) {
      showDialog(
        context: context,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : AssetImage(widget.initialImagePath!) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ImageProvider imageProvider = _selectedImage != null
        ? FileImage(_selectedImage!)
        : (widget.initialImagePath != null && widget.initialImagePath!.isNotEmpty)
            ? AssetImage(widget.initialImagePath!)
            : const AssetImage("assets/images/user.png");

    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              GestureDetector(
                onTap: _showFullImage,
                child: CircleAvatar(
                  radius: widget.imageRadius,
                  backgroundImage: imageProvider,
                  backgroundColor: Colors.grey.shade300,
                  child: (widget.initialImagePath == null && _selectedImage == null)
                      ? Text(
                          widget.userName.isNotEmpty
                              ? widget.userName[0].toUpperCase()
                              : "?",
                          style: TextStyle(
                            fontSize: widget.imageRadius / 1.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      : null,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _showImageOptions,
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    color: Color.fromARGB(255, 53, 205, 42),
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.userName,
          style: TextStyle(
            fontSize: widget.nameFontSize,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
