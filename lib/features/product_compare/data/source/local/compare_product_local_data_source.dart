import 'package:yeshelpinghand/core/data/data_source/local/hive_service.dart';
import 'package:yeshelpinghand/core/data/data_source/local/storage_constants.dart';
import 'package:yeshelpinghand/features/product_compare/data/model/compare_product_local_params.dart';

abstract class CompareProductLocalDataSource {
  Future<dynamic> fetchProductIds();

  Future<dynamic> addProductId(
      CompareProductLocalParams compareProductLocalParams);

  Future<dynamic> deleteProductId(int id);
}

class CompareProductLocalDataSourceImpl
    implements CompareProductLocalDataSource {
  final HiveService hiveService;

  CompareProductLocalDataSourceImpl({required this.hiveService});

  @override
  Future addProductId(
      CompareProductLocalParams compareProductLocalParams) async {
    return hiveService.save<CompareProductLocalParams>(
        LocalStorageConstants.compareProductBox,
        compareProductLocalParams.id,
        compareProductLocalParams);
  }

  @override
  Future deleteProductId(int id) {
    return hiveService.delete(
        LocalStorageConstants.compareProductBox, id.toString());
  }

  @override
  Future fetchProductIds() {
    return hiveService.get<CompareProductLocalParams>(
        LocalStorageConstants.compareProductBox);
  }
}
