import 'package:flutter/material.dart';





Widget buildUserEmail(String email, {double fontSize = 14}) {
  return Text(
    email,
    style: TextStyle(
      fontSize: fontSize,
      color: Colors.grey[600],
    ),
    textAlign: TextAlign.center,
  );
}

Widget buildProfileOption({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Material(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, size: 20, color: Colors.black87),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    ),
  );
}
