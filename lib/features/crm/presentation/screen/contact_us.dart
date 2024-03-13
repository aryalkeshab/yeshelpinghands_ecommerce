import 'package:yeshelpinghand/core/presentation/resources/colors.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:yeshelpinghand/features/crm/presentation/controllers/contact_us_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeshelpinghand/features/profile/presentation/controller/profile_controller.dart';
import '../../../../core/presentation/resources/ui_assets.dart';
import '../../../../core/presentation/widgets/clipper.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (profileController) {
          final result = Get.find<ProfileController>().userInfoResponse;
          final user = result.data;
          return BaseWidget(builder: (context, config, theme) {
            return Scaffold(
                body: Padding(
              padding: EdgeInsets.only(bottom: config.appHeight(7)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          ClipPath(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.45,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: pasminaColor,
                              ),
                              child: Image.asset(
                                UIAssets.app_Icon,
                                width: config.appWidth(50),
                              ),
                            ),
                            clipper: Clipper(),
                          ),
                          Positioned(
                            top: 30,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: Get.back,
                            ),
                          )
                        ],
                      ),
                      config.verticalSpaceMedium(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: config.appVerticalPaddingMedium()),
                            child: Column(
                              children: [
                                ContactDetailsWidget(
                                    iconData: Icons.location_on,
                                    title: 'Yes Handing Hand, Lakeside, Pokhara',
                                    onPressed: () async {}),
                                config.verticalSpaceMedium(),
                                const Divider(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                config.verticalSpaceMedium(),
                                ContactDetailsWidget(
                                    iconData: Icons.phone_android,
                                    title: '+977 982788090',
                                    onPressed: () {
                                      Get.find<ContactUsController>().lauchPhone('+977 982788090');
                                    }),
                                config.verticalSpaceMedium(),
                                const Divider(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                config.verticalSpaceMedium(),
                                ContactDetailsWidget(
                                    iconData: Icons.mail,
                                    title: 'yeshelpinghands@gmail.com',
                                    onPressed: () {
                                      Get.find<ContactUsController>().launchEmail(
                                          context,
                                          'yeshelpinghands@gmail.com',
                                          'Enquiry-${user?.firstname ?? ''}');
                                    }),
                                config.verticalSpaceMedium(),
                                const Divider(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                config.verticalSpaceMedium(),
                                ContactDetailsWidget(
                                    iconData: Icons.punch_clock,
                                    title: 'Week 7 days from 7:00 to 20:00',
                                    onPressed: () {}),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
          });
        });
  }
}

class ContactDetailsWidget extends StatelessWidget {
  const ContactDetailsWidget(
      {Key? key, required this.iconData, required this.title, required this.onPressed})
      : super(key: key);

  final IconData iconData;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, config, theme) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: config.appHorizontalPadding(2), vertical: config.appVerticalPadding(0.2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(iconData, color: Theme.of(context).primaryColor),
            config.horizontalSpaceSmall(),
            InkWell(
              onTap: onPressed,
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class QMBSocialMedia extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const QMBSocialMedia({Key? key, required this.icon, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.25), borderRadius: BorderRadius.circular(5)),
      child: IconButton(
          padding: const EdgeInsets.all(10),
          visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity, vertical: VisualDensity.minimumDensity),
          iconSize: 20,
          onPressed: onTap,
          icon: Icon(icon)),
    );
  }
}
