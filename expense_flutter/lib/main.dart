import 'package:expense_flutter/data/expense_data.dart';
import 'package:expense_flutter/home_page.dart';
import 'package:flutter/material.dart';

// serice package for portrait mode
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  // initializing Hive
  await Hive.initFlutter();

  // creating a Hive box
  await Hive.openBox('Expense_database');
  print('Open Box......................${Hive.openBox('Expense_database')}');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // initState to initialize Portrait mode
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xfffcf3ba),
            title: const Center(
              child: Text(
                'SpendWise',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: const HomePage(),
        ),
      ),
    );
  }
}
