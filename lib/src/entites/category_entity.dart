class CategoryEntity {
  // decleare the variable
  String categoryId;
  String categoryname;
  String icon;
  String color;
  int totalexpnese;

  CategoryEntity({
    // constructor
    required this.categoryId,
    required this.categoryname,
    required this.icon,
    required this.color,
    required this.totalexpnese,
  });

  Map<String, Object?> toDocuments() {
    return {
      "categoryId": categoryId,
      "categoryname": categoryname,
      "icon": icon,
      "totalexpenses": totalexpnese,
      "color": color,
    };
  }

  static CategoryEntity fromDocuments(Map<String, dynamic> doc) {
    return CategoryEntity(
      categoryId: doc["categoryId"],
      categoryname: doc["categoaryname"],
      icon: doc["icon"],
      color: doc["totalexpenses"],
      totalexpnese: doc["color"],
    );
  }
}
