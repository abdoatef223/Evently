import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c19/core/remote/network/firestore_manager.dart';
import 'package:evently_c19/core/resources/app_constants.dart';
import 'package:evently_c19/core/resources/dialog_utilis.dart';
import 'package:evently_c19/core/reusable_components/custom_btn.dart';
import 'package:evently_c19/core/reusable_components/custom_field.dart';
import 'package:evently_c19/model/event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/my_flutter_app_icons.dart';
import '../widgets/image_tab_view.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int selectedTab = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add event"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme
                  .of(context)
                  .colorScheme
                  .onPrimary,
              border: Border.all(
                color: Theme
                    .of(context)
                    .colorScheme
                    .onPrimaryContainer,
              ),
            ),
            child: SvgPicture.asset(
              AssetsManager.back,
              colorFilter: ColorFilter.mode(
                Theme
                    .of(context)
                    .colorScheme
                    .onTertiary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: DefaultTabController(
          length: 5,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  SizedBox(
                    height: screenHeight * 0.25,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ImageTabView(imagePath: AssetsManager.sport_light),
                        ImageTabView(imagePath: AssetsManager.birthday_light),
                        ImageTabView(imagePath: AssetsManager.book_light),
                        ImageTabView(imagePath: AssetsManager.exhibition_light),
                        ImageTabView(imagePath: AssetsManager.meeting_light),
                      ],
                    ),
                  ),
                  TabBar(
                    onTap: (value) {
                      selectedTab = value;
                    },
                    tabAlignment: TabAlignment.start,
                    dividerHeight: 0,
                    labelColor: Colors.white,
                    unselectedLabelColor: Theme
                        .of(
                      context,
                    )
                        .colorScheme
                        .secondary,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                              Icon(MyFlutterApp.bike, size: 24),

                              Text("sport"),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                              Icon(MyFlutterApp.birthday_icon, size: 24),

                              Text("birthday"),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                              Icon(MyFlutterApp.book, size: 24),

                              Text("book"),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                              Icon(MyFlutterApp.exhibition, size: 24),

                              Text("exhibition"),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                              Icon(MyFlutterApp.meeting, size: 24),

                              Text("meeting"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        "Title",
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      CustomField(
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return "Event title can't be empty";
                          }
                          return null;
                        },
                        controller: titleController,
                        hint: "Event Title",
                        keyboard: TextInputType.text,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        "Description",
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      CustomField(
                        maxLines: 5,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return "Event description can't be empty";
                          }
                          return null;
                        },
                        controller: descController,
                        hint: "Event Description",
                        keyboard: TextInputType.text,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetsManager.date,
                        colorFilter: ColorFilter.mode(
                          Theme
                              .of(context)
                              .colorScheme
                              .primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 8,),
                      Text("Event Date", style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),),
                      Spacer(),
                      InkWell(
                          onTap: () {
                            chooseDate();
                          },
                          child: Text(selectionDate != null
                              ? DateFormat.yMMMd().format(selectionDate!)
                              : "Choose Date", style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                              fontWeight: FontWeight.w400
                          ),))
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetsManager.time,
                        colorFilter: ColorFilter.mode(
                          Theme
                              .of(context)
                              .colorScheme
                              .primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 8,),
                      Text("Event Time", style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),),
                      Spacer(),
                      InkWell(
                          onTap: () {
                            chooseTime();
                          },
                          child: Text(selectionTime != null
                              ? selectionTime!.format(context)
                              : "Choose Time", style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                              fontWeight: FontWeight.w400
                          ),))
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: CustomBtn(title: "Add Event", onClick: () {
                      if (formKey.currentState?.validate() ?? false) {
                        if (selectionDate != null && selectionTime != null) {
                          addNewEvent();
                        } else {
                          DialogUtils.showSnackbar(context, "Event date and time are required");
                        }
                      }
                    },),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime? selectionDate;

  Future<void> chooseDate() async {
    var newDate = await showDatePicker(
        context: context,
        initialDate: selectionDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365))
    );
    if (newDate != null) {
      setState(() {
        selectionDate = newDate;
      });
    }
  }

  TimeOfDay? selectionTime;

  Future<void> chooseTime() async {
    var newTime = await showTimePicker(
        context: context,
        initialTime: selectionTime ?? TimeOfDay.now()
    );
    if (newTime != null) {
      setState(() {
        selectionTime = newTime;
      });
    }
  }

  Future<void> addNewEvent() async{
    DateTime eventDate = DateTime(
        selectionDate!.year, selectionDate!.month, selectionDate!.day,
        selectionTime!.hour, selectionTime!.minute);
    DialogUtils.showLoadingDialog(context);
    await FirestoreManager.addEvent(Event(
      title: titleController.text,
      description: descController.text,
      type: AppConstants.eventTypes[selectedTab],
      userId: FirebaseAuth.instance.currentUser!.uid,
      dateTime: Timestamp.fromDate(eventDate),
    ));
    Navigator.of(context).pop();
    DialogUtils.showSnackbar(context, "Event added successfully");

  }
}