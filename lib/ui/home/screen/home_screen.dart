import 'package:evently_c19/core/resources/assets_manager.dart';
import 'package:evently_c19/core/resources/routes_manager.dart';
import 'package:evently_c19/core/resources/strings_manager.dart';
import 'package:evently_c19/ui/home/tabs/favorite/favorite_tab.dart';
import 'package:evently_c19/ui/home/tabs/home/home_tab.dart';
import 'package:evently_c19/ui/home/tabs/profile/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [HomeTab(),FavoriteTab(),ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(RoutesManager.addEventRouteName);
          },
          shape:CircleBorder(),
          child: Icon(Icons.add),
      ) ,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        selectedIndex: selectedIndex,
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(AssetsManager.home),
            selectedIcon: SvgPicture.asset(
              AssetsManager.home_selected,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            label: StringsManager.home,
          ),
          NavigationDestination(
            icon: SvgPicture.asset(AssetsManager.heart),
            selectedIcon: SvgPicture.asset(
              AssetsManager.heart_selected,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            label: StringsManager.favorite,
          ),
          NavigationDestination(
            icon: SvgPicture.asset(AssetsManager.profile),
            selectedIcon: SvgPicture.asset(
              AssetsManager.profile_selected,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            label: StringsManager.profile,
          ),
        ],
      ),
      body:tabs[selectedIndex] ,
    );
  }
}
