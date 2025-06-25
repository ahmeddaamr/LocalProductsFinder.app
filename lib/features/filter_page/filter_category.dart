import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/filter_page/filter_lists.dart';
import 'package:flutter_application_1/features/filter_page/filter_widgets.dart';

class CategoriesFilter extends StatefulWidget {
  _CategoriesFilterState createState() => _CategoriesFilterState();
}

class _CategoriesFilterState extends State<CategoriesFilter> {
  late List<String> selectedCategories;

  @override
  void initState() {
    super.initState();
    print(
        "Selected Categories: ${FilterData.selectedCategories} ,  Temp Selected Categories: ${FilterData.tempSelectedCategories} ,  ${FilterData.categories}");
    selectedCategories = List.from(FilterData.selectedCategories);
    FilterData.tempSelectedCategories = List.from(selectedCategories);
  }

  void toggleCategory(String category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
    });

    FilterData.tempSelectedCategories = selectedCategories;
  }

  @override
  Widget build(BuildContext context) {
    final categories = FilterData.categories;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final isSelected = selectedCategories.contains(category);
        return buildFilterButtonBycategory(
          label: category,
          selected: isSelected,
          onTap: () {
            setState(() {
              toggleCategory(category);
            });
          },
        );
      },
    );
  }
}
