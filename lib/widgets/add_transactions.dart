import 'package:flutter/material.dart';
import 'package:money_manager/db/category_db.dart';
import 'package:money_manager/db/transactions_db.dart';
import 'package:money_manager/models/category_model.dart';
import 'package:money_manager/models/transaction_model.dart';
import 'package:money_manager/widgets/category_popup.dart';

class AddTransactions extends StatefulWidget {
  static const routeName = 'add-transactions';
  const AddTransactions({super.key});

  @override
  State<AddTransactions> createState() => _AddTransactionsState();
}

class _AddTransactionsState extends State<AddTransactions> {
  DateTime? _selectedDate;
  CategoryType? _selectedcategory;
  CategoryModel? _selectedmodel;
  String str = 'Select Date';
  String? _selectedValue=null;
  final _purposeTextController = TextEditingController();
  final _amountTextController = TextEditingController();
  

  @override
  void initState() {
    _selectedcategory=CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Purpose
            TextFormField(
              controller: _purposeTextController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Purpose',
              ),
            ),

            //Amount
            TextFormField(
              controller: _amountTextController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Amount',
              ),
            ),

            // Calendar
            TextButton.icon(
              onPressed: () async {
                // Show date picker dialog
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now(),
                );

                // Update state if a date is selected
                if (selectedDate != null) {
                  setState(() {
                    _selectedDate = selectedDate;
                    str = _selectedDate
                        .toString(); // Format this string as needed
                  });
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(str),
            ),

            //RadioButton
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                      value: CategoryType.income,
                      groupValue: _selectedcategory,
                      onChanged: (newValue)
                      {
                        setState(()
                        {
                         _selectedcategory=CategoryType.income;
                         _selectedValue=null;
                        });
                      }
                    ),
                    const Text('Income'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: CategoryType.expense,
                      groupValue: _selectedcategory,
                      onChanged: (newValue)
                      {
                        setState(()
                        {
                          _selectedcategory=CategoryType.expense;
                          _selectedValue=null;
                        });
                      }
                    ),
                    const Text('Expense'),
                  ],
                ),
              ],
            ),



          DropdownButton<String>(
  hint: const Text('Select Category'),
  value: _selectedValue,
  items: (_selectedcategory== CategoryType.income
          ? CategoryDb1().incomeList
          : CategoryDb1().expenseList)
      .value
      .map((e) {
    return DropdownMenuItem(
      value: e.id,
      child: Text(e.name),
      onTap: () {
        _selectedmodel =e;
       }
    ); // DropdownMenuItem
  }).toList(),
  onChanged:
  (selectedValue) {
    setState(()
      {
        _selectedValue=selectedValue;
      });
  },
  onTap: () { 
    
  },
), // DropdownButton      
        
            //SubmittButton
            ElevatedButton.icon(
              onPressed: () async {
                  await addTransactions();
                  if (mounted)    {
                  Navigator.of(context).pop();
                }
              },
// Prefer const with constant constructors.
              label: const Text(
                  'Submit'), // Prefer const with constant constructors.
            ),
          ],
        ),
      )),
    );
  }

  Future<void> addTransactions() async
  {
     final _purposeText=_purposeTextController.text;
     final _amountText=_amountTextController.text;
     if(_purposeText.isEmpty)
     {
       return;
     }
     if(_amountText.isEmpty)
     {
      return;
     }
     if(_selectedcategory==null)
     {
      return;
     }

     final _parsedamount= double.tryParse(_amountText);
     
     if(_parsedamount==null)
     {
       return;
     }

     
     final _model= TransactionModel(
        purpose: _purposeText,
        amount: _parsedamount,
        date: _selectedDate,
        categorytype: _selectedcategory,
        categorymodel: _selectedmodel,
      );

      await TransactionsDb().addTransaction(_model);
  }
}

