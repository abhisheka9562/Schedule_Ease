import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/models/transaction_model.dart';

const TRANSACTIONS_DB ='transactions_db';

abstract class transactionDBFunctions
{
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();

}

class TransactionsDb implements transactionDBFunctions
{
  TransactionsDb._internal();
  static TransactionsDb instance=TransactionsDb._internal();

  factory TransactionsDb()
  {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionList= ValueNotifier([]);
  
  late Box<TransactionModel> _db;

  Future<void> initialize() async 
  {
    if(!Hive.isBoxOpen(TRANSACTIONS_DB))
    {
      _db=await Hive.openBox(TRANSACTIONS_DB);
    }
  }
  
  Future<void> refreshUIUX() async
  {
    final _list= await getAllTransactions();
    _list.sort((first,second)=> second.date!.compareTo(first.date!));
    transactionList.value = List.unmodifiable(_list);
  }
  
  @override
  Future<void> addTransaction(TransactionModel obj) async
  {
    await initialize();
    await _db.put(obj.id,obj);
    refreshUIUX();
  }
  
  @override
  Future<List<TransactionModel>> getAllTransactions() 
  async {
    await initialize();
    return _db.values.toList();
  }
  
}