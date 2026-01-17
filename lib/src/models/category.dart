import '../entites/category_entity.dart';

class Category {
  // decleare the variable
  String categoryId;
  String categoryname;
  String icon;
  String color;
  int totalexpnese;

  Category({
    // constructor
    required this.categoryId,
    required this.categoryname,
    required this.icon,
    required this.color,
    required this.totalexpnese,
  });

  static final empty = Category(
    // initialize all the variable
    categoryId: "",
    categoryname: "",
    icon: "",
    color: "",
    totalexpnese: 0,
  );

  CategoryEntity toentity() {
    return CategoryEntity(
      categoryId: categoryId,
      categoryname: categoryname,
      icon: icon,
      color: color,
      totalexpnese: totalexpnese,
    );
  }

  static Category fromentity(CategoryEntity entity) {
    return Category(
      categoryId: entity.categoryId,
      categoryname: entity.categoryname,
      icon: entity.icon,
      color: entity.color,
      totalexpnese: entity.totalexpnese,
    );
  }
}
