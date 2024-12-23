import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'clas_model.g.dart';

@HiveType(typeId: 1)
class ClassModel {
  @HiveField(0)
  String clasID;
  @HiveField(1)
  String className;

  ClassModel({
    required this.clasID,
    required this.className,
  });
}
