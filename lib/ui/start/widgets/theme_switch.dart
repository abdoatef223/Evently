import 'package:evently_c19/core/resources/assets_manager.dart';
import 'package:evently_c19/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/app_theme.dart';

class ThemeSwitch extends StatelessWidget {
  ThemeMode themeMode;
  void Function() onClick;
  ThemeSwitch(this.themeMode,this.onClick);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4
        ),
        decoration: BoxDecoration(
            border: themeMode==themeProvider.selectedTheme
                ?null
                :Border.all(
                color:Theme.of(context).colorScheme.onSecondary
            ),
            color: themeMode==themeProvider.selectedTheme
                ?Theme.of(context).colorScheme.primary
                :Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(8)
        ),
        child: SvgPicture.asset(themeMode == ThemeMode.dark
            ?themeMode==themeProvider.selectedTheme?AssetsManager.moonSelected:AssetsManager.moon
            :themeMode==themeProvider.selectedTheme?AssetsManager.sunSelected:AssetsManager.sun),
      ),
    );
  }
}
