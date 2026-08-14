import 'package:evently_c19/core/resources/assets_manager.dart';
import 'package:evently_c19/core/resources/my_flutter_app_icons.dart';
import 'package:evently_c19/core/resources/strings_manager.dart';
import 'package:evently_c19/providers/user_provider.dart';
import 'package:evently_c19/ui/home/tabs/home/tab_views/all_tab_view.dart';
import 'package:evently_c19/ui/home/tabs/home/tab_views/birthday_tab_view.dart';
import 'package:evently_c19/ui/home/tabs/home/tab_views/booke_tab_view.dart';
import 'package:evently_c19/ui/home/tabs/home/tab_views/exhibition_tab_view.dart';
import 'package:evently_c19/ui/home/tabs/home/tab_views/meeting_tab_view.dart';
import 'package:evently_c19/ui/home/tabs/home/tab_views/sport_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
        child: DefaultTabController(
          length: 6,
          child: Column(
            spacing: 24,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(
                        StringsManager.welcomeBack,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(fontSize: 14),
                      ),
                      Consumer<UserProvider>(
                        builder: (context, userProvider, child) {
                          if(userProvider.user==null){
                            return Center(child: CircularProgressIndicator(),);
                          }
                          return Text(
                            userProvider.user?.name ?? "",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              TabBar(
                dividerHeight: 0,
                unselectedLabelColor: Theme.of(context).colorScheme.primary,
                labelColor: Colors.white,
                labelPadding: EdgeInsets.zero,
                indicator: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                tabAlignment: TabAlignment.start,
                padding: EdgeInsets.zero,
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        spacing: 8,
                        children: [Icon(MyFlutterApp.all), Text("All")],
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        spacing: 8,
                        children: [Icon(MyFlutterApp.bike), Text("Sport")],
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        spacing: 8,
                        children: [
                          Icon(MyFlutterApp.birthday_icon),
                          Text("Birthday"),
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        spacing: 8,
                        children: [Icon(MyFlutterApp.book), Text("Book")],
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        spacing: 8,
                        children: [Icon(MyFlutterApp.meeting), Text("Meeting")],
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        spacing: 8,
                        children: [
                          Icon(MyFlutterApp.exhibition),
                          Text("Exhibition"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    AllTabView(),
                    SportTabView(),
                    BirthdayTabView(),
                    BookeTabView(),
                    MeetingTabView(),
                    ExhibitionTabView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}