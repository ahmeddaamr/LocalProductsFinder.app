import 'dart:io';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String userName;
  final String? imagePath;
  final double imageRadius;
  final double nameFontSize;
  final VoidCallback onEditTap;

  const ProfileAvatar({
    super.key,
    required this.userName,
    this.imagePath,
    required this.onEditTap,
    this.imageRadius = 40,
    this.nameFontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    final ImageProvider imageProvider = imagePath != null && imagePath!.isNotEmpty
        ? (imagePath!.startsWith("/data") ? FileImage(File(imagePath!)) : AssetImage(imagePath!))
            as ImageProvider
        : const AssetImage("assets/images/user.png");

    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: imageRadius,
                backgroundImage: imageProvider,
                backgroundColor: Colors.grey.shade300,
                child: (imagePath == null || imagePath!.isEmpty)
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
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onEditTap,
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
