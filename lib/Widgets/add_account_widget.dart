import 'package:flutter/material.dart';

class RowBuilder extends StatelessWidget {
  final String? title;
  final String? lableTitle;
  final TextInputType? keyboardType;
  final TextEditingController? textController;
  final Color? txtFieldColor;

  // ignore: use_key_in_widget_constructors
  const RowBuilder({
    required this.title,
    required this.lableTitle,
    required this.keyboardType,
    required this.textController,
    this.txtFieldColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title!)),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: txtFieldColor,
              border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.copyWith().secondary),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: textController,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                label: Text(lableTitle!),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
