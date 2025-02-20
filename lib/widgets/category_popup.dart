import 'package:flutter/material.dart';
import 'package:money_manager/db/category_db.dart';
import 'package:money_manager/models/category_model.dart';

ValueNotifier<CategoryType> selectedCategory=ValueNotifier(CategoryType.income);

Future<void> showCategoryPopup(BuildContext context) async
{
   final _nameEditController = TextEditingController();

   showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text('Add category'),
        children: 
        [ Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: TextFormField(
            controller: _nameEditController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Category Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(children: [
            RadioButton(title: 'Income', type: CategoryType.income),
            RadioButton(title: 'Expense', type: CategoryType.expense),
          ],) 
        ),
          ElevatedButton(onPressed: () 
          {
            final _name=_nameEditController.text;
            if(_name.isEmpty)
            { return; }
            final _type= selectedCategory.value;
            final _catobj=CategoryModel(id: DateTime.now().millisecondsSinceEpoch.toString() ,name: _name, type: _type,);
            CategoryDb1().insertCategory(_catobj);
            Navigator.of(ctx).pop();
          },
           child: const Text('Add'),),
        ],
      );
    },
   );
}

class RadioButton extends StatelessWidget {
  
  RadioButton({super.key, required this.title,required this.type});

  final String title;
  final CategoryType type; 
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategory,
          builder:  (BuildContext ctx, CategoryType newCategory, _)
           {
            return  Radio<CategoryType>(value: type, groupValue: newCategory, onChanged: (value) {
            if(value==null)
            {
              return;
            }
            selectedCategory.value=value;
            selectedCategory.notifyListeners();
          });
          }
        ),
        Text(title),
      ],
    );
  }     
}


