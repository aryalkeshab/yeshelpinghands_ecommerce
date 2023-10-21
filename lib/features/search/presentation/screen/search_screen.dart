import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
// import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../../product/data/model/request/filter_query_params.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HookBaseWidget(builder: (context, config, theme) {
      final _controller = useMemoized(FloatingSearchBarController.new);
      return Scaffold(
        body: FloatingSearchAppBar(
          elevation: 1,
          alwaysOpened: true,
          hint: "Keyword here...",
          hintStyle: Theme.of(context).textTheme.bodyText2,
          controller: _controller,
          onSubmitted: (query) {
            Get.offAndToNamed(Routes.productListingScreen,
                arguments: FilterQueryParams(searchQuery: query));
          },
          color: Colors.white,
          colorOnScroll: Colors.white,
          actions: [
            FloatingSearchBarAction.icon(
              icon: const Icon(
                CupertinoIcons.search,
                size: 20,
              ),
              onTap: () {
                Get.offAndToNamed(Routes.productListingScreen,
                    arguments:
                        FilterQueryParams(searchQuery: _controller.query));
              },
              showIfOpened: true,
              showIfClosed: false,
            ),
          ],
          body: const Center(
            child: Text('Start searching...'),
          ),
        ),
      );
    });
  }
}
