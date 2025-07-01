import 'package:flutter/material.dart';
import 'package:localproductsfinder/features/filter_page/filter_lists.dart';
import 'package:localproductsfinder/features/filter_page/filter_widgets.dart';


class SubCategoriesFilter extends StatefulWidget {
  final List<String> selectedCategories;       // New prop

  SubCategoriesFilter({required this.selectedCategories});
  
  @override
  _SubCategoriesFilterState createState() => _SubCategoriesFilterState();
}

class _SubCategoriesFilterState extends State<SubCategoriesFilter> {
  //  int? selectedIndex;
  late List<String> selectedSubCategories;

  @override
  void initState() {
    super.initState();
    selectedSubCategories = List.from(FilterData.selectedSubCategories); 
    FilterData.tempSelectedSubCategories = List.from(selectedSubCategories);
  }

  void toggleSubCategory(String subcategory) {
    setState(() {
      if (selectedSubCategories.contains(subcategory)) {
        selectedSubCategories.remove(subcategory);
      } else {
        selectedSubCategories.add(subcategory);
      }
    FilterData.tempSelectedSubCategories = selectedSubCategories;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // final allowedSubCategories = selectedCategories
    //     .map((cat) => FilterData.categoryToSubCategories[cat] ?? [])
    //     .expand((e) => e)
    //     .toList();
     // Dynamically get all subcategories from all categories
    final selectedCategories = widget.selectedCategories; // Use passed-in categories

    final allSubCategories = FilterData.categoryToSubCategories.values.expand((e) => e).toList();

    final allowed = selectedCategories.isEmpty
        ? allSubCategories
        : selectedCategories.map((cat) => FilterData.categoryToSubCategories[cat] ?? []).expand((e) => e).toList();

    final disabled = selectedCategories.isEmpty
        ? []
        : allSubCategories.where((s) => !allowed.contains(s)).toList();

    final combined = [...allowed, ...disabled]; // Display with priority

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: combined.length,
      itemBuilder: (context, index) {
      final subCategory = combined[index];
      final isEnabled = FilterData.selectedCategories.isEmpty || allowed.contains(subCategory);
      final isSelected = selectedSubCategories.contains(subCategory);

      return buildFilterButtonBycategory(
        label: subCategory,
        selected: isSelected,
        enabled: isEnabled,
        onTap: isEnabled
              ? () => toggleSubCategory(subCategory)
              : () {}, // do nothing if disabled
        );
      },
    );
  }
}
