import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c19/core/remote/network/firestore_manager.dart';
import 'package:evently_c19/core/resources/app_constants.dart';
import 'package:evently_c19/core/resources/assets_manager.dart';
import 'package:evently_c19/core/resources/dialog_utilis.dart';
import 'package:evently_c19/core/resources/my_flutter_app_icons.dart';
import 'package:evently_c19/core/reusable_components/custom_btn.dart';
import 'package:evently_c19/core/reusable_components/custom_field.dart';
import 'package:evently_c19/model/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class EditEvent extends StatefulWidget {
  final Event event;
  const EditEvent({super.key, required this.event});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  late TextEditingController titleController;
  late TextEditingController descController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late int selectedTab;
  DateTime? selectionDate;
  TimeOfDay? selectionTime;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.event.title);
    descController = TextEditingController(text: widget.event.description);

    // Pre-select the current type tab
    selectedTab = AppConstants.eventTypes.indexOf(widget.event.type ?? 'sport');
    if (selectedTab < 0) selectedTab = 0;

    // Pre-fill date and time from existing event
    final existing = (widget.event.dateTime as Timestamp?)?.toDate();
    if (existing != null) {
      selectionDate = existing;
      selectionTime = TimeOfDay.fromDateTime(existing);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  String get _imagePath {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark
        ? AppConstants.darkEventTypeImage[AppConstants.eventTypes[selectedTab]]!
        : AppConstants.lightEventTypeImage[AppConstants.eventTypes[selectedTab]]!;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit event"),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.onPrimary,
              border: Border.all(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            child: SvgPicture.asset(
              AssetsManager.back,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onTertiary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: DefaultTabController(
          length: 5,
          initialIndex: selectedTab,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  // Event image (updates with selected tab)
                  SizedBox(
                    height: screenHeight * 0.25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(_imagePath, fit: BoxFit.cover),
                    ),
                  ),

                  // Type tabs
                  TabBar(
                    onTap: (value) => setState(() => selectedTab = value),
                    tabAlignment: TabAlignment.start,
                    dividerHeight: 0,
                    labelColor: Colors.white,
                    unselectedLabelColor:
                    Theme.of(context).colorScheme.secondary,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    tabs: [
                      _buildTab(MyFlutterApp.bike, "Sport"),
                      _buildTab(MyFlutterApp.birthday_icon, "Birthday"),
                      _buildTab(MyFlutterApp.book, "Book club"),
                      _buildTab(MyFlutterApp.exhibition, "Exhibition"),
                      _buildTab(MyFlutterApp.meeting, "Meeting"),
                    ],
                  ),

                  // Title
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        "Title",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

                  // Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

                  // Date row
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetsManager.date,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Event Date",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: chooseDate,
                        child: Text(
                          selectionDate != null
                              ? DateFormat.yMMMd().format(selectionDate!)
                              : "Choose Date",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),

                  // Time row
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetsManager.time,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Event Time",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: chooseTime,
                        child: Text(
                          selectionTime != null
                              ? selectionTime!.format(context)
                              : "Choose Time",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),

                  // Update button
                  SizedBox(
                    width: double.infinity,
                    child: CustomBtn(
                      title: "Update event",
                      onClick: () {
                        if (formKey.currentState?.validate() ?? false) {
                          if (selectionDate != null && selectionTime != null) {
                            updateEvent();
                          } else {
                            DialogUtils.showSnackbar(
                                context, "Event date and time are required");
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(IconData icon, String label) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Row(
          spacing: 8,
          children: [
            Icon(icon, size: 24),
            Text(label),
          ],
        ),
      ),
    );
  }

  Future<void> chooseDate() async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: selectionDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (newDate != null) setState(() => selectionDate = newDate);
  }

  Future<void> chooseTime() async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: selectionTime ?? TimeOfDay.now(),
    );
    if (newTime != null) setState(() => selectionTime = newTime);
  }

  Future<void> updateEvent() async {
    final DateTime eventDate = DateTime(
      selectionDate!.year, selectionDate!.month, selectionDate!.day,
      selectionTime!.hour, selectionTime!.minute,
    );
    DialogUtils.showLoadingDialog(context);
    widget.event
      ..title = titleController.text
      ..description = descController.text
      ..type = AppConstants.eventTypes[selectedTab]
      ..dateTime = Timestamp.fromDate(eventDate);
    await FirestoreManager.updateEvent(widget.event);
    if (!mounted) return;
    Navigator.of(context).pop(); // dismiss loading
    Navigator.of(context).pop(); // back to details
    DialogUtils.showSnackbar(context, "Event updated successfully");
  }
}