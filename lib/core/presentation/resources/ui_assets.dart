class UIAssets {
  static const String imageDir = "assets/images";
  static const String gifDir = "assets/gif";
  static const String svgDir = "assets/svg";
  static const String animDir = "assets/anim";

  static const String appIcon = "$imageDir/app_logo_yhh.png";
  static const String placeHolderImage = "$imageDir/image-load-error.png";
  static const String app_Icon = "$imageDir/app_logo.png";
  static const String emptyCart = "$imageDir/empty_cart.png";
  static const String noItemFound = "$imageDir/no-item-found.png";
  static const String emptyWishlist = "$imageDir/empty_wishlist.png";
  static const String emptyOrderHistory = "$imageDir/empty-order-history.png";
  static const String gifLoading = "$gifDir/loading.gif";
  static const String editIcon = "$svgDir/edit-icon.svg";
  static const String errorAnimation = "$animDir/error.json";

  static String getImage(String imageName) {
    return "$imageDir/$imageName";
  }

  static String getSvg(String svgName) {
    return "$svgDir/$svgName";
  }
}
