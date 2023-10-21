class CompareProduct {
  CompareProduct({
    this.entityId,
    this.attributeSetId,
    this.typeId,
    this.sku,
    this.hasOptions,
    this.requiredOptions,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.metaTitle,
    this.metaDescription,
    this.cimCode,
    this.quantityAndStockStatus,
    this.taxClassId,
    this.price,
    this.vatExcludedPrice,
    this.vatAmount,
    this.storeId,
    this.hotOnsale,
    this.attributes,
    this.saleableStock,
    this.isSaleable,
    this.productImages,
    this.availability,
    this.catalogCompareItemId,
  });

  String? entityId;
  String? attributeSetId;
  String? typeId;
  String? sku;
  String? hasOptions;
  String? requiredOptions;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? metaTitle;
  String? metaDescription;
  String? cimCode;
  String? quantityAndStockStatus;
  String? taxClassId;
  String? price;
  String? vatExcludedPrice;
  String? vatAmount;
  int? storeId;
  dynamic hotOnsale;
  List<Attribute?>? attributes;
  int? saleableStock;
  bool? isSaleable;
  ProductImages? productImages;
  String? availability;
  String? catalogCompareItemId;

  factory CompareProduct.fromJson(Map<String, dynamic> json) => CompareProduct(
        entityId: json["entity_id"],
        attributeSetId: json["attribute_set_id"],
        typeId: json["type_id"],
        sku: json["sku"],
        hasOptions: json["has_options"],
        requiredOptions: json["required_options"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        cimCode: json["cim_code"],
        quantityAndStockStatus: json["quantity_and_stock_status"],
        taxClassId: json["tax_class_id"],
        price: json["price"],
        vatExcludedPrice: json["vat_excluded_price"],
        vatAmount: json["vat_amount"],
        storeId: json["store_id"],
        hotOnsale: json["hot-onsale"],
        attributes: json["attributes"] == null
            ? []
            : List<Attribute?>.from(
                json["attributes"]!.map((x) => Attribute.fromJson(x))),
        saleableStock: json["saleable_stock"],
        isSaleable: json["is_saleable"],
        productImages: ProductImages.fromJson(json["product_images"]),
        availability: json["availability"],
        catalogCompareItemId: json["catalog_compare_item_id"],
      );

  Map<String, dynamic> toJson() => {
        "entity_id": entityId,
        "attribute_set_id": attributeSetId,
        "type_id": typeId,
        "sku": sku,
        "has_options": hasOptions,
        "required_options": requiredOptions,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "cim_code": cimCode,
        "quantity_and_stock_status": quantityAndStockStatus,
        "tax_class_id": taxClassId,
        "price": price,
        "vat_excluded_price": vatExcludedPrice,
        "vat_amount": vatAmount,
        "store_id": storeId,
        "hot-onsale": hotOnsale,
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x!.toJson())),
        "saleable_stock": saleableStock,
        "is_saleable": isSaleable,
        "product_images": productImages!.toJson(),
        "availability": availability,
        "catalog_compare_item_id": catalogCompareItemId,
      };
}

class Attribute {
  Attribute({
    this.attributeCode,
    this.attributeValues,
  });

  String? attributeCode;
  String? attributeValues;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        attributeCode: json["attribute_code"],
        attributeValues: json["attribute_values"],
      );

  Map<String, dynamic> toJson() => {
        "attribute_code": attributeCode,
        "attribute_values": attributeValues,
      };
}

// class ProductImages {
//   ProductImages({
//     this.type,
//     this.main,
//     this.gallery,
//   });

//   String? type;
//   String? main;
//   List<dynamic>? gallery;

//   factory ProductImages.fromJson(Map<String, dynamic> json) => ProductImages(
//         type: json["type"],
//         main: json["main"],
//         gallery: json["gallery"] == null
//             ? []
//             : List<dynamic>.from(json["gallery"]!.map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "main": main,
//         "gallery":
//             gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x)),
//       };
// }

class ProductImages {
  ProductImages({this.prefix, this.image, this.thumbnail, this.smallImage});

  String? prefix;
  String? image;
  String? thumbnail;
  String? smallImage;

  factory ProductImages.fromJson(Map<String, dynamic> json) => ProductImages(
      prefix: json["prefix"],
      image: json["image"],
      thumbnail: json["thumbnail"],
      smallImage: json["small_image"]);

  Map<String, dynamic> toJson() => {
        "prefix": prefix,
        "image": image,
        "thumbnail": thumbnail,
        "smallImage": smallImage,
      };
}
