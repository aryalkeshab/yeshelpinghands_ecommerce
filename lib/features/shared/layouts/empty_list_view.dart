import 'package:yeshelpinghand/core/presentation/resources/ui_assets.dart';
import 'package:yeshelpinghand/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyListView extends StatelessWidget {
  final String? title;

  const EmptyListView({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig(context);
    return Center(
      child: Column(
        children: [
          Image.asset(UIAssets.noItemFound, width: 200),
          config.verticalSpaceMedium(),
          if (title != null)
            Text(
              "$title",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),
        ],
      ),
    );
  }
}
