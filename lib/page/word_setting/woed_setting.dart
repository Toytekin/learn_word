import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_en/database/class_id.dart';
import 'package:learn_en/database/word_add_serv.dart';
import 'package:learn_en/model/word_model.dart';
import 'package:learn_en/router/router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class WordSettingScreen extends StatefulWidget {
  final WordModel wordModel;
  const WordSettingScreen({
    super.key,
    required this.wordModel,
  });

  @override
  State<WordSettingScreen> createState() => _WordSettingScreenState();
}

class _WordSettingScreenState extends State<WordSettingScreen> {
  //String
  late String classID;
  // Controller
  late TextEditingController mainWordController;
  late TextEditingController transWordController;
  late TextEditingController rememberWordController;
  late TextEditingController senteceWordController;
  late TextEditingController senteceTranslationController;

//File
  File? file;

  //İnitstate
  @override
  void initState() {
    super.initState();
    classID = context.read<ClasIDCubit>().state;
    setController();
  }

  void setController() {
    mainWordController = TextEditingController(text: widget.wordModel.word);
    transWordController =
        TextEditingController(text: widget.wordModel.translationWord);
    rememberWordController =
        TextEditingController(text: widget.wordModel.rememberWord);
    senteceWordController =
        TextEditingController(text: widget.wordModel.weodSentencce);
    senteceTranslationController =
        TextEditingController(text: widget.wordModel.weodSentencceTranslation);

    // File değişkenini güvenli şekilde ayarla
    if (widget.wordModel.wordImagePath != null) {
      file = File(
          widget.wordModel.wordImagePath!); // Path null değilse File oluştur.
    } else {
      file = null; // Path null ise file null olarak kalır.
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Ekran genişliğini alıyoruz
    double sizeWidth = MediaQuery.of(context).size.width;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                context.go(AppRoters.WORD);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          automaticallyImplyLeading: false,
          title: const Text('Word Setting Page'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                file != null
                    ? InkWell(
                        onTap: () {
                          _pickImage();
                        },
                        child: Image.file(
                          file!,
                          width: sizeWidth / 2,
                        ),
                      )
                    : IconButton(
                        onPressed: () {
                          _pickImage();
                        },
                        icon: const Icon(FontAwesomeIcons.photoFilm)),
                const SizedBox(height: 10),
                TextField(
                  controller: mainWordController,
                  decoration: const InputDecoration(
                    label: Text('Main Word'),
                    prefixIcon: Icon(FontAwesomeIcons.fileWord),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: transWordController,
                  decoration: const InputDecoration(
                    label: Text('Translation'),
                    prefixIcon: Icon(FontAwesomeIcons.fileWord),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                TextField(
                  controller: rememberWordController,
                  decoration: const InputDecoration(
                    label: Text('Reminiscence'),
                    prefixIcon: Icon(FontAwesomeIcons.brain),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                TextField(
                  controller: senteceWordController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.edit),
                    label: Text('Sentence'),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  maxLines: 4,
                  controller: senteceTranslationController,
                  decoration: const InputDecoration(
                    label: Text('Translation'),
                    prefixIcon: Icon(Icons.edit),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    deleteButton(context),
                    updateButton(context),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton deleteButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 90, 7, 1)),
      onPressed: () {
        context.read<WordCubbit>().worDelete(widget.wordModel);
        context.go(AppRoters.WORD);
      },
      child: const Text('Delete Word'),
    );
  }

  ElevatedButton updateButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (mainWordController.text.isNotEmpty &&
              transWordController.text.isNotEmpty &&
              rememberWordController.text.isNotEmpty) {
            var updateWordItem = WordModel(
              clasID: widget.wordModel.clasID,
              wordID: widget.wordModel.wordID,
              word: mainWordController.text.toString(),
              translationWord: transWordController.text.toString(),
              rememberWord: rememberWordController.text.toString(),
              weodSentencce: senteceWordController.text.toString(),
              weodSentencceTranslation:
                  senteceTranslationController.text.toString(),
              wordImagePath: file?.path,
            );
            context.read<WordCubbit>().wordADD(updateWordItem);
            context.go(AppRoters.WORD);
            textfildClear();
          } else {
            // Snackbar gösterimi
            final snackBar = SnackBar(
              content: const Text(
                  'Make sure that the Word, Translation, and Reminder fields are filled.'),
              action: SnackBarAction(
                label: 'Geri Al',
                onPressed: () {
                  // Geri al butonuna basıldığında yapılacak işlemler
                },
              ),
            );
            // ScaffoldMessenger kullanarak Snackbar'ı göster
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: const Text('Update Word'));
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, // Galeriden seçmek için
        maxWidth: 800, // İsteğe bağlı: Görüntü boyutunu küçültmek için
        maxHeight: 800,
      );

      if (pickedFile != null) {
        setState(() {
          file = File(pickedFile.path);
        });
      } else {
        debugPrint('Resim seçilmedi.');
      }
    } catch (e) {
      debugPrint('Bir hata oluştu: $e');
    }
  }

  void textfildClear() {
    mainWordController.clear();
    transWordController.clear();
    rememberWordController.clear();
    senteceTranslationController.clear();
    senteceWordController.clear();
  }
}
