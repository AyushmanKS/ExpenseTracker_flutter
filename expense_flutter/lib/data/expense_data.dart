import 'package:expense_flutter/data/hive_database.dart';
import 'package:expense_flutter/dateTime/date_time_helper.dart';
import 'package:expense_flutter/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// instance of Audio Player
final player = AudioPlayer();

class ExpenseData extends ChangeNotifier {
  // list of all expenses
  List<ExpenseItem> overallExpenseList = [];

  // get expense list
  List<ExpenseItem> getAllExpensesList() {
    return overallExpenseList;
  }

  // prepare data to display
  final db = HiveDataBase();
  void prepareData() {
    print('-----------PrepareData()---------------------$db');
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
      print(
          '........overallExpenseList......................$overallExpenseList');
    }
  }

  //add a new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);

    print('*************************************$overallExpenseList');
    notifyListeners();
    db.saveData(overallExpenseList);
    print('Value of db:------> ${db.readData()}');
    print(
        '--------------------------addNewExpense() Called--------------------');
  }

  // delete a existing expense
  void deleteExpense(ExpenseItem expense) {
    player.play(AssetSource('sounds/delete.mp3'));
    overallExpenseList.remove(expense);

    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // get weekday (ex. monday, tuesday, wednesday.....)
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        'Tue';
      case 3:
        return 'Wed';
      case 4:
        'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
    return '';
  }

  // get date for start of week(sunday)
  DateTime startOfWeekData() {
    DateTime? startOfWeek;

    // get today's date
    DateTime today = DateTime.now();

    // go backwards from today to find sunday
    for (int i = 1; i <= 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  // converting whole expense list in a bar graph
  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      // date: {yyymmdd} : amount total for that day
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;

        // adding all amount of same day and storing in currentAmount
        currentAmount += amount;
        // assigning currentAmount to dailyExpenseSummary
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
