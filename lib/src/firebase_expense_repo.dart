import 'dart:developer';

import 'package:expenses_tracker/src/entites/entites.dart';

import 'expense_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseExpenseRepo implements ExpenseRepository {
  final categoryCollection = FirebaseFirestore.instance.collection(
    'categories',
  );
  final expensecollection = FirebaseFirestore.instance.collection('user');

  @override
  Future<void> createCategory(Category category) async {
    try {
      await categoryCollection
          .doc(category.categoryId)
          .set(category.toentity().toDocuments());
      // if code successfuly then try will be execute
    } catch (e) {
      // if code generate error during run time  catch will be execute
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategory() async {
    try {
      return await expensecollection.get().then(
        (value) => value.docs
            .map(
              (e) =>
                  Category.fromentity(CategoryEntity.fromDocuments(e.data())),
            )
            .toList(),
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
