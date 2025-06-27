import 'package:flutter/material.dart';
import 'package:localproductsfinder/core/utils/colors.dart';
import 'package:localproductsfinder/core/utils/fonts.dart';
import 'package:localproductsfinder/core/utils/string.dart';

///header
Widget buildReviewHeader({
  required BuildContext context,
  String? title,
}) {
  return Row(
    children: [
      IconButton(
        icon: Icon(
          Icons.arrow_back_ios_sharp,
          color: MyColors.arrowColor,
          size: 20,
        ),
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacementNamed(context, Routes.home);
          }
        },
      ),
      Text(
        title ?? '',
        style: TextStyle(
          fontFamily: MyFonts.montserratFont,
          fontSize: 20,
          fontWeight: FontWeight.w200,
        ),
      ),
    ],
  );
  // );
}

//////////////button
Widget buildReviewButton({
  required String label,
  required VoidCallback onTap,
}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      fixedSize: const Size(330, 48),
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontFamily: MyFonts.montserratFont,
        fontWeight: FontWeight.w100,
        color: Colors.white,
        fontSize: 16,
      ),
    ),
  );
}

Widget buildProductImageAndTitle({
  required String productImageUrl,
  required String productTitle,
  double imageSize = 130,
  double spacing = 15,
}) {
  return Column(
    children: [
      Center(
        child: Image.network(
          productImageUrl, // ✅ Load images dynamically on scroll
          width: imageSize,
          height: imageSize,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator()); // ✅ Show loader while loading
          },
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 50, color: Colors.red); // ✅ Handle missing images
          },
        ),
      ),
      SizedBox(height: spacing),
      Center(
        child: Text(
          productTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(height: spacing),
    ],
  );
}

Widget buildReviewTextField({
  required String hintText,
  required TextEditingController controller,
}) {
  return TextField(
    controller: controller,
    maxLines: 5,
    decoration: InputDecoration(
      hintText: hintText,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 20,
      ),
      hintStyle: TextStyle(
        color: const Color.fromARGB(255, 159, 158, 158),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: MyColors.buttonColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: MyColors.buttonColor,
        ),
      ),
    ),
  );
}

Widget buildReviewRatingBar({
  required double initialRating,
  required ValueChanged<double> onRatingUpdate,
}) {
  return Row(
    children: List.generate(5, (index) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: IconButton(
          icon: Icon(
            size: 50,
            Icons.star_rate_sharp,
            color: index < initialRating ? Colors.grey : Colors.amber,
          ),
          onPressed: () => onRatingUpdate(index + 1.0),
        ),
      );
    }),
  );
}

Widget buildLabel(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    ),
  );
}
