import 'package:flutter/material.dart';

import '../../../core/presentation/widgets/base_widget.dart';

class RemoveButton extends StatelessWidget {
  final VoidCallback onRemove;

  const RemoveButton({
    Key? key,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return InkWell(
        onTap: onRemove,
        child: Row(
          children: [
            Container(
                child: Icon(Icons.delete_outline, color: Colors.black.withOpacity(0.3), size: 18),
                decoration: BoxDecoration(
                  color: Theme.of(context).disabledColor.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(3),
                ),
                padding: const EdgeInsets.all(1.5)),
            config.horizontalSpaceSmall(),
            Text(
              'Remove',
              style: theme.textTheme.caption,
            ),
          ],
        ),
      );
    });
  }
}
