import 'package:evently_c19/core/resources/assets_manager.dart';
import 'package:evently_c19/core/reusable_components/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/remote/network/firestore_manager.dart';
import '../../../../core/reusable_components/event_item.dart';
import '../../../../model/event.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  late TextEditingController searchController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [
            CustomField(
              validation: (value) {
                return null;
              },
              suffix: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AssetsManager.search,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              controller: searchController,
              hint: "search",
              keyboard: TextInputType.text,
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirestoreManager.getFavoritesList(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    // loading case
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if(snapshot.hasError){
                    return Column(
                      children: [
                        Text(snapshot.error.toString()),
                        ElevatedButton(onPressed: () {
                          setState(() {

                          });
                        }, child: Text("Try again"))
                      ],
                    );
                  }
                  List<Event> eventsList = snapshot.data??[];
                  if(eventsList.isEmpty){
                    return Center(child: Text("No Events Found"),);
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) => EventItem(eventsList[index],isFavorite: true,),
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemCount: eventsList.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}