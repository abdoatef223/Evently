import 'package:evently_c19/core/resources/assets_manager.dart';
import 'package:evently_c19/core/resources/routes_manager.dart';
import 'package:evently_c19/core/resources/strings_manager.dart';
import 'package:evently_c19/providers/theme_provider.dart';
import 'package:evently_c19/providers/user_provider.dart';
import 'package:evently_c19/ui/home/tabs/profile/widgets/settings_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/resources/dialog_utilis.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 52,
              backgroundImage: AssetImage(AssetsManager.route),
            ),
            SizedBox(height: 16,),
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                if(userProvider.user==null){
                  return Center(child: CircularProgressIndicator(),);
                }
                return Text(userProvider.user?.name??"", style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                    fontWeight: FontWeight.w600, fontSize: 20
                ),);
              },
            ),
            Text(FirebaseAuth.instance.currentUser!.email??"", style: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                fontSize: 14
            ),),
            SizedBox(height: 24,),
            Column(
              spacing: 32,
              children: [
                SettingsBtn(title: "Dark Mode", action:Switch(
                  value: themeProvider.selectedTheme == ThemeMode.dark,

                  onChanged: (value) {
                    if(value){
                      themeProvider.changeTheme(ThemeMode.dark);
                    }else{
                      themeProvider.changeTheme(ThemeMode.light);

                    }
                  },
                )
                ),
                SettingsBtn(title: StringsManager.language,
                    onClick: () {

                    },
                    action: SvgPicture.asset(AssetsManager.arrowRight)),
                SettingsBtn(title: "Logout",
                    onClick: () async{
                      try{
                        DialogUtils.showLoadingDialog(context);
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pop();
                        Navigator.pushReplacementNamed(context, RoutesManager.loginRouteName);
                      }catch(e){
                        Navigator.of(context).pop();
                        DialogUtils.showMessageDialog(context: context,
                          content: e.toString(),
                          actionTitle: "Ok",
                          actionPress: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                    action: SvgPicture.asset(AssetsManager.logout)),
              ],)
          ],
        ),
      ),
    );
  }
}