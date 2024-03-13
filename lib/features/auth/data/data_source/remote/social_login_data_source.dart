// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../core/data/data_source/remote/api_client.dart';

abstract class SocialLoginDataSource {
  Future<dynamic> loginWithGoogle();

  Future<dynamic> loginWithFacebook();
  Future<dynamic> facebookSignOut();
  Future<dynamic> googleSignOut();
}

class SocialLoginDataSourceImpl implements SocialLoginDataSource {
  final ApiClient apiClient;

  SocialLoginDataSourceImpl({required this.apiClient});

  @override
  Future loginWithGoogle() async {
    // final _googleSignIn = GoogleSignIn();
    // // await _googleSignIn.signOut();
    // final googleAccount = await _googleSignIn.signIn();
    // if (googleAccount != null) {
    //   final displayName = googleAccount.displayName?.split(" ");

    //   final firstName = displayName?[0];
    //   final lastName = displayName?[1];

    //   final result = await apiClient.post(
    //       APIPathHelper.authAPIs(APIPath.loginWithSocialMedia),
    //       queryParameters: {
    //         "email": "${googleAccount.email}",
    //         "type": "Google",
    //         "id_token": "${googleAccount.id}"
    //       },
    //       data: {
    //         "firstname": "$firstName",
    //         "lastname": "$lastName",
    //         "phoneno": ""
    //       });
    //   return result;
    // } else {
    //   throw SocialLoginException("Cancelled by user");
    // }
  }

  @override
  Future loginWithFacebook() async {
    // final loginResult = await FacebookAuth.instance.login();
    // if (loginResult.status == LoginStatus.success) {
    //   final userData = await FacebookAuth.instance.getUserData();
    //   final name = userData['name'].split(" ");
    //   final firstName = name[0];
    //   final lastName = name[1];
    //   final result = await apiClient.post(
    //       APIPathHelper.authAPIs(APIPath.loginWithSocialMedia),
    //       queryParameters: {
    //         "email": "${userData['email']}",
    //         "type": "Facebook",
    //         "id_token": "${loginResult.accessToken?.userId}"
    //       },
    //       data: {
    //         "firstname": "$firstName",
    //         "lastname": "$lastName",
    //         "phoneno": ""
    //       });

    //   return result;
    // }
  }

  @override
  Future facebookSignOut() async {
    // await FacebookAuth.instance.logOut();
  }

  @override
  Future googleSignOut() async {
    // await GoogleSignIn().signOut();
  }
}

class SocialLoginException implements Exception {
  String message;

  SocialLoginException(this.message);
}
