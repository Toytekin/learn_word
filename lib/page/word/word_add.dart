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
import 'package:uuid/uuid.dart';

class WordAddScreen extends StatefulWidget {
  const WordAddScreen({super.key});

  @override
  State<WordAddScreen> createState() => _WordAddScreenState();
}

class _WordAddScreenState extends State<WordAddScreen> {
  //String
  late String classID;
  // Controller
  var mainWordController = TextEditingController();
  var transWordController = TextEditingController();
  var rememberWordController = TextEditingController();
  var senteceWordController = TextEditingController();
  var senteceTranslationController = TextEditingController();

//File
  File? file;

  //İnitstate
  @override
  void initState() {
    super.initState();
    classID = context.read<ClasIDCubit>().state;
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
          title: const Text('Word Add Page'),
        ),
        body: SingleChildScrollView(
          child: Center(
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
                  const SizedBox(height: 100),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 30, 74, 32),
                      ),
                      onPressed: () {
                        if (mainWordController.text.isNotEmpty &&
                            transWordController.text.isNotEmpty &&
                            rememberWordController.text.isNotEmpty) {
                          var newWordItem = WordModel(
                            clasID: classID,
                            wordID: const Uuid().v1(),
                            word: mainWordController.text.toString(),
                            translationWord:
                                transWordController.text.toString(),
                            rememberWord:
                                rememberWordController.text.toString(),
                            weodSentencce:
                                senteceWordController.text.toString(),
                            weodSentencceTranslation:
                                senteceTranslationController.text.toString(),
                            wordImagePath: file?.path,
                          );
                          context.read<WordCubbit>().wordADD(newWordItem);
                          textfildClear();
                          context.go(AppRoters.WORD);
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
                      child: const Text('Save Word'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
