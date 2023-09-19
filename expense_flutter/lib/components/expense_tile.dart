import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ExpenseTile extends StatelessWidget {
  ExpenseTile(
      {required this.deleteTapped,
      required this.name,
      required this.amount,
      required this.dateTime});

  String name;
  String amount;
  DateTime dateTime;
  void Function(BuildContext)? deleteTapped;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          // delete button
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete_forever,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Card(
          color: Color.fromARGB(
              255, 222, 205, 94), //Color.fromARGB(255, 224, 183, 68),
          child: ListTile(
            // Printing title: Expense Name
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            // Printing subtitle: Date
            subtitle: Text(
              '${dateTime.day}/${dateTime.month}/${dateTime.year}',
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),

            // Printing trailing: amount
            trailing: Text(
              '₹$amount',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
