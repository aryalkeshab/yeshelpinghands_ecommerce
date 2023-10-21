class UIAssets {
  static const String imageDir = "assets/images";
  static const String gifDir = "assets/gif";
  static const String svgDir = "assets/svg";
  static const String animDir = "assets/anim";
  static const String flareDir = "assets/flares";

  static const String appLogo = "$imageDir/logo.png";
  static const String appLongLogo = "$imageDir/long-logo.png";

  static const String placeHolderImage = "$imageDir/image-load-error.png";
  static const String termsandconditionImage =
      "$imageDir/terms-and-conditions.png";
  static const String app_Icon = "$imageDir/app_logo.png";

  static const String privacypolicyImage = "$imageDir/compliant.png";
  static const String contactUs = "$imageDir/contact.png";

  static const String gifLoading = "$gifDir/loading.gif";
  static const String errorAnimation = "$animDir/error.json";
  static const String emptyListAnimation = "$animDir/empty-list.json";
  static const String editIcon = "$svgDir/edit-icon.svg";
  static const String circularEditIcon = "$svgDir/circular_edit_icon.svg";

  static const String emptyBoxRed = "$svgDir/empty-box-red.svg";

  static const String compareImage = "$imageDir/compare.png";
  static const String emptyCart = "$imageDir/empty_cart.png";
  static const String noItemFound = "$imageDir/no-item-found.png";
  static const String noItem = "$svgDir/no-item.svg";
  static const String emptyWishlist = "$imageDir/empty_wishlist.png";
  static const String emptyOrderHistory = "$imageDir/empty-order-history.png";
  static const String loadingPulseGifImage = "$animDir/loading-pulse.gif";
  static const String loadingFlare = "$flareDir/loading.flr";

  //social media
  static const String googleIcon = "$svgDir/google-icon.svg";
  static const String facebookIcon = "$svgDir/facebook.svg";
  static const String instagramIcon = "$svgDir/instagram.svg";

  static String getImage(String imageName) {
    return "$imageDir/$imageName";
  }

  static String getSvg(String svgName) {
    return "$svgDir/$svgName";
  }
}
