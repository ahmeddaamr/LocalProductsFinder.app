import 'package:flutter/material.dart';
// import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/features/filter_page/filter_category.dart';
import 'package:flutter_application_1/features/filter_page/filter_rating.dart';
import 'package:flutter_application_1/features/filter_page/filter_subcategory.dart';
import 'package:flutter_application_1/features/filter_page/filter_widgets.dart';
import 'package:flutter_application_1/features/filter_page/filter_lists.dart';

class FilterForm extends StatefulWidget {
  const FilterForm({Key? key}) : super(key: key);

  @override
  _FilterFormState createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 300,
      child: Column(
        children: [
          SizedBox(height: 5),
          buildHeader(context, "Filters by"),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(3),
              children: [
                const SizedBox(height: 40),
                buildLabel("Category"),
                const SizedBox(height: 20),
                SizedBox(height: 40, child: CategoriesFilter()),
                SizedBox(height: 30),
                buildLabel("Sub-Category"),
                SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  child: SubCategoriesFilter(),
                ),
                SizedBox(height: 30),
                buildLabel("Rating"),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  child: RatingFilter(),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    buildButton(
                        label: "Reset",
                        onPress: () {
                          FilterData.selectedCategories.clear();
                          FilterData.selectedSubCategories.clear();
                          FilterData.selectedRatings.clear();

                          FilterData.tempSelectedCategories.clear();
                          FilterData.tempSelectedSubCategories.clear();
                          FilterData.tempSelectedRatings.clear();
                          Navigator.pop(context);
                        }),
                    const SizedBox(width: 10),
                    buildButton(
                        label: "Apply",
                        onPress: () {
                          //TODO : apply filters logic "loop to choose the same products with the selected filters and apply them

                          //by sendding them to home page"
                          //all of filters are stored into lists , just compare them with the products list
                          //lists >>>>>>
                          // FilterData.selectedCategories
                          // FilterData.selectedSubCategories
                          // FilterData.selectedRatings

                          setState(() {
                            FilterData.selectedCategories =
                                List.from(FilterData.tempSelectedCategories);
                            FilterData.selectedSubCategories =
                                List.from(FilterData.tempSelectedSubCategories);
                            FilterData.selectedRatings =
                                List.from(FilterData.tempSelectedRatings);
                          });
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Filters applyed succefully."),
                            ),
                          );
                          Navigator.pop(context);
                        }),
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
