import '../../core.dart';

part 'split_type.g.dart';

@HiveType(typeId: HiveTypeIds.splitType)
enum SplitType {
  @HiveField(0)
  equal,

  @HiveField(1)
  manual,
}
