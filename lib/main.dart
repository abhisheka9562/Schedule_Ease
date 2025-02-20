import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/db/category_db.dart';
import 'package:money_manager/models/category_model.dart';
import 'package:money_manager/models/transaction_model.dart';
import 'package:money_manager/screens/home/screen_home.dart';
import 'package:money_manager/widgets/add_transactions.dart';

void main(List<String> args) async 
{
   WidgetsFlutterBinding.ensureInitialized();
   await Hive.initFlutter();
   if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId))
   {
      Hive.registerAdapter(CategoryModelAdapter());
   }
   if(!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId))
   {
      Hive.registerAdapter(CategoryTypeAdapter());
   }
   if(!Hive.isAdapterRegistered(TransactionModelAdapter().typeId))
   {
      Hive.registerAdapter(TransactionModelAdapter());
   }
   CategoryDb1().refreshUI();
   runApp(MyApp());  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money  Manager',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const ScreenHome(),
      routes: {
        AddTransactions.routeName:(ctx) => const AddTransactions(),
      }
    );
  }
}