// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compare_product_local_params.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompareProductLocalParamsAdapter
    extends TypeAdapter<CompareProductLocalParams> {
  @override
  final int typeId = 100;

  @override
  CompareProductLocalParams read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompareProductLocalParams(
      id: fields[0] as String,
      categoryId: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CompareProductLocalParams obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.categoryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompareProductLocalParamsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
