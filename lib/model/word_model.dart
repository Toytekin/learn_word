import 'package:hive/hive.dart';

part 'word_model.g.dart';

@HiveType(typeId: 2)
class WordModel {
  @HiveField(0)
  String clasID;
  @HiveField(1)
  String wordID;
  @HiveField(2)
  String word;
  @HiveField(3)
  String translationWord;
  @HiveField(4)
  String rememberWord;
  @HiveField(5)
  String? wordImagePath;
  @HiveField(6)
  String? weodSentencce;
  @HiveField(7)
  String? weodSentencceTranslation;

  WordModel({
    required this.clasID,
    required this.wordID,
    required this.word,
    required this.translationWord,
    required this.rememberWord,
    this.wordImagePath,
    this.weodSentencce,
    this.weodSentencceTranslation,
  });
}
