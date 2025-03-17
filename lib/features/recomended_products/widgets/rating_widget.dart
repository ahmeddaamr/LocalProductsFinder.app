import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  const RatingWidget({super.key});

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => const Icon(
          Icons.star,
          color: Colors.amber,
          size: 18,
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';

// class RatingWidget extends StatelessWidget {
//   const RatingWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: List.generate(5, (index) {
//         return const Icon(Icons.star, color: Colors.amber, size: 16);
//       }),
//     );
//   }
// }
