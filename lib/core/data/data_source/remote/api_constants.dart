enum APIPath {
  /*  Auth  */
  login,
  register,
  passwordReset,
  passwordUpdate,
  logout,

  /* Home */
  imageSlider,
  featuredCategory,
  banners,

  /* Products */
  products,
  productDetail,
  allProducts,
  productCompare,
  deleteCompareProduct,
  addCompareProduct,
  filterModel,

  /* Checkout */
  shippingMethods,
  orderSummary,
  paymentMethods,
  placeOrder,
  orders,
  orderDetails,
  shippingAndBillingAddress,
  updatePaymentStatus,

  /* Wishlist*/
  getWishList,
  removeItem,
  addItem,
  clear,

  /* Store Location */
  pickupStoreList,

  /* Profile */
  profile,
  editProfile,

  /* Address */
  nonDefaultAddressList,
  deleteNonDefaultAddress,
  updateNonDefaultAddress,
  addNonDefaultAddress,
  updateDefaultBillingAddress,
  updateDefaultShippingAddress,
  defaultAddress,
  setDefaultShippingAddress,
  setDefaultBillingAddress,
  countryList,
  regionList,

  /* Category */
  category,

  //cart
  getCartItems,
  addToCart,
  removeAllCartProducts,
  removeCartItem,
  updateCart,

  /* CRM */
  crm,

  /* Profile */
  profileAPis,

  //reviews
  reviews,

  //brands
  brands,

  //paystack
  paystackTransactionInitiate,
  paystackVerifyTransaction,

  loginWithSocialMedia,
}

class APIPathHelper {
  static const String baseUrl = "https://qmbmart.com";
  static const String reCaptchaToken = "ybntheqhyl90wx5ogfv8fwii1aisa969";

  static String authAPIs(APIPath path, {String? keyword}) {
    switch (path) {
      case APIPath.login:
        return "/rest/V1/customer/login";

      case APIPath.register:
        return "/rest/V1/customer/register";

      case APIPath.passwordReset:
        return "/rest/V1/customers/password";

      case APIPath.passwordUpdate:
        return "/rest/V1/customers/me/password";

      case APIPath.logout:
        return "/rest/V1/customer/logout";

      case APIPath.loginWithSocialMedia:
        return "/rest/V1/social-auth/social-authenticate";

      default:
        return "";
    }
  }

  static String homeAPIs(
    APIPath path, {
    String? keyword,
    String? id,
  }) {
    switch (path) {
      case APIPath.imageSlider:
        return "/rest/V1/homepage/sliders?filter=qmb-sliders";

      case APIPath.featuredCategory:
        return "/rest/V1/category/featured";

      case APIPath.banners:
        return "/rest/V1/homepage/sliders?filter=$keyword";

      default:
        return "";
    }
  }

  static String brandsApi(
    APIPath path, {
    String? keyword,
    String? id,
  }) {
    switch (path) {
      case APIPath.brands:
        return "/rest/V1/brands";

      default:
        return "";
    }
  }

  static String productAPIs(
    APIPath path, {
    String? keyword,
    String? id,
  }) {
    switch (path) {
      case APIPath.products:
        return "/rest/V1/custom/products";

      case APIPath.allProducts:
        return "/rest/V1/custom/products";
      case APIPath.productDetail:
        return "/rest/V1/product?sku=$keyword";

      case APIPath.productCompare:
        return "/rest/V1/comparelist";

      case APIPath.deleteCompareProduct:
        return "/rest/V1/compare/remove/$id";

      case APIPath.addCompareProduct:
        return "/rest/V1/compare/add/$id";

      case APIPath.filterModel:
        return "/rest/V1/categories/$id/subcategories";

      default:
        return "";
    }
  }

  static String checkoutAPIs(APIPath path) {
    switch (path) {
      case APIPath.shippingMethods:
        return "/rest/V1/checkout/shipping-method";

      case APIPath.orderSummary:
        return "/rest/V1/checkout/order-summary";
      case APIPath.paymentMethods:
        return "/rest/V1/checkout/payment-method";

      case APIPath.placeOrder:
        return "/rest/V1/checkout/place-order";

      case APIPath.shippingAndBillingAddress:
        return "/rest/V1/checkout/shipping";

      case APIPath.updatePaymentStatus:
        return "/rest/V1/payment/paystack-response";

      default:
        return "";
    }
  }

  static String paymentAPIs(APIPath path, {String? id}) {
    switch (path) {
      case APIPath.paystackTransactionInitiate:
        return "https://api.paystack.co/transaction/initialize";
      case APIPath.paystackVerifyTransaction:
        return "https://api.paystack.co/transaction/verify/$id";

      default:
        return "";
    }
  }

  static String wishListAPIs(
    APIPath path, {
    String? keyword,
    String? id,
  }) {
    switch (path) {
      case APIPath.getWishList:
        return "/rest/V1/wishlist/items";

      case APIPath.addItem:
        return "/rest/V1/wishlist/add/$id";

      case APIPath.removeItem:
        return "/rest/V1/wishlist/remove/$id";

      case APIPath.clear:
        return "/rest/V1/wishlist/clear";
      default:
        return "";
    }
  }

  static String cartAPIs(
    APIPath path, {
    String? keyword,
    String? id,
  }) {
    switch (path) {
      case APIPath.getCartItems:
        return "/rest/V1/cart";

      case APIPath.removeCartItem:
        return "/rest/V1/cart/remove/$id";

      case APIPath.addToCart:
        return "/rest/V1/cart/add";

      case APIPath.updateCart:
        return "/rest/V1/cart/update";

      case APIPath.removeAllCartProducts:
        return "/rest/V1/cart/delete";

      default:
        return "";
    }
  }

  static String profileAPIs(
    APIPath path, {
    String? keyword,
    String? id,
  }) {
    switch (path) {
      case APIPath.profileAPis:
        return "/rest/V1/customer/me";

      case APIPath.editProfile:
        return "/rest/V1/customer/update";

      default:
        return "";
    }
  }

  static String reviewAPIs(
    APIPath path, {
    String? keyword,
    String? id,
  }) {
    switch (path) {
      case APIPath.reviews:
        return "/rest/V1/review/add/$id";

      default:
        return "";
    }
  }

  static String storeLocationAPIs(
    APIPath path, {
    String? id,
  }) {
    switch (path) {
      case APIPath.pickupStoreList:
        return "/rest/V1/checkout/storeLocations";

      default:
        return "";
    }
  }

  static String addressAPIs(APIPath path, {String? id}) {
    switch (path) {
      case APIPath.nonDefaultAddressList:
        return "/rest/V1/customer/ndaddress";
      case APIPath.deleteNonDefaultAddress:
        return "/rest/V1/delete/address/$id";

      case APIPath.addNonDefaultAddress:
        return "/rest/V1/customer/address/add";

      case APIPath.updateNonDefaultAddress:
        return "/rest/V1/update/address/$id";

      case APIPath.updateDefaultBillingAddress:
        return "/rest/V1/customer/billingadd/update";

      case APIPath.updateDefaultShippingAddress:
        return "/rest/V1/customer/shippingadd/update";

      case APIPath.defaultAddress:
        return "/rest/V1/customer/address";

      case APIPath.setDefaultBillingAddress:
        return "/rest/V1/set/billingAddress/$id";

      case APIPath.setDefaultShippingAddress:
        return "/rest/V1/set/shippingAddress/$id";

      case APIPath.countryList:
        return "/rest/V1/directory/countries";
      case APIPath.regionList:
        return "/rest/V1/regions/$id";
      default:
        return "";
    }
  }

  static String crmAPIs(
    APIPath path, {
    String? keyword,
    String? id,
  }) {
    switch (path) {
      case APIPath.crm:
        return "/rest/V1/cmsPage/$id";

      default:
        return "";
    }
  }

  static String orderHistory(
    APIPath path, {
    String? keyword,
    String? id,
  }) {
    switch (path) {
      case APIPath.orders:
        return "/rest/V1/customer/order";

      case APIPath.orderDetails:
        return "/rest/V1/customer/order/$id";

      default:
        return "";
    }
  }

  static String categoryAPIs(
    APIPath path, {
    String? keyword,
    String? id,
  }) {
    switch (path) {
      case APIPath.category:
        return "/rest/V1/categories";

      case APIPath.register:
        return "/products/$id";

      default:
        return "";
    }
  }
}
