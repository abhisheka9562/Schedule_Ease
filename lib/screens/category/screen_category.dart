import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/screens/category/expense_list.dart';
import 'package:money_manager/screens/category/income_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  void initState()
  {
    _tabController = TabController(length: 2,vsync: this);
    CategoryDb1().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      return Column(children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          tabs: [Tab(text: 'INCOME'),
          Tab(text: 'EXPENSE')],
        ),
        Expanded(
          child: TabBarView(
          controller: _tabController,
          children: 
          [
            IncomeList(),
            ExpenseList(),
          ],),
        ),
        ],);
  }
}