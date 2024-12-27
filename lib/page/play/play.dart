import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_en/model/word_model.dart';
import 'package:learn_en/router/router.dart';

class PlayScreen extends StatefulWidget {
  final List<WordModel> words;
  const PlayScreen({
    super.key,
    required this.words,
  });

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late List<WordModel> shuffledWords;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    shuffledWords = List.from(widget.words)
      ..shuffle(); // Kelimeleri karıştırıyoruz.
    currentIndex = 0; // İlk kelimenin index'i
  }

  @override
  Widget build(BuildContext context) {
    // Ekran genişliğini alıyoruz
    double sizeWidth = MediaQuery.of(context).size.width;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false; // Geri tuşunu devre dışı bırakıyoruz
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.go(AppRoters.WORD);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text('Words: ${widget.words.length.toString()}'),
        ),
        body: Center(
          child: Swiper(
            itemCount: shuffledWords.length, // Kelime sayısı kadar kart
            itemBuilder: (BuildContext context, int index) {
              return FlipCard(
                direction: FlipDirection.HORIZONTAL,
                //?! İNGİLİZCE
                front: Card(
                  shadowColor: Colors.black,
                  key: ValueKey<int>(index),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Container(
                    width: 300,
                    height: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        shuffledWords[index].wordImagePath != null
                            ? Image.file(
                                File(shuffledWords[index].wordImagePath!),
                                width: sizeWidth / 3,
                                height: sizeWidth / 3,
                              )
                            : const SizedBox(),
                        const SizedBox(height: 20),
                        Text(
                          shuffledWords[index].word,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          shuffledWords[index].rememberWord,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.w700),
                        ),
                        shuffledWords[index].weodSentencce != null
                            ? Text(
                                shuffledWords[index].weodSentencce!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                //?! TÜRKÇE

                back: Card(
                  key: ValueKey<int>(index),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  shadowColor: Colors.white,
                  child: Container(
                    width: 300,
                    height: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        shuffledWords[index].wordImagePath != null
                            ? Image.file(
                                File(
                                  shuffledWords[index].wordImagePath!,
                                ),
                                width: sizeWidth / 3,
                                height: sizeWidth / 3,
                              )
                            : const SizedBox(),
                        const SizedBox(height: 20),
                        Text(
                          shuffledWords[index].translationWord,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          shuffledWords[index].rememberWord,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        shuffledWords[index].weodSentencce != null
                            ? Text(
                                shuffledWords[index].weodSentencceTranslation!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              );
            },
            loop: true, // Döngü yapma
            fade: 0.1,
            itemWidth: sizeWidth / 1.09,
            layout: SwiperLayout.TINDER,
            itemHeight: sizeWidth,
            curve: Curves.linear,

            viewportFraction: 0.5,
          ),
        ),
      ),
    );
  }
}
