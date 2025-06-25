import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/filter_page/filter_lists.dart';
import 'package:flutter_application_1/features/filter_page/filter_widgets.dart';

class RatingFilter extends StatefulWidget {
  @override
  _RatingFilterState createState() => _RatingFilterState();
}

class _RatingFilterState extends State<RatingFilter> {
  
  late List<String> selectedRatings;

  @override
  void initState() {
    super.initState();
    selectedRatings = List.from(FilterData.tempSelectedRatings);
    FilterData.tempSelectedRatings = List.from(selectedRatings);
  }

  void toggleRating(String rating) {
    setState(() {
      if (selectedRatings.contains(rating)) {
        selectedRatings.remove(rating);
      } else {
        selectedRatings.add(rating);
      }
      FilterData.tempSelectedRatings = selectedRatings;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ratings = FilterData.ratings;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: ratings.length,
      itemBuilder: (context, index) {
        final rating = ratings[index];
        final isSelected = selectedRatings.contains(rating);

        return buildFilterButtonByRating(
          rating: rating,
          selected: isSelected,
          onTap: () { 
            
            setState(() {
           
            toggleRating(rating);
    
            });
      
      });
      },
    );
  }
}
