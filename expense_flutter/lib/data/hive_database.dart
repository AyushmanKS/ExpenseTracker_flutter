import 'package:expense_flutter/models/expense_item.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDataBase {
  // reference our box
  final myBox = Hive.box('Expense_database');

  // writing data
  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }
    print(
        '..........allExpensesFormatted.......................$allExpensesFormatted');
    // storing data in hive database
    myBox.put('All_EXPENSES', allExpensesFormatted);
    print('.........All Keys...............................${myBox.keys}');
    print(
        '.....Stored in Database{_myBox.values}..............${myBox.values}');
  }

  // reading data
  List<ExpenseItem> readData() {
    print("Existing data in database: -----> ${myBox.get('All_EXPENSES')}");
    List savedExpenses = myBox.get('All_EXPENSES') ?? [];
    print(
        '*************savedExpenses*****************************$savedExpenses');
    List<ExpenseItem> allExpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      print('Value of i:----> $i');
      // collect individual expense data
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      print(
          '-------------------------Calling readData() function----------------');
      // create expense item
      ExpenseItem expense =
          ExpenseItem(amount: amount, dateTime: dateTime, name: name);

      // add expense to overall list of expenses
      allExpenses.add(expense);
    }
    return allExpenses;
  }

  // deleting data
}
