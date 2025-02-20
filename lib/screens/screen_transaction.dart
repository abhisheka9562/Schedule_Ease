import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/category_db.dart';
import 'package:money_manager/db/transactions_db.dart';
import 'package:money_manager/models/category_model.dart';
import 'package:money_manager/models/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionsDb().refreshUIUX();
    CategoryDb1().refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionsDb().transactionList,
      builder:(BuildContext ctx, List<TransactionModel> newList, Widget? _ ) 
      {
         return  ListView.separated(
        padding: EdgeInsets.all(10),
        itemBuilder: (ctx,index) { 
          final _value=newList[index];
          return Card(
            elevation: 0,
            child: ListTile(
              title: Text('RS ${_value.amount}'),
              leading: CircleAvatar(
                radius: 50,
                child: Text(
                  parseDate(_value.date),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: _value.categorytype==CategoryType.income 
                                 ? Colors.green
                                 : Colors.red
                ,
              ),
            ),
          );
        }, 
        separatorBuilder: (ctx,index) { return const SizedBox(height: 5); }, 
        itemCount: newList.length,
        ); }
    );
  }

  String parseDate(DateTime? date)
  {
    final _date=DateFormat.MMMd().format(date!);
    final _splitedDate= _date.split(' ');
    return '${_splitedDate.last} \n${_splitedDate.first}';
  }
}