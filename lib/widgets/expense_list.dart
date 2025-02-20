import 'package:flutter/material.dart';
import 'package:money_manager/db/category_db.dart';
import 'package:money_manager/models/category_model.dart';


class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb1().expenseList, 
      builder: (BuildContext ctx, List<CategoryModel> newList, _)
      {
        return ListView.separated(
      itemBuilder: (ctx,index)
      {
        final category=newList[index];
        return Card(
          child: ListTile(
            title: Text(category.name),
            trailing: IconButton(
              onPressed: () { CategoryDb1.instance.deletecategory(category.id);},
              icon: Icon(Icons.delete)
            ,),
          ),
        );
      } ,
      separatorBuilder: (ctx,index) {return const SizedBox(height: 5);},
      itemCount: newList.length,
    );
      }
      );
  }
}