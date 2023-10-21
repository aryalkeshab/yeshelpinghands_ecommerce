import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/features/categories/data/models/response/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/utils/string_capitalize.dart';

class CategoryVerticalTabs extends StatelessWidget {
  final Function(int, int) onVerticalTabSelected;

  final List<Category> categoryList;

  const CategoryVerticalTabs({
    Key? key,
    required this.onVerticalTabSelected,
    required this.categoryList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HookBaseWidget(builder: (context, config, theme) {
      final selectedTab = useState(0);
      return Container(
        margin:
            EdgeInsets.symmetric(vertical: config.appVerticalPaddingSmall()),
        color: Colors.grey.withOpacity(0.2),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 3.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                categoryList.length,
                (index) {
                  final category = categoryList[index];
                  return InkWell(
                    onTap: () {
                      selectedTab.value = index;
                      onVerticalTabSelected(index, 0);
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width,
                      color: selectedTab.value == index
                          ? theme.scaffoldBackgroundColor
                          : Colors.transparent,
                      margin: EdgeInsets.only(
                          bottom: config.appVerticalPaddingMedium()),
                      padding: EdgeInsets.only(
                        top: config.appVerticalPaddingSmall(),
                        left: config.appEdgePadding(),
                        bottom: config.appVerticalPaddingSmall(),
                      ),
                      child: Text(
                        StringCapitalize.capitalizeSentence("${category.name}"),
                        style: theme.textTheme.caption?.copyWith(
                          color: selectedTab.value == index
                              ? theme.primaryColor
                              : theme.textTheme.bodyText2?.color,
                          fontWeight: selectedTab.value == index
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
