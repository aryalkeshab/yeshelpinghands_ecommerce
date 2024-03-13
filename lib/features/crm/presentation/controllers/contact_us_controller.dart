import 'package:flutter/material.dart';
import 'package:yeshelpinghand/core/data/data_source/remote/api_result.dart';
import 'package:yeshelpinghand/core/presentation/widgets/snackbar.dart';
import 'package:yeshelpinghand/features/crm/domain/repository/crm_repository.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsController extends GetxController {
  late CRMRepository _CRMRepository;
  get data => null;

  @override
  void onInit() {
    super.onInit();
  }

  ApiResponse _contactUsApiResponse = ApiResponse();

  set contactUsApiResponse(ApiResponse response) {
    _contactUsApiResponse = response;
    update();
  }

  ApiResponse get contactUsApiResponse => _contactUsApiResponse;

  getContactUsDetails(int id) async {
    contactUsApiResponse = await _CRMRepository.fetchCrmDetails(id);
  }

  Future<void> lauchPhone(String phoneNumber) async {
    final launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void launchEmail(BuildContext context, String emailAddress, String subject) async {
    final mail = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': subject,
      },
    );
    if (await canLaunchUrl(mail)) {
      await launchUrl(mail);
    } else {
      AppSnackbar.showError(context: context, message: "Unable to launch");
    }
  }

  void launchFacebook(BuildContext context) async {
    final facebookUrl = Uri.parse(
      "fb://facewebmodal/f?href=https://www.facebook.com/qmbhypermart/?_rdc=1&_rdr",
    );
    if (await canLaunchUrl(facebookUrl)) {
      await launchUrl(facebookUrl);
    } else {
      AppSnackbar.showError(context: context, message: "Unable to launch");
    }
  }

  void launchTwitter(BuildContext context) async {
    final fallBackTitterUrl = Uri.parse("https://twitter.com/QMBHypermart");
    final twitterUrl = Uri.parse("twitter://user?screen_name=QMBHypermart");

    if (await canLaunchUrl(twitterUrl)) {
      await launchUrl(
        twitterUrl,
      );
    } else {
      await launchUrl(
        fallBackTitterUrl,
      );
    }
  }

  void launchInstagram(BuildContext context) async {
    final fallbackInstagramUrl = Uri.parse("instagram://user?username=qmbhypermart");
    final instagramUrl = Uri.parse("https://www.instagram.com/qmbhypermart");

    if (await canLaunchUrl(instagramUrl)) {
      await launchUrl(
        instagramUrl,
      );
    } else {
      await launchUrl(
        fallbackInstagramUrl,
      );
    }
  }

  void launchTiktok(BuildContext context) async {
    final fallbackTikTokUrl = Uri.parse("tiktok://@qmbhypermart");
    final tiktokUrl = Uri.parse("https://www.tiktok.com/@qmbhypermart");

    if (await canLaunchUrl(tiktokUrl)) {
      await launchUrl(
        tiktokUrl,
      );
    } else {
      await launchUrl(
        fallbackTikTokUrl,
      );
    }
  }
}
