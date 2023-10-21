import 'package:hive/hive.dart';
part 'compare_product_local_params.g.dart';

@HiveType(typeId: 100)
class CompareProductLocalParams {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String categoryId;

  const CompareProductLocalParams({required this.id, required this.categoryId});
}
