import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/features/crm/presentation/controllers/contact_us_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/features/crm/presentation/controllers/help_faqs_controller.dart';
import '../../../../core/data/data_source/remote/network_exception.dart';
import '../../../shared/layouts/error_view.dart';

class HelpFaqsScreen extends StatelessWidget {
  HelpFaqsScreen();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpFaqsController>(
        init: HelpFaqsController(),
        builder: (context) {
          return BaseWidget(builder: (context, config, theme) {
            final result =
                Get.find<HelpFaqsController>().helpAndFaqsApiResponse;
            print(result);

            return Scaffold(
                appBar: AppBar(
                  title: const Text('Help & FAQs'),
                ),
                body: Builder(builder: (context) {
                  if (result.hasData) {
                    return SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      // child: Html(data: result.data.content),
                    ));
                  } else if (result.hasError) {
                    return ErrorView(
                        title: NetworkException.getErrorMessage(result.error));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }));
          });
        });
  }
}
