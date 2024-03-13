import 'package:flutter/material.dart';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16),
          ),
          showViewAll
              ? InkWell(
                  onTap: onViewAllProductTap,
                  child: Text(
                    "See all",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
