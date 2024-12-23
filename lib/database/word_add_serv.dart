import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:learn_en/model/word_model.dart';

class WordCubbit extends Cubit<List<WordModel>> {
  WordCubbit() : super([]);

  var wordBOX = Hive.box<WordModel>('worBOX');
  List<WordModel> allWordList = [];

  Future<void> wordADD(WordModel wordmodel) async {
    await wordBOX.put(wordmodel.wordID, wordmodel);
    wordGet(wordmodel.clasID);
  }

  Future<void> worDelete(WordModel wordmodel) async {
    await wordBOX.delete(wordmodel.wordID);
    wordGet(wordmodel.clasID);
  }

  Future<void> wordGet(String clasID) async {
    allWordList.clear();
    if (wordBOX.isNotEmpty && wordBOX.values.isNotEmpty) {
      for (var element in wordBOX.values) {
        if (element.clasID == clasID) {
          allWordList.add(element);
        }
      }
    } else {
      allWordList = [];
    }
    emit(allWordList);
  }
}
