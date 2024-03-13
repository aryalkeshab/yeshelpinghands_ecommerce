import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/features/crm/presentation/controllers/terms_and_conditions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/data/data_source/remote/network_exception.dart';
import '../../../shared/layouts/error_view.dart';

class TermsAndConditionScreen extends StatefulWidget {
  TermsAndConditionScreen();

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TermsAndConditionsController>(
        init: TermsAndConditionsController(),
        builder: (context) {
          return BaseWidget(builder: (context, config, theme) {
            final result = Get.find<TermsAndConditionsController>().termsAndConditionsApiResponse;

            return Scaffold(
                appBar: AppBar(
                  title: const Text('Terms And Conditions'),
                ),
                body: Builder(builder: (context) {
                  if (result.hasData) {
                    return SingleChildScrollView(
                        child: Padding(padding: const EdgeInsets.all(8.0), child: Container()));
                  } else if (result.hasError) {
                    return ErrorView(title: NetworkException.getErrorMessage(result.error));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }));
          });
        });
  }
}
