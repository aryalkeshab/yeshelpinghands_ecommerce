import 'package:yeshelpinghand/core/presentation/resources/ui_assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorView extends StatelessWidget {
  final String? title;

  const ErrorView({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(UIAssets.errorAnimation, width: 70),
          const SizedBox(height: 10),
          if (title != null)
            Text(
              "$title",
              style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.orange),
            )
        ],
      ),
    );
  }
}
