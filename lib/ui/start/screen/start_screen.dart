import 'package:evently_c19/core/resources/app_theme.dart';
import 'package:evently_c19/core/resources/assets_manager.dart';
import 'package:evently_c19/core/resources/colors_manager.dart';
import 'package:evently_c19/core/resources/strings_manager.dart';
import 'package:evently_c19/core/reusable_components/custom_btn.dart';
import 'package:evently_c19/providers/theme_provider.dart';
import 'package:evently_c19/ui/start/widgets/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/language_switch.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AssetsManager.logo,
          height: 27,
          fit: BoxFit.fitHeight,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Image.asset(AssetsManager.beingCreative,
              color: Theme.of(context).colorScheme.onTertiary,fit: BoxFit.fitHeight,)),
            SizedBox(height: 24,),
            Text(StringsManager.startTitle,style: Theme.of(context).textTheme.titleMedium,),
            SizedBox(height: 8,),
            Text(StringsManager.startDesc,style: Theme.of(context).textTheme.bodyMedium,),
            SizedBox(height: 16,),
            Row(children: [
              Text(StringsManager.language,style: Theme.of(context).textTheme.titleSmall,),
              Spacer(),
              LanguageSwitch("en"),
              SizedBox(width: 8,),
              LanguageSwitch("ar"),
            ],),
            SizedBox(height: 16,),
            Row(children: [
              Text(StringsManager.theme,style: Theme.of(context).textTheme.titleSmall,),
              Spacer(),
              ThemeSwitch(ThemeMode.light,(){
                themeProvider.changeTheme(ThemeMode.light);
              }),
              SizedBox(width: 8,),
              ThemeSwitch(ThemeMode.dark,(){
                themeProvider.changeTheme(ThemeMode.dark);


              }),
            ],),
            SizedBox(height: 24,),
            Container(
                width: double.infinity,
                child: CustomBtn(title: StringsManager.letsStart, onClick: (){}))
          ],
        ),
      )
    );
  }
}
