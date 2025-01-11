import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/category/transactions_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/screens/category/category_popup.dart';
import 'package:money_manager/screens/category/screen_category.dart';
import 'package:money_manager/screens/home/widgets/bottom_navigation.dart';
import 'package:money_manager/screens/transactions/add_transactions.dart';
import 'package:money_manager/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});
 
  static ValueNotifier<int> selectIndex=ValueNotifier(0);

  final _pages= const [
    ScreenTransaction(),
    ScreenCategory()
    ];
  @override
  Widget build(BuildContext context) {
    TransactionsDb().refreshUIUX();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 219, 211),
      appBar: AppBar(
        title: Text('MONEY MANAGER'),
        centerTitle: true,     
        backgroundColor: const Color.fromARGB(255, 78, 64, 155),  
        ),
      bottomNavigationBar: MMBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectIndex, 
          builder: (BuildContext ctx,int updatedIndex, _)
          { 
            return _pages[updatedIndex];}
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), 
          onPressed:()  
          {
             if(selectIndex.value==0)
             {
                print('Add transaction');
                Navigator.of(context).pushNamed(AddTransactions.routeName);
             }
             else
             {
               showCategoryPopup(context);
              /*print('Add category');
              final _sample = CategoryModel(id: DateTime.now().millisecondsSinceEpoch.toString(), 
              name: 'Travel', 
              type: CategoryType.expense);
              CategoryDb1().insertCategory(_sample); */
             }
          }
          ),
    );
  }
}