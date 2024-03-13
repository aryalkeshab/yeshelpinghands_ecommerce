import 'package:flutter/material.dart';
import '../../../../../core/presentation/widgets/base_widget.dart';
import '../../../data/model/response/filter_drawer_model.dart';

class StockFilter extends StatefulWidget {
  final Availability? availability;
  final Function(bool) onStockUpdate;
  final int selectedIndex;

  const StockFilter(
      {Key? key,
      required this.availability,
      required this.onStockUpdate,
      required this.selectedIndex})
      : super(key: key);

  @override
  State<StockFilter> createState() => _StockFilterState();
}

class _StockFilterState extends State<StockFilter> {
  final List<String> stockStatusList = [
    'IN STOCK',
    'OUT OF STOCK',
  ];
  int? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Stock Status",
            style: theme.textTheme.headline6?.copyWith(color: theme.primaryColor),
          ),
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: stockStatusList.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final stockStatus = stockStatusList[index];
                return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: theme.primaryColor,
                  title: Row(
                    children: [
                      Text(stockStatus),
                      config.horizontalSpaceSmall(),
                      CircleAvatar(
                          backgroundColor: theme.primaryColor,
                          maxRadius: 12,
                          child: Text(
                              "${index == 0 ? widget.availability?.inStock : widget.availability?.outOfStock}",
                              style: const TextStyle(color: Colors.white)))
                    ],
                  ),
                  onChanged: (bool? value) {
                    setState(() {
                      selectedValue = index;
                    });
                    widget.onStockUpdate(selectedValue == 0);
                  },
                  value: selectedValue == index,
                );
              }),
        ],
      );
    });
  }
}
