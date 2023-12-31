import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rms/Hive/category.dart';
import 'package:rms/Hive/customerOrder.dart';
import 'package:rms/Hive/dailySales.dart';
import 'package:rms/Hive/employee.dart';
import 'package:rms/Hive/gvalues.dart';
import 'package:rms/Hive/menu.dart';
import 'package:rms/Hive/monthlySales.dart';
import 'package:rms/Home_screen.dart';
import 'package:path/path.dart' as path;

import 'boxes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Get the application documents directory
  Directory appDocumentsDir = await getApplicationDocumentsDirectory();

  // Specify the subdirectory name
  String subDirectoryName = "rmsdata";

  // Concatenate the subdirectory name to the document directory path
  String boxPath = path.join(appDocumentsDir.path, subDirectoryName);

  // Create the subdirectory if it doesn't exist
  Directory(boxPath).createSync(recursive: true);

  print(boxPath);

  Hive.init(boxPath);
  Hive.registerAdapter(MenuAdapter());
  Hive.registerAdapter(CustomerOrderAdapter());
  Hive.registerAdapter(OrderItemAdapter());
  Hive.registerAdapter(DailySalesAdapter());
  Hive.registerAdapter(MonthlySalesAdapter());
  Hive.registerAdapter(MenuCategoryAdapter());
  Hive.registerAdapter(EmployeeAdapter());
  Hive.registerAdapter(GvaluesAdapter());

  boxMenus = await Hive.openBox<Menu>('menuBox');
  boxOrders = await Hive.openBox<CustomerOrder>('orderBox');
  boxDailySales = await Hive.openBox<DailySales>('dailySales');
  boxMonthlySales = await Hive.openBox<MonthlySales>('montlySalesBox');
  boxCategorys = await Hive.openBox<MenuCategory>('menuCategoryBox');
  boxEmployees = await Hive.openBox<Employee>('employeeBox');
  boxGvalues = await Hive.openBox<Gvalues>('gvaluesBox');

  if (boxGvalues.isEmpty) {
    boxGvalues.add(Gvalues(tax: 0, trn: '00000'));
  }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark),
    home: const HomeScreen(),
  ));
}
