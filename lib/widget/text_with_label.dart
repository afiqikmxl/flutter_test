import 'package:flutter/material.dart';

class TextWithLabel extends StatelessWidget {
  final String label;
  final String data;
  const TextWithLabel({super.key, required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text: data,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
