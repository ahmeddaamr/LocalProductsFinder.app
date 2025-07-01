import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/models/product.dart';
import 'package:flutter_application_1/features/filter_page/filter_criteria.dart';
import 'package:flutter_application_1/features/filter_page/filter_view.dart';

class FiltersButton extends StatelessWidget {
  final Future<List<Product>> futureProducts;
  final Function(FilterCriteria) onApply;  // ✅ pass apply handler
  const FiltersButton({
    super.key,
    required this.futureProducts,
    required this.onApply,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // showModalBottomSheet(
        //   context: context,
        //   shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        //   ),
        //   builder: (context) {
        //     return Container(
        //       padding: const EdgeInsets.all(16),
        //       height: 300, // Adjust height as needed
        //       child: const Column(
        //         children: [
        //           Text("Filter Options", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        //           SizedBox(height: 10),
        //           // Add filter options here
        //           Text("Coming soon..."),
        //         ],
        //       ),
        //     );
        //   },
        // );
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: MyColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.65,
              child: FilterForm(
                // futureProducts: futureProducts
                onApply: onApply,
                ),
            );
          },
        );
      },


      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: MyColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: MyColors.greenColor,
            width: 1,
          ), // Green border
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Path.filter, height: 18, width: 18),
            const SizedBox(width: 5),
            const Text(
              "F i l t e r s",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
