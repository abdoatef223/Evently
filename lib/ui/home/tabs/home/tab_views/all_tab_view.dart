import 'package:evently_c19/core/remote/network/firestore_manager.dart';
import 'package:evently_c19/core/reusable_components/event_item.dart';
import 'package:flutter/material.dart';

import '../../../../../model/event.dart';

class AllTabView extends StatefulWidget {
  const AllTabView({super.key});

  @override
  State<AllTabView> createState() => _AllTabViewState();
}

class _AllTabViewState extends State<AllTabView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreManager.getAllEventsRealTime(),
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