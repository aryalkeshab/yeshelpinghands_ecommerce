import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/base_widget.dart';

class WarningMessage extends StatelessWidget {
  final String message;

  const WarningMessage(
      this.message, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.orangeAccent,
          ),
          config.horizontalSpaceSmall(),
          Flexible(
            child: Text(message,
                style: theme.textTheme.caption
                    ?.copyWith(color: Colors.orangeAccent)),
          ),
        ],
      );
    });
  }
}
