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
  // productCompare,
  // deleteCompareProduct,
  // addCompareProduct,
  // filterModel,

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
  // removeItem,
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
  // updateDefaultBillingAddress,
  // updateDefaultShippingAddress,
  // defaultAddress,
  // setDefaultShippingAddress,
  // setDefaultBillingAddress,
  // countryList,
  // regionList,

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
  // static const String baseUrl = "https://qmbmart.com";
  static const String baseUrl = "https://yeshelpinghand.com";

  static const String baseUrlImage = "https://yeshelpinghand.com/";

  static String authAPIs(APIPath path, {String? keyword}) {
    switch (path) {
      case APIPath.login:
        return "/api/V1/login";

      case APIPath.register:
        return "/api/V1/register";

      case APIPath.passwordReset:
        return "/rest/V1/customers/password";

      case APIPath.passwordUpdate:
        return "/rest/V1/customers/me/password";

      case APIPath.logout:
        return "/api/V1/logout";

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
        return "/api/V1/get-sliders";

      case APIPath.featuredCategory:
        return "/rest/V1/category/featured";

      case APIPath.banners:
        return "/api/V1/get-advertisements";

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
        return "/api/V1/brands";

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
        return "/api/V1/get-products";

      case APIPath.allProducts:
        return "/api/V1/get-products";
      case APIPath.productDetail:
        return "/api/V1/view-product/$keyword";

      // case APIPath.productCompare:
      //   return "/rest/V1/comparelist";

      // case APIPath.deleteCompareProduct:
      //   return "/rest/V1/compare/remove/$id";

      // case APIPath.addCompareProduct:
      //   return "/rest/V1/compare/add/$id";

      // case APIPath.filterModel:
      //   return "/rest/V1/categories/$id/subcategories";

      default:
        return "";
    }
  }

  static String checkoutAPIs(APIPath path) {
    switch (path) {
      case APIPath.paymentMethods:
        return "/rest/V1/checkout/payment-method";

      case APIPath.placeOrder:
        return "/api/V1/create-order";

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
        return "/api/V1/get-wishlists";

      case APIPath.addItem:
        return "/api/V1/add-wishlists";

      // case APIPath.removeItem:
      //   return "/api/V1/wishlist/remove/$id";

      case APIPath.clear:
        return "/api/V1/empty-wishlist";
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
        return "/api/V1/get-carts";

      case APIPath.removeCartItem:
        return "/rest/V1/cart/remove/$id";

      case APIPath.addToCart:
        return "/api/V1/add-carts";

      case APIPath.updateCart:
        return "/api/V1/update-cart";

      case APIPath.removeAllCartProducts:
        return "/api/V1/empty-cart";

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
        return "/api/V1/get-profile";

      case APIPath.editProfile:
        return "/api/V1/update-account";

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
        return "/api/V1/get-addresses";
      case APIPath.deleteNonDefaultAddress:
        return "/api/V1/delete-addresses";

      case APIPath.addNonDefaultAddress:
        return "/api/V1/create-addresses";

      case APIPath.updateNonDefaultAddress:
        return "/api/V1/update-addresses";

      // case APIPath.updateDefaultBillingAddress:
      //   return "/rest/V1/customer/billingadd/update";

      // case APIPath.updateDefaultShippingAddress:
      //   return "/rest/V1/customer/shippingadd/update";

      // case APIPath.defaultAddress:
      //   return "/api/V1/get-addresses";

      // case APIPath.setDefaultBillingAddress:
      //   return "/rest/V1/set/billingAddress/$id";

      // case APIPath.setDefaultShippingAddress:
      //   return "/rest/V1/set/shippingAddress/$id";

      // case APIPath.countryList:
      //   return "/rest/V1/directory/countries";
      // case APIPath.regionList:
      //   return "/rest/V1/regions/$id";
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
        return "/api/V1/get-orders";

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
        return "/api/V1/get-categories";

      default:
        return "";
    }
  }
}
