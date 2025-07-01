
class FilterData {

//TODO: retrieve these lists from the back-end

  static List<String> categories = ["Beverages", "Dairy", "Snacks"];

  static Map<String, List<String>> categoryToSubCategories = {
      "Beverages": ["Energy Drink", "Ice Coffee", "Juice", "Powder Juice", "Soft Drinks"],
      "Dairy": ["Butter", "Cheese", "Dessert", "Milk", "Yogurt", "Yogurt Drink"],
      "Snacks": ["Baked Snacks", "Biscuits", "Cake", "Candy", "Chips", "Chocolote", "Croissants", "Gums & Mints", "Tortilla Chips", "Wafers"],};
  static List<String> ratings = ["1", "2", "3", "4", "5"];
/////////////////////////////////////////////////
///
 static List<String> tempSelectedCategories = [];
 static List<String> tempSelectedSubCategories = [];
 static List<String> tempSelectedRatings = [];

/////////////////////////////////////////////////////////////////
  static List<String> selectedCategories = [];
  static List<String> selectedSubCategories = [];
  static List<String> selectedRatings = [];
}
