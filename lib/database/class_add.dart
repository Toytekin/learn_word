import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:learn_en/model/clas_model.dart';

class ClasAddCubit extends Cubit<List<ClassModel>> {
  ClasAddCubit() : super([]);

  var classBOX = Hive.box<ClassModel>('classBOX');
  List<ClassModel> allClassList = [];

  Future<void> clasADD(ClassModel clasModel) async {
    await classBOX.put(clasModel.clasID, clasModel);
    classGet();
  }

  Future<void> clasDelete(String clasID) async {
    await classBOX.delete(clasID);
    classGet();
  }

  Future<void> classGet() async {
    allClassList.clear();
    if (classBOX.isNotEmpty && classBOX.values.isNotEmpty) {
      allClassList = classBOX.values.toList();
    } else {
      allClassList = [];
    }
    emit(allClassList);
  }
}
