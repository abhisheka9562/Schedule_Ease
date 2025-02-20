import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/models/category_model.dart';

const Category_Db_Box='category-database';

abstract class CategoryDb 
{
  Future<List<CategoryModel>> getcategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deletecategory(String categoryId);
  refreshUI();
}

List<CategoryModel> temp=[];

class CategoryDb1 implements CategoryDb
{
  
  CategoryDb1._internal();
  static CategoryDb1 instance=CategoryDb1._internal();

  factory CategoryDb1()
  {
    return instance;
  }
  
  ValueNotifier<List<CategoryModel>> incomeList= ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseList= ValueNotifier([]);

  @override
    Future<List<CategoryModel>> getcategories() async
    {
       final _categoryDBBox=await Hive.openBox(Category_Db_Box);
       return _categoryDBBox.values.cast<CategoryModel>().toList();

    }

  @override
  Future<void> insertCategory(CategoryModel value) async
  {
     final _categoryDBBox=await Hive.openBox(Category_Db_Box);
     await _categoryDBBox.put(value.id,value);
     refreshUI();
  }


  Future<void> refreshUI() async {
  final _allCategories = await getcategories();

  // Optimized: Filter categories directly and assign to ValueNotifier
  incomeList.value = List.unmodifiable(
      _allCategories.where((category) => category.type == CategoryType.income).toList());

  expenseList.value = List.unmodifiable(
      _allCategories.where((category) => category.type == CategoryType.expense).toList());
}

  @override
  Future<void> deletecategory(String categoryId) async
  {
    final _categoryDBBox=await Hive.openBox(Category_Db_Box);
    await _categoryDBBox.delete(categoryId);
    refreshUI();
  }


  
}
