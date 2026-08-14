import 'package:flutter/material.dart';

class SettingsBtn extends StatelessWidget {
  String title;
  Widget action;
  void Function()? onClick;
  SettingsBtn({required this.title,required this.action , this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onPrimaryContainer),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(title,style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,fontSize: 16
            )),
            Spacer(),
            action
          ],
        ),
      ),
    );
  }
}