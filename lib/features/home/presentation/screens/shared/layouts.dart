import 'package:flutter/material.dart';
import 'package:yeshelpinghand/core/presentation/resources/colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? textButtonTitle;
  final bool showViewAll;
  final VoidCallback onViewAllProductTap;

  const SectionHeader({
    this.showViewAll = true,
    required this.title,
    required this.onViewAllProductTap,
    this.textButtonTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.only(left: 10),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Theme.of(context).colorScheme.primary),
      //   borderRadius: BorderRadius.circular(3),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16),
          ),
          Text(
            "See All >",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          // if (showViewAll)
          //   InkWell(
          //     onTap: onViewAllProductTap,
          //     child: Container(
          //       width: 35,
          //       height: double.maxFinite,
          //       decoration: BoxDecoration(
          //         color: Theme.of(context).colorScheme.primary,
          //       ),
          //       child: const Icon(Icons.keyboard_arrow_right),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
