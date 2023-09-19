import 'package:expense_flutter/bar%20graph/bar_graph.dart';
import 'package:expense_flutter/data/expense_data.dart';
import 'package:expense_flutter/dateTime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/adapters.dart';

// reference our box
final myBox = Hive.box('Expense_database');

class ExpenseSummary extends StatelessWidget {
  const ExpenseSummary({required this.startOfWeek, super.key});

  final DateTime startOfWeek;

  // Calculate maximum amount
  double calculateMaxAmount(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];
    // sort from lowest to highest
    values.sort();

    // largest value will be the last one
    max = values.last;
    return max == 0 ? 100 : max + 5;
  }

  // Calculate Week's total Expense(number)
  int calculateWeekTotalExpense() {
    List savedExpenses = myBox.get('All_EXPENSES') ?? [];
    return savedExpenses.length;
  }

  // Calculate Week's Total Amount
  double calculateWeekTotalAmount(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];
    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total == 0 ? 0.0 : total;
  }

  @override
  Widget build(BuildContext context) {
    // get yyymmdd for each day of this week
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Week's Total
          const Padding(
            padding: EdgeInsets.only(left: 25, top: 10),
            child: Text(
              "Week's Total",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),

          // Week's Expenses
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              children: [
                Text(
                  "Expense: ${calculateWeekTotalExpense()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                )
              ],
            ),
          ),

          // Week's Amount
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: Row(
              children: [
                Text(
                  "Amount: ₹${calculateWeekTotalAmount(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                )
              ],
            ),
          ),

          // Bar graph
          SizedBox(
            height: 220,
            child: MyBarGraph(
              maxY: calculateMaxAmount(value, sunday, monday, tuesday,
                  wednesday, thursday, friday, saturday),
              sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
              monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
              tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
              wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
              thuAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
              friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
              satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
