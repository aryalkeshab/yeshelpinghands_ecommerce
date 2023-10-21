import 'package:yeshelpinghand/core/presentation/resources/ui_assets.dart';
import 'package:yeshelpinghand/core/presentation/routes/app_pages.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/widgets/buttons.dart';
import '../../controllers/language_controller.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LanguageController languageController = Get.put(LanguageController());
    return Scaffold(
      body: BaseWidget(builder: (context, config, theme) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: config.appEdgePadding(),
                vertical: config.appVerticalPadding(15)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: PrimaryTextButton(
                    label: "Skip",
                    onPressed: () {
                      Get.toNamed(Routes.dashboard);
                    },
                  ),
                ),
                config.verticalSpaceSmall(),
                Image.asset(
                  UIAssets.getImage("language-img.png"),
                  filterQuality: FilterQuality.high,
                  height: 100,
                  width: 110,
                  color: Theme.of(context).primaryColor,
                ),
                config.verticalSpaceMedium(),
                const LanguageSelectionView()
              ],
            ),
          ),
        );
      }),
    );
  }
}

class LanguageSelectionView extends StatelessWidget {
  const LanguageSelectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languages = Get.find<LanguageController>().languages;
    return BaseWidget(builder: (context, config, theme) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'cLanguage'.tr,
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          config.verticalSpaceSmall(),
          Text(
            'tLanguage'.tr,
            textAlign: TextAlign.start,

            // style: TextStyle(
            //   fontSize: 17.sp,
            // ),
          ),
          config.verticalSpaceLarge(),
          GetBuilder<LanguageController>(builder: (context) {
            return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LanguageTile(
                        onSelect: (languageId) {
                          Get.find<LanguageController>().selectedLanguageId =
                              languageId;
                        },
                        isSelected:
                            Get.find<LanguageController>().selectedLanguageId ==
                                index,
                        language: language,
                      ),
                      config.verticalSpaceMedium(),
                      const Divider(),
                    ],
                  );
                });
          }),
          config.verticalSpaceLarge(),
          PrimaryButton(
              label: "Continue",
              onPressed: () {
                Get.find<LanguageController>().confirmLanguage();
                Get.offAllNamed(Routes.dashboard);
              }),
        ],
      );
    });
  }
}

class LanguageTile extends HookWidget {
  final bool isSelected;
  final Language language;
  final Function(int) onSelect;

  const LanguageTile({
    Key? key,
    required this.language,
    required this.onSelect,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final isSelected = useState(false);
    return ListTile(
      onTap: () {
        // isSelected.value= true;
        onSelect(language.id);
      },
      contentPadding: EdgeInsets.zero,
      title: Text(language.title),
      leading: Image.asset(language.image, width: 50),
      trailing: isSelected
          ? const Icon(
              Icons.check,
              color: Colors.green,
            )
          : const SizedBox.shrink(),
    );
  }
}
