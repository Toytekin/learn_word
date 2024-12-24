import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SbtTranslations {
// Animasyonlu Geçiş
// ignore: non_constant_identifier_names
  static CustomTransitionPage<dynamic> animasyonluGecis(Widget Screen) {
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

// Bu geçiş, ekranın küçülmüş bir boyuttan büyüyerek (zoom in) görünmesini sağlar.
  static CustomTransitionPage<dynamic> scaleTransition(Widget screen) {
    return CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 500),
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var scale = Tween(begin: 0.8, end: 1.0).animate(animation);
        return ScaleTransition(scale: scale, child: child);
      },
    );
  }

// Bu geçiş, ekranın sağdan sola doğru kayarak görünmesini sağlar.
  static CustomTransitionPage<dynamic> slideTransition(Widget screen) {
    return CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 500),
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var offset = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .animate(animation);
        return SlideTransition(position: offset, child: child);
      },
    );
  }

// Bu geçiş, ekranın kendi ekseni etrafında dönerek görünmesini sağlar.
  static CustomTransitionPage<dynamic> rotationTransition(Widget screen) {
    return CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 500),
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var rotation = Tween(begin: 0.0, end: 1.0).animate(animation);
        return RotationTransition(turns: rotation, child: child);
      },
    );
  }

// Bu geçiş, ekranın büyüyerek ve aynı zamanda opaklık kazanarak (fade in) görünmesini sağlar.
  static CustomTransitionPage<dynamic> scaleFadeTransition(Widget screen) {
    return CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 500),
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var scale = Tween(begin: 0.8, end: 1.0).animate(animation);
        var opacity = Tween(begin: 0.0, end: 1.0).animate(animation);
        return ScaleTransition(
          scale: scale,
          child: FadeTransition(opacity: opacity, child: child),
        );
      },
    );
  }

// Bu geçiş, ekranın sağdan sola kayarken aynı anda opaklık kazanarak (fade in) görünmesini sağlar.
  static CustomTransitionPage<dynamic> slideFadeTransition(Widget screen) {
    return CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 500),
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var offset = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .animate(animation);
        var opacity = Tween(begin: 0.0, end: 1.0).animate(animation);
        return SlideTransition(
          position: offset,
          child: FadeTransition(opacity: opacity, child: child),
        );
      },
    );
  }

// Bu geçiş, ekranın hem büyüyerek (zoom in) hem de kendi ekseni etrafında dönerek görünmesini sağlar.
  static CustomTransitionPage<dynamic> scaleRotationTransition(Widget screen) {
    return CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 500),
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var scale = Tween(begin: 0.8, end: 1.0).animate(animation);
        var rotation = Tween(begin: 0.0, end: 1.0).animate(animation);
        return ScaleTransition(
          scale: scale,
          child: RotationTransition(turns: rotation, child: child),
        );
      },
    );
  }

// Bu geçiş, ekranın 3D perspektifinde yatay eksende dönerek görünmesini sağlar.
  static CustomTransitionPage<dynamic> flipTransition(Widget screen) {
    return CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 500),
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var rotation = Tween(begin: 1.0, end: 0.0).animate(animation);
        return AnimatedBuilder(
          animation: rotation,
          builder: (context, child) {
            final transform = Matrix4.rotationY(rotation.value * 3.14159);
            return Transform(
              transform: transform,
              alignment: Alignment.center,
              child: child,
            );
          },
          child: child,
        );
      },
    );
  }

// Bu geçiş, ekranın yaylanarak (bounce) büyümesi şeklinde görünmesini sağlar.
  static CustomTransitionPage<dynamic> bounceTransition(Widget screen) {
    return CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 400),
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curve =
            CurvedAnimation(parent: animation, curve: Curves.elasticOut);
        return ScaleTransition(scale: curve, child: child);
      },
    );
  }
}
