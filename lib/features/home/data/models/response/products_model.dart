// class ProductModel {
//   String? entityId;
//   String? attributeSetId;
//   String? typeId;
//   String? sku;
//   String? hasOptions;
//   String? requiredOptions;
//   String? createdAt;
//   String? updatedAt;
//   String? qty;
//   String? stockStatus;
//   String? name;
//   String? metaTitle;
//   String? metaDescription;
//   String? optionsContainer;
//   String? urlKey;
//   String? msrpDisplayActualPriceType;
//   String? cimCode;
//   String? navProductBrand;
//   String? status;
//   String? visibility;
//   String? quantityAndStockStatus;
//   String? taxClassId;
//   String? navReplicationCounter;
//   String? navFeatureProduct;
//   String? navOnSale;
//   String? navBestSeller;
//   String? navTopRated;
//   String? navBestDeal;
//   String? navTvg01Connectivity;
//   String? navTvg01SizeTechResolutn;
//   String? navTvg01BluetoothVersion;
//   String? navTvg01DimWOStandWxhxd;
//   String? navTvg01DimStandWxhxdMm;
//   String? navTvg01DtvReceivingSystem;
//   String? navTvg01HdmiPorts;
//   String? navTvg01Os;
//   String? navTvg01OtherFeature1;
//   String? navTvg01OtherFeature2;
//   String? navTvg01OtherFeature3;
//   String? navTvg01Resolution;
//   String? navTvg01Size;
//   String? navTvg01Type;
//   String? navTvg01UsbPorts;
//   String? navTvg01Warranty;
//   String? price;
//   String? vatExcludedPrice;
//   String? vatAmount;
//   String? navProductDate;
//   String? navProductTags;
//   String? navAttributesShowList;
//   String? navAttributesMoreList;
//   int? storeId;
//   int? saleableStock;
//   bool? isSaleable;
//   ProductImage? productImage;
//   String? hotOnSale;
//   String? image;
//   String? availability;

//   bool get isProductInStock => availability == "IN STOCK";

//   ProductModel({
//     this.entityId,
//     this.attributeSetId,
//     this.typeId,
//     this.sku,
//     this.hasOptions,
//     this.requiredOptions,
//     this.createdAt,
//     this.updatedAt,
//     this.qty,
//     this.stockStatus,
//     this.name,
//     this.metaTitle,
//     this.metaDescription,
//     this.optionsContainer,
//     this.urlKey,
//     this.msrpDisplayActualPriceType,
//     this.cimCode,
//     this.navProductBrand,
//     this.status,
//     this.visibility,
//     this.quantityAndStockStatus,
//     this.taxClassId,
//     this.navReplicationCounter,
//     this.navFeatureProduct,
//     this.navOnSale,
//     this.navBestSeller,
//     this.navTopRated,
//     this.navBestDeal,
//     this.navTvg01Connectivity,
//     this.navTvg01SizeTechResolutn,
//     this.navTvg01BluetoothVersion,
//     this.navTvg01DimWOStandWxhxd,
//     this.navTvg01DimStandWxhxdMm,
//     this.navTvg01DtvReceivingSystem,
//     this.navTvg01HdmiPorts,
//     this.navTvg01Os,
//     this.navTvg01OtherFeature1,
//     this.navTvg01OtherFeature2,
//     this.navTvg01OtherFeature3,
//     this.navTvg01Resolution,
//     this.navTvg01Size,
//     this.navTvg01Type,
//     this.navTvg01UsbPorts,
//     this.navTvg01Warranty,
//     this.price,
//     this.vatExcludedPrice,
//     this.vatAmount,
//     this.navProductDate,
//     this.navProductTags,
//     this.navAttributesShowList,
//     this.navAttributesMoreList,
//     this.storeId,
//     this.saleableStock,
//     this.isSaleable,
//     this.productImage,
//     this.hotOnSale,
//     this.image,
//     this.availability,
//   });

//   ProductModel.fromJson(Map<String, dynamic> json) {
//     entityId = json['entity_id'];
//     attributeSetId = json['attribute_set_id'];
//     typeId = json['type_id'];
//     sku = json['sku'];
//     hasOptions = json['has_options'];
//     requiredOptions = json['required_options'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     qty = json['qty'];
//     stockStatus = json['quantity_and_stock_status'];
//     name = json['name'];
//     metaTitle = json['meta_title'];
//     metaDescription = json['meta_description'];
//     optionsContainer = json['options_container'];
//     urlKey = json['url_key'];
//     msrpDisplayActualPriceType = json['msrp_display_actual_price_type'];
//     cimCode = json['cim_code'];
//     navProductBrand = json['nav_product_brand'];
//     status = json['status'];
//     visibility = json['visibility'];
//     quantityAndStockStatus = json['quantity_and_stock_status'];
//     taxClassId = json['tax_class_id'];
//     navReplicationCounter = json['nav_replication_counter'];

//     price = json['price'];
//     vatExcludedPrice = json['vat_excluded_price'];
//     vatAmount = json['vat_amount'];
//     navProductDate = json['nav_product_date'];
//     navProductTags = json['nav_product_tags'];

//     saleableStock = json['saleable_stock'];
//     isSaleable = json['is_saleable'];
//     productImage = json['product_images'] != null
//         ? ProductImage.fromJson(json['product_images'])
//         : null;
//     hotOnSale = json['hot-onsale'];
//     availability = json['availability'];
//     image=json['image'];

//   }
// }
class ProductModel {
  late int id;
  late String name;
  late String slug;
  late String sku;
  late String thumbnail;
  late int inventory;
  late double price;
  late double offerPrice;
  late String description;
  late String createdAt;
  late String category;
  late String brand;
  late double computedPrice;
  late int isWishlist;
  late double? avgRating;
  late bool isProductInStock;

  ProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.sku,
    required this.thumbnail,
    required this.inventory,
    required this.price,
    required this.offerPrice,
    required this.description,
    required this.createdAt,
    required this.category,
    required this.brand,
    required this.computedPrice,
    required this.isWishlist,
    this.avgRating,
    this.isProductInStock = true,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      sku: json['sku'],
      thumbnail: json['thumbnail'],
      inventory: json['inventory'],
      price: double.parse(json['price']),
      offerPrice: double.parse(json['offer_price']),
      description: json['description'],
      createdAt: json['created_at'],
      category: json['category'],
      brand: json['brand'],
      computedPrice: double.parse(json['computed_price']),
      isWishlist: json['is_wishlist'],
      isProductInStock: true,
      // isProductInStock: json["in_stock"] ?? true,
      avgRating:
          json['avg_rating'] != null ? double.parse(json['avg_rating']) : null,
    );
  }
}

class ProductImage {
  String? image;
  String? thumbnail;
  String? smallImage;

  ProductImage({this.image, this.thumbnail, this.smallImage});

  ProductImage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    thumbnail = json['thumbnail'];
    smallImage = json['smallImage'];
  }
}

/*
 "image_gallery": {
                    "image": "/e/l/electronics_-_scanfrost_sfr300-refrigerator_frost_free_silver_-_300l_itm002319_.jpg",
                    "thumbnail": "/e/l/electronics_-_scanfrost_sfr300-refrigerator_frost_free_silver_-_300l_itm002319_.jpg",
                    "small_image": "/e/l/electronics_-_scanfrost_sfr300-refrigerator_frost_free_silver_-_300l_itm002319_.jpg"
                }
 */
