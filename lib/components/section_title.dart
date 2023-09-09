import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
  }
}