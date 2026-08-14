import 'package:flutter/material.dart';

import '../../../../../core/remote/network/firestore_manager.dart';
import '../../../../../core/resources/app_constants.dart';
import '../../../../../core/reusable_components/event_item.dart';
import '../../../../../model/event.dart';

class BookeTabView extends StatefulWidget {
  const BookeTabView({super.key});

  @override
  State<BookeTabView> createState() => _BookeTabViewState();
}

class _BookeTabViewState extends State<BookeTabView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreManager.getFilteredEvents(AppConstants.eventTypes[2]),
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
          itemBuilder: (context, index) => EventItem(eventsList[index]),
          separatorBuilder: (context, index) => SizedBox(height: 16),
          itemCount: eventsList.length,
        );
      },
    );
  }
}