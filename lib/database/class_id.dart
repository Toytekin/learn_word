import 'package:flutter_bloc/flutter_bloc.dart';

class ClasIDCubit extends Cubit<String> {
  ClasIDCubit() : super('');

  void settingClassID(String id) {
    emit(id);
  }
}
