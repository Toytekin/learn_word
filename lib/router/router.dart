// ignore_for_file: constant_identifier_names

import 'package:go_router/go_router.dart';
import 'package:learn_en/model/word_model.dart';
import 'package:learn_en/page/home/home.dart';
import 'package:learn_en/page/play/play.dart';
import 'package:learn_en/page/word/word_add.dart';
import 'package:learn_en/page/word/words.dart';
import 'package:learn_en/page/word_setting/woed_setting.dart';
import 'package:learn_en/router/translation_animated.dart';

class AppRoters {
  static const String HOME = "/";
  static const String WORD_ADD = "/wordadd";
  static const String WORD = "/word";
  static const String WORD_SETTING = "/wordsetting";
  static const String PLAY = "/play";
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoters.HOME,
  routes: [
    GoRoute(
      path: AppRoters.HOME,
      builder: (context, state) => const HomeScreen(),
      pageBuilder: (context, state) {
        return SbtTranslations.slideFadeTransition(const HomeScreen());
      },
    ),
    GoRoute(
      path: AppRoters.WORD,
      builder: (context, state) => const WordsScreen(),
      pageBuilder: (context, state) {
        return SbtTranslations.slideFadeTransition(const WordsScreen());
      },
    ),
    GoRoute(
      path: AppRoters.WORD_ADD,
      builder: (context, state) => const WordAddScreen(),
      pageBuilder: (context, state) {
        return SbtTranslations.slideFadeTransition(const WordAddScreen());
      },
    ),
    GoRoute(
      path: AppRoters.WORD_SETTING,
      builder: (context, state) {
        final wordModel = state.extra as WordModel; // Gelen modeli alın.
        return WordSettingScreen(wordModel: wordModel);
      },
      pageBuilder: (context, state) {
        final wordModel = state.extra as WordModel; // Gelen modeli alın.
        return SbtTranslations.slideFadeTransition(
            WordSettingScreen(wordModel: wordModel));
      },
    ),
    GoRoute(
      path: AppRoters.PLAY,
      builder: (context, state) {
        final wordModelList = state.extra as List<WordModel>;
        return PlayScreen(words: wordModelList);
      },
      pageBuilder: (context, state) {
        final wordModelList = state.extra as List<WordModel>;
        return SbtTranslations.slideFadeTransition(
            PlayScreen(words: wordModelList));
      },
    ),
  ],
);
