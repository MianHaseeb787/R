// import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'gvalues.g.dart';

@HiveType(typeId: 8)
class Gvalues {
  Gvalues({required this.tax, required this.trn});
  @HiveField(0)
  late int tax;

  @HiveField(2)
  late String trn;
}
