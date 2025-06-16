import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/filter_page/filter_lists.dart';
import 'package:flutter_application_1/features/filter_page/filter_widgets.dart';


class SubCategoriesFilter extends StatefulWidget {
  @override
  _SubCategoriesFilterState createState() => _SubCategoriesFilterState();
}

class _SubCategoriesFilterState extends State<SubCategoriesFilter> {
   int? selectedIndex;
  late List<String> selectedSubCategories;

  @override
  void initState() {
    super.initState();
    selectedSubCategories = List.from(FilterData.selectedSubCategories); 
    FilterData.tempSelectedSubCategories = List.from(selectedSubCategories);
  }

  void toggleCategory(String category) {
    setState(() {
      if (selectedSubCategories.contains(category)) {
        selectedSubCategories.remove(category);
      } else {
        selectedSubCategories.add(category);
      }
    });

  FilterData.tempSelectedSubCategories = selectedSubCategories;
  }

  @override
  Widget build(BuildContext context) {
 final SubCategories = FilterData.subCategories;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: SubCategories.length,
      itemBuilder: (context, index) {
      final Subcategory = SubCategories[index];
      final isSelected = selectedSubCategories.contains(Subcategory);
      return buildFilterButtonBycategory(
        label: Subcategory,
        selected: isSelected,
        onTap: () {
          
          setState(() {
          toggleCategory(Subcategory);
           
            });
          },
        );
      },
    );
  }
}
