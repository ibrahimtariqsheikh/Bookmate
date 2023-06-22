import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppColors {
  static const primary = Color(0xFF3281F6);
  static const secondaryLight = Color(0xFFFFFFFF);
  static const secondaryDark = Color(0xFF192F4A);
  static const tertiaryLight = Color(0xFFAFAFAF);
  static const tertiaryDark = Color(0xFF345E93);
  static const tertiaryContainer = Color(0xFF4F9AF7);
  static const scaffoldBackgroundLight = Color(0xFFF4F6F9);
  static const scaffoldBackgroundDark = Color(0xFF071E3A);
  static const textDark = Color(0xFF53585A);
  static const textLight = Color(0xFFF5F5F5);
  static const textFaded = Color(0xFF9899A5);
  static const iconLight = Color(0xFFB1B4C0);
  static const iconDark = Color(0xFFB1B3C1);
  static const logoLight = Color(0xFF303334);
  static const logoDark = Color(0xFFF9FAFE);
  static const cardLight = Color(0xFFF9FAFE);
  static const cardDark = Color(0xFF1A1A1C);
  static const dividerLight = Color.fromRGBO(0, 0, 0, .15);
  static const dividerDark = Color.fromRGBO(255, 255, 255, .25);
}

abstract class LightColors {
  static const primaryColor = AppColors.primary;
  static const secondaryColor = AppColors.secondaryLight;
  static const tertiaryColor = AppColors.tertiaryLight;
  static const tertiaryContainer = AppColors.tertiaryContainer;
  static const icon = AppColors.iconLight;
  static const logo = AppColors.logoLight;
  static const card = AppColors.cardLight;
  static const divider = AppColors.dividerLight;
  static const scaffoldBackgroundColor = AppColors.scaffoldBackgroundLight;
}

abstract class DarkColors {
  static const primaryColor = AppColors.primary;
  static const secondaryColor = AppColors.secondaryDark;
  static const tertiaryColor = AppColors.tertiaryDark;
  static const tertiaryContainer = AppColors.tertiaryContainer;
  static const icon = AppColors.iconDark;
  static const logo = AppColors.logoDark;
  static const card = AppColors.cardDark;
  static const divider = AppColors.dividerDark;
  static const scaffoldBackgroundColor = AppColors.scaffoldBackgroundDark;
}

abstract class AppTextStyles {
  static TextStyle bodyLarge({required bool isDark}) {
    return GoogleFonts.dmSans(
        textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: isDark ? AppColors.textLight : AppColors.logoLight,
    ));
  }

  static TextStyle bodySmall({required bool isDark}) {
    return GoogleFonts.dmSans(
        textStyle: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.textLight : AppColors.textDark,
    ));
  }

  static TextStyle bodyMedium({required bool isDark}) {
    return GoogleFonts.dmSans(
        textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: isDark ? AppColors.textLight : Colors.black,
    ));
  }

  static TextStyle displayLarge({required bool isDark}) {
    return GoogleFonts.dmSans(
        textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: isDark ? Colors.black : AppColors.textLight,
    ));
  }

  static TextStyle displayMedium({required bool isDark}) {
    return GoogleFonts.dmSans(
        textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.textLight : AppColors.textDark,
    ));
  }

  static TextStyle displaySmall() {
    return GoogleFonts.dmSans(
        textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textLight,
    ));
  }
}

abstract class AppTheme {
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: LightColors.primaryColor,
      scaffoldBackgroundColor: LightColors.scaffoldBackgroundColor,
      colorScheme: const ColorScheme.light(
        primary: LightColors.primaryColor,
        secondary: LightColors.secondaryColor,
        tertiary: LightColors.tertiaryColor,
        surface: LightColors.scaffoldBackgroundColor,
        background: LightColors.scaffoldBackgroundColor,
        onPrimary: LightColors.logo,
        onSecondary: LightColors.card,
        onSurface: LightColors.divider,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: LightColors.scaffoldBackgroundColor,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(color: LightColors.icon),
      textTheme: GoogleFonts.dmSansTextTheme()
          .apply(
            bodyColor: Colors.black,
          )
          .copyWith(
            bodyLarge: AppTextStyles.bodyLarge(isDark: false),
            bodyMedium: AppTextStyles.bodyMedium(isDark: false),
            bodySmall: AppTextStyles.bodyMedium(isDark: false),
            displayLarge: AppTextStyles.displayLarge(isDark: false),
            displayMedium: AppTextStyles.displayMedium(isDark: false),
            displaySmall: AppTextStyles.displaySmall(),
          ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: DarkColors.primaryColor,
        colorScheme: const ColorScheme.dark(
          primary: DarkColors.primaryColor,
          secondary: DarkColors.secondaryColor,
          tertiary: DarkColors.tertiaryColor,
          tertiaryContainer: DarkColors.tertiaryContainer,
          surface: DarkColors.scaffoldBackgroundColor,
          background: DarkColors.scaffoldBackgroundColor,
          onPrimary: DarkColors.logo,
          onSecondary: DarkColors.card,
          onSurface: DarkColors.divider,
        ),
        scaffoldBackgroundColor: DarkColors.scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: const IconThemeData(color: DarkColors.icon),
          titleTextStyle: GoogleFonts.dmSans(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
          backgroundColor: DarkColors.scaffoldBackgroundColor,
          elevation: 0,
        ),
        textTheme: GoogleFonts.dmSansTextTheme()
            .apply(
              bodyColor: Colors.white,
            )
            .copyWith(
              bodyLarge: AppTextStyles.bodyLarge(isDark: true),
              bodyMedium: AppTextStyles.bodyMedium(isDark: true),
              bodySmall: AppTextStyles.bodyMedium(isDark: true),
              displayLarge: AppTextStyles.displayLarge(isDark: true),
              displayMedium: AppTextStyles.displayMedium(isDark: true),
              displaySmall: AppTextStyles.displaySmall(),
            ));
  }
}
