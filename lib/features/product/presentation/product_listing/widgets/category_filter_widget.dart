import 'package:flutter/material.dart';
import '../../../../../core/presentation/widgets/base_widget.dart';
import '../../../data/model/response/filter_drawer_model.dart';

class CategoryFilterWidget extends StatefulWidget {
  final List<FilterSubCategory>? subCategoryList;
  final int? initialCategory;
  final Function(FilterSubCategory) onCategorySelect;

  CategoryFilterWidget(this.subCategoryList,
      {Key? key, required this.onCategorySelect, required this.initialCategory})
      : super(key: key);

  @override
  State<CategoryFilterWidget> createState() => _CategoryFilterWidgetState();
}

class _CategoryFilterWidgetState extends State<CategoryFilterWidget> {
  @override
  void initState() {
    super.initState();

    selectedValue = widget.subCategoryList
        ?.indexWhere((element) => element.id == widget.initialCategory.toString());
  }

  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      builder: (context, config, theme) {
        final subCategoryList = widget.subCategoryList;

        return subCategoryList?.isNotEmpty == true
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category",
                    style: theme.textTheme.headline6?.copyWith(color: theme.primaryColor),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: subCategoryList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final subCategory = subCategoryList![index];
                        return CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: theme.primaryColor,
                          title: Text("${subCategory.name}"),
                          onChanged: (bool? value) {
                            setState(() {
                              selectedValue = index;
                            });
                            widget.onCategorySelect(subCategoryList[selectedValue ?? -1]);
                          },
                          value: selectedValue == index,
                        );
                      }),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }
}
