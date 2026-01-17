import 'package:expenses_tracker/src/models/models.dart';

abstract class ExpenseRepository {
  Future<void> createCategory(Category category);
  Future<void> getCategory();
}
