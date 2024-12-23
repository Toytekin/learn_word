import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_en/model/clas_model.dart';
import 'package:learn_en/model/color_adapter.dart';
import 'package:learn_en/model/word_model.dart';

class HiveHelper {
  static Future<void> initializeHive() async {
    // Hive'ı başlat
    await Hive.initFlutter();

    // Adapterleri kaydet
    Hive.registerAdapter(ColorAdapter());
    Hive.registerAdapter(ClassModelAdapter());
    Hive.registerAdapter(WordModelAdapter());

    // Kutuları aç
    await Hive.openBox<ClassModel>('classBOX');
    await Hive.openBox<WordModel>('worBOX');
  }
}
