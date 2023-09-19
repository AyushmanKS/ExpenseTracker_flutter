import 'dart:ui'; // for blurr effect
import 'package:expense_flutter/components/expense_summary.dart';
import 'package:expense_flutter/components/expense_tile.dart';
import 'package:expense_flutter/data/expense_data.dart';
import 'package:expense_flutter/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TextField controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  // instance of Audio Player
  final player = AudioPlayer();

  // initState
  @override
  void initState() {
    super.initState();
    // prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // addNewExpense()
  void addNewExpense() {
    player.play(AssetSource('sounds/start.mp3'));
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),

          // Alert Dialog
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: const BorderSide(color: Colors.lightBlue, width: 1)),
            backgroundColor: Colors.transparent,
            title: const Text(
              'Add a new Expense',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // Text Fields Column
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // expense name
                TextField(
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                  autofocus: true,
                  controller: newExpenseNameController,
                  decoration: const InputDecoration(
                    labelText: 'Expense Name',
                    hintText: 'Expense name goes here',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ),

                // expense amount
                TextField(
                  autofocus: true,
                  controller: newExpenseAmountController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                      labelText: 'Amount (₹)',
                      hintText: 'Amount spent on Expense',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                )
              ],
            ),
            actions: [
              // Cancel Button
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                onPressed: cancel,
                child: const Text('Cancel'),
              ),

              // add Expense Button
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue),
                onPressed: save,
                child: const Text('Add Expense'),
              ),
            ],
          ),
        );
      },
    );
  }

  // save/Add Expense:  function
  void save() {
    if (newExpenseAmountController.text.isNotEmpty &&
        newExpenseNameController.text.isNotEmpty) {
      player.play(AssetSource('sounds/cash.mp3'));
      // Create newExpense item
      ExpenseItem newExpense = ExpenseItem(
          amount: newExpenseAmountController.text,
          dateTime: DateTime.now(),
          name: newExpenseNameController.text);

      // add the new expense
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }

    // closing dialog
    Navigator.pop(context);

    // calling clear function
    clear();
  }

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  // cancel function
  void cancel() {
    // closing dialog
    Navigator.pop(context);

    // calling clear function
    clear();
  }

  // clear TextController/ Textfields
  void clear() {
    newExpenseAmountController.clear();
    newExpenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // consumer since this is receiving values from provider
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        //appBar: AppBar(title: Text('Expenses')),

        backgroundColor: Colors.white,

        // floating action button
        floatingActionButton: FloatingActionButton(
          backgroundColor:
              const Color(0xfffcf3ba), //Color.fromARGB(255, 32, 146, 36),
          onPressed: addNewExpense,
          child: const Icon(Icons.add),
        ),

        // ListView builder
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              // Weekly Summary
              ExpenseSummary(startOfWeek: value.startOfWeekData()),

              // Expense List
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.getAllExpensesList().length,
                  itemBuilder: (context, index) => ExpenseTile(
                    name: value.getAllExpensesList()[index].name,
                    amount: value.getAllExpensesList()[index].amount,
                    dateTime: value.getAllExpensesList()[index].dateTime,
                    deleteTapped: (p0) =>
                        deleteExpense(value.getAllExpensesList()[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
