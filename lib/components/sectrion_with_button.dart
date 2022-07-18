import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';

class SectionWithButton extends StatelessWidget {
  const SectionWithButton({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: sectionText,
          ),
          GestureDetector(
            onTap: () {
              print('See all');
            },
            child: const Text(
              "See all",
              style: seeAllText,
            ),
          )
        ],
      ),
    );
  }
}