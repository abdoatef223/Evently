import 'package:evently_c19/core/resources/app_theme.dart';
import 'package:flutter/material.dart';

class LanguageSwitch extends StatelessWidget {
  String switchLanguage;
  LanguageSwitch(this.switchLanguage);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4
      ),
      decoration: BoxDecoration(
        border: switchLanguage==AppTheme.languageCode
            ?null
            :Border.all(
          color:Theme.of(context).colorScheme.onSecondary
        ),
        color: switchLanguage==AppTheme.languageCode
            ?Theme.of(context).colorScheme.primary
            :Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Text(switchLanguage=="ar"
          ?"العربية"
          :"English",style: switchLanguage==AppTheme.languageCode
          ?Theme.of(context).textTheme.displayMedium
          :Theme.of(context).textTheme.displaySmall,),
    );
  }
}
