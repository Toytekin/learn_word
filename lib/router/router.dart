// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_en/page/home/home.dart';
import 'package:learn_en/page/word/word_add.dart';
import 'package:learn_en/page/word/words.dart';

class AppRoters {
  static const String HOME = "/";
  static const String WORD_ADD = "/wordadd";
  static const String WORD = "/word";
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoters.HOME,
  routes: [
    GoRoute(
      path: AppRoters.HOME,
      builder: (context, state) => const HomeScreen(),
      pageBuilder: (context, state) {
        return animasyonluGecis(const HomeScreen());
      },
    ),
    GoRoute(
      path: AppRoters.WORD,
      builder: (context, state) => const WordsScreen(),
      pageBuilder: (context, state) {
        return animasyonluGecis(const WordsScreen());
      },
    ),
    GoRoute(
      path: AppRoters.WORD_ADD,
      builder: (context, state) => const WordAddScreen(),
      pageBuilder: (context, state) {
        return animasyonluGecis(const WordAddScreen());
      },
    ),
  ],
);

// Animasyonlu Geçiş
// ignore: non_constant_identifier_names
CustomTransitionPage<dynamic> animasyonluGecis(Widget Screen) {
  return CustomTransitionPage(
    transitionDuration: const Duration(milliseconds: 500), // Geçiş süresi
    child: Screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Fade animasyonu
      var opacity = Tween(begin: 0.0, end: 1.0).animate(animation);
      return FadeTransition(opacity: opacity, child: child);
    },
  );
}
