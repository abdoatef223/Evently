import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  String title;
  void Function() onClick;
  Widget? icon;
  bool outlined;

  CustomBtn({
    required this.title,
    required this.onClick,
    this.icon,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = outlined
        ? Theme.of(context).colorScheme.onSurface
        : null; // filled button keeps its existing labelMedium color

    final label = icon == null
        ? Text(
      title,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: textColor),
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon!,
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: textColor),
        ),
      ],
    );

    if (outlined) {
      return OutlinedButton(
        onPressed: onClick,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Theme.of(context).colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: label,
      );
    }

    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
          )
      ),
      child: label,
    );
  }
}