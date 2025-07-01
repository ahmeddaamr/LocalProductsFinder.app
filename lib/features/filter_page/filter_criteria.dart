class FilterCriteria {
  final List<String> categories;
  final List<String> subCategories;
  final List<int> ratings;

  FilterCriteria({
    this.categories = const [],
    this.subCategories = const [],
    this.ratings = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'Product Category': categories,
      'Sub-Category': subCategories,
      'average_rating': ratings,
    };
  }
}
