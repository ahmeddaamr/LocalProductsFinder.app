import 'dart:io';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String userName;
  final String? imagePath;
  final double imageRadius;
  final double nameFontSize;

  const ProfileAvatar({
    super.key,
    required this.userName,
    this.imagePath,
    this.imageRadius = 40,
    this.nameFontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    final bool isValidImage = imagePath != null && imagePath!.trim().isNotEmpty;
    final bool isFileImage = isValidImage && imagePath!.startsWith("/data");

    final ImageProvider? imageProvider = isValidImage
        ? (isFileImage ? FileImage(File(imagePath!)) : AssetImage(imagePath!))
        : null;

    final bool hasImage = imageProvider != null;

    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: imageRadius,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: hasImage ? imageProvider : null,
            child: !hasImage
                ? Text(
                    userName.isNotEmpty ? userName[0].toUpperCase() : "?",
                    style: TextStyle(
                      fontSize: imageRadius / 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          userName,
          style: TextStyle(
            fontSize: nameFontSize,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
