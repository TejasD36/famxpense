import '../../../../core.dart';

part 'account_dto.freezed.dart';
part 'account_dto.g.dart';

@HiveType(typeId: HiveTypeIds.account)
@freezed
sealed class AccountDto with _$AccountDto {
  const factory AccountDto({
    @HiveField(0) required String id,
    @HiveField(1) required String userId,
    @HiveField(2) required String accountName,
    @HiveField(3) required AccountType accountType,
    @HiveField(4) required double currentBalance,
    @HiveField(5) required DateTime createdAt,
    @HiveField(6) required DateTime updatedAt,
    @HiveField(7) @Default(false) bool isArchived,
  }) = _AccountDto;

  factory AccountDto.fromJson(Map<String, dynamic> json) => _$AccountDtoFromJson(json);
}
