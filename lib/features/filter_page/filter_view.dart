import 'package:flutter/material.dart';
// import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/features/filter_page/filter_category.dart';
import 'package:flutter_application_1/features/filter_page/filter_criteria.dart';
import 'package:flutter_application_1/features/filter_page/filter_rating.dart';
import 'package:flutter_application_1/features/filter_page/filter_subcategory.dart';
import 'package:flutter_application_1/features/filter_page/filter_widgets.dart';
import 'package:flutter_application_1/features/filter_page/filter_lists.dart';
import 'package:flutter_application_1/core/models/product.dart';

class FilterForm extends StatefulWidget {
  // final VoidCallback onApply; // Callback to trigger update in HomeHeader
  // final Future<List<Product>> futureProducts;
  final Function(FilterCriteria) onApply;
  const FilterForm({
    super.key,
    required this.onApply,
    /*required this.onApply 
                    required this.futureProducts*/
  });

  @override
  _FilterFormState createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  // This replaces relying on FilterData directly inside child widgets
  List<String> tempSelectedCategories = List.from(
    FilterData.tempSelectedCategories,
  );

  // Called when category selection changes
  void updateSelectedCategories(List<String> categories) {
    setState(() {
      tempSelectedCategories = categories;
      FilterData.tempSelectedCategories = categories; // still keeps global sync
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //  color: MyColors.backgroundColor,
      padding: EdgeInsets.all(16),
      height: 300,
      child: Column(
        children: [
          SizedBox(height: 5),
          buildHeader(context, "Filters by"),
          // SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(3),
              children: [
                // buildHeader(context, "Filters by"),
                const SizedBox(height: 40),
                buildLabel("Category"),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  child: CategoriesFilter(
                    selectedCategories:
                        tempSelectedCategories, // Pass dynamic list
                    onChanged: updateSelectedCategories, // Callback to update)
                  ),
                ),
                SizedBox(height: 30),

                buildLabel("Sub-Category"),
                SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  child: SubCategoriesFilter(
                    selectedCategories: tempSelectedCategories,
                  ),
                ),
                SizedBox(height: 30),

                buildLabel("Rating"),
                const SizedBox(height: 20),
                SizedBox(height: 40, child: RatingFilter()),
                const SizedBox(height: 40),

                Row(
                  children: [
                    buildButton(
                      label: "Reset",
                      onPress: () {
                        //cancel
                        // FilterData.tempSelectedCategories = List.from(FilterData.selectedCategories);
                        // FilterData.tempSelectedSubCategories = List.from(FilterData.selectedSubCategories);
                        // FilterData.tempSelectedRatings = List.from(FilterData.selectedRatings);

                        FilterData.selectedCategories.clear();
                        FilterData.selectedSubCategories.clear();
                        FilterData.selectedRatings.clear();

                        FilterData.tempSelectedCategories.clear();
                        FilterData.tempSelectedSubCategories.clear();
                        FilterData.tempSelectedRatings.clear();
                        // Navigator.pop(context);
                      },
                    ),

                    const SizedBox(width: 10),

                    buildButton(
                      label: "Apply",
                      onPress: () {
                        final criteria = FilterCriteria(
                          categories: FilterData.tempSelectedCategories,
                          subCategories: FilterData.tempSelectedSubCategories,
                          ratings:FilterData.tempSelectedRatings.map((e) => int.parse(e)).toList(),
                        );

                        widget.onApply(criteria); // ✅ pass criteria back
                        Navigator.pop(context);

                        //TODO : apply filters logic "loop to choose the same products with the selected filters and apply them
                        // setState(() {
                        //   FilterData.selectedCategories = List.from(
                        //     FilterData.tempSelectedCategories,
                        //   );
                        //   FilterData.selectedSubCategories = List.from(
                        //     FilterData.tempSelectedSubCategories,
                        //   );
                        //   FilterData.selectedRatings = List.from(
                        //     FilterData.tempSelectedRatings,
                        //   );
                        // });

                        // // widget.onApply
                        // //     ?.call(); // ✅ TRIGGER update on HomeHeader
                        // Navigator.pop(context);
                        // //by sendding them to home page"
                        // //all of filters are stored into lists , just compare them with the products list
                        // //lists >>>>>>
                        // // FilterData.selectedCategories
                        // // FilterData.selectedSubCategories
                        // // FilterData.selectedRatings

                        // setState(() {
                        //   FilterData.selectedCategories = List.from(
                        //     FilterData.tempSelectedCategories,
                        //   );
                        //   FilterData.selectedSubCategories = List.from(
                        //     FilterData.tempSelectedSubCategories,
                        //   );
                        //   FilterData.selectedRatings = List.from(
                        //     FilterData.tempSelectedRatings,
                        //   );
                        // });

                        // Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
