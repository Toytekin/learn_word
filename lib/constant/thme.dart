import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black12, // Arkaplan rengi siyah
    primaryColor: Colors.white, // Ana renk beyaz

    colorScheme: ColorScheme.dark(
      primary: Colors.white, // Ana renk
      secondary: Colors.grey[400]!, // Arkaplan rengi
      surface: Colors.grey[900]!, // Kart ve diyalog arka planı
      onPrimary: Colors.black12, // Ana rengin üzerine gelen yazılar
      onSecondary: Colors.white, // İkincil rengin üzerine gelen yazılar
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black12, // AppBar arkaplan rengi siyah
      iconTheme: IconThemeData(color: Colors.white), // İkon rengi beyaz
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    ),

    textTheme: TextTheme(
      bodyLarge:
          const TextStyle(color: Colors.white, fontSize: 16), // Ana metin
      bodyMedium:
          TextStyle(color: Colors.grey[300], fontSize: 14), // İkincil metin
      headlineLarge: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold), // Büyük başlık
      headlineSmall: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600), // Küçük başlık
      titleMedium:
          TextStyle(color: Colors.grey[400], fontSize: 14), // Alt başlık
      labelSmall:
          TextStyle(color: Colors.grey[500], fontSize: 12), // Açıklama metni
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[800], // Yükseltilmiş buton rengi koyu gri
        foregroundColor: Colors.white, // Buton metin rengi beyaz
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Buton köşe yuvarlama
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.grey[300], // Yazı tipi açık gri
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white, // Yazı rengi beyaz
        side: BorderSide(
            color: Colors.grey[700]!, width: 1.5), // Çerçeve rengi ve genişliği
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Köşe yuvarlama
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      ),
    ),

    cardTheme: CardTheme(
      color: Colors.grey[900], // Kart arka plan rengi
      elevation: 4, // Gölge yüksekliği
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Köşe yuvarlama
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[900], // Input alanı arkaplanı
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[700]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white),
      ),
      hintStyle: TextStyle(color: Colors.grey[500]), // Placeholder metin rengi
    ),
  );
}
