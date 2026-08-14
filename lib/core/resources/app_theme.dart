import 'package:flutter/material.dart';
import 'colors_manager.dart';


class AppTheme {
  static ThemeData lightTheme= ThemeData(
    switchTheme: SwitchThemeData(
        padding: EdgeInsets.zero,
        trackOutlineColor: WidgetStateColor.resolveWith((states) {
          return ColorsManager.unselectedTab;
        },),
        trackColor: WidgetStateColor.resolveWith((states) {
        return ColorsManager.unselectedTab;
      },),
      thumbColor: WidgetStateColor.resolveWith((states) {
        return ColorsManager.onPrimaryColor;
      },)
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: Colors.transparent,
      labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
        if(states.contains(WidgetState.selected)){
          return TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: ColorsManager.primaryColor
          );
        }
        return TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ColorsManager.unselectedTab
        );
      },)
    ),
    appBarTheme: AppBarThemeData(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: ColorsManager.secondaryColor
      )
    ),
    scaffoldBackgroundColor: ColorsManager.backgroundColor,
    colorScheme: ColorScheme.light(
      primary: ColorsManager.primaryColor,
      secondary: ColorsManager.secondaryColor,
      tertiary: ColorsManager.teritaryColor,
      onPrimary: ColorsManager.onPrimaryColor,
        onSecondary: ColorsManager.fieldBorder,
      onTertiary: ColorsManager.primaryColor,
      onPrimaryContainer: ColorsManager.fieldBorder
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: ColorsManager.secondaryColor
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ColorsManager.teritaryColor
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: ColorsManager.primaryColor
      ),
      displayMedium: TextStyle(
          color: ColorsManager.darkSecondaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 14
      ),
        displaySmall: TextStyle(
            color: ColorsManager.primaryColor,
            fontWeight: FontWeight.w400,
            fontSize: 14
        ),
        labelMedium: TextStyle(
            color: ColorsManager.onPrimaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 20
        ),
        labelSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: ColorsManager.hintTextColor
        ),
        headlineMedium: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: ColorsManager.primaryColor,
            decoration: TextDecoration.underline,
            decorationColor: ColorsManager.primaryColor
        )
    )
  );
  static ThemeData darkTheme= ThemeData(
      switchTheme: SwitchThemeData(
          padding: EdgeInsets.zero,
          trackColor: WidgetStateColor.resolveWith((states) {
            return ColorsManager.darkPrimaryColor;
          },),
          thumbColor: WidgetStateColor.resolveWith((states) {
            return ColorsManager.onPrimaryColor;
          },)
      ),

      navigationBarTheme: NavigationBarThemeData(
          backgroundColor: ColorsManager.darkBackgroundColor,
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
            if(states.contains(WidgetState.selected)){
              return TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.darkPrimaryColor
              );
            }
            return TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: ColorsManager.unselectedTab
            );
          },)
      ),
    scaffoldBackgroundColor: ColorsManager.darkBackgroundColor,
    appBarTheme: AppBarThemeData(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: ColorsManager.darkSecondaryColor
      )
    ),
      textTheme: TextTheme(
          titleMedium: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: ColorsManager.darkSecondaryColor
          ),
          bodyMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorsManager.darkTeritaryColor
          ),
          titleSmall: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorsManager.darkSecondaryColor
          ),
          displayMedium: TextStyle(
              color: ColorsManager.darkSecondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 14
          ),
          displaySmall: TextStyle(
              color: ColorsManager.darkSecondaryColor,
              fontWeight: FontWeight.w400,
              fontSize: 14
          ),
        labelMedium: TextStyle(
          color: ColorsManager.onPrimaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 20
        ),
        labelSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorsManager.darkTeritaryColor
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: ColorsManager.darkPrimaryColor,
          decoration: TextDecoration.underline,
          decorationColor: ColorsManager.darkPrimaryColor
        ),
      ),
    colorScheme: ColorScheme.dark(
      primary: ColorsManager.darkPrimaryColor,
      secondary: ColorsManager.darkSecondaryColor,
      tertiary: ColorsManager.darkTeritaryColor,
      onPrimary: ColorsManager.darkUnselected,
      onSecondary: ColorsManager.fieldBorderDark,
      onTertiary: ColorsManager.onPrimaryColor,
        onPrimaryContainer: ColorsManager.fieldBorderDark


    )
  );

  static String languageCode = "en";
}