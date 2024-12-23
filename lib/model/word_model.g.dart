// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordModelAdapter extends TypeAdapter<WordModel> {
  @override
  final int typeId = 2;

  @override
  WordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WordModel(
      clasID: fields[0] as String,
      wordID: fields[1] as String,
      word: fields[2] as String,
      translationWord: fields[3] as String,
      rememberWord: fields[4] as String,
      wordImagePath: fields[5] as String?,
      weodSentencce: fields[6] as String?,
      weodSentencceTranslation: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WordModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.clasID)
      ..writeByte(1)
      ..write(obj.wordID)
      ..writeByte(2)
      ..write(obj.word)
      ..writeByte(3)
      ..write(obj.translationWord)
      ..writeByte(4)
      ..write(obj.rememberWord)
      ..writeByte(5)
      ..write(obj.wordImagePath)
      ..writeByte(6)
      ..write(obj.weodSentencce)
      ..writeByte(7)
      ..write(obj.weodSentencceTranslation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
