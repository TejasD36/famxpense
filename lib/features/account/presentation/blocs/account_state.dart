part of 'account_bloc.dart';

@freezed
sealed class AccountState with _$AccountState {
  const factory AccountState.initial() = _Initial;

  const factory AccountState.loading() = _Loading;

  const factory AccountState.loaded({
    @Default([]) List<AccountEntity> accounts,
  }) = _Loaded;

  const factory AccountState.error({required String message}) = _Error;
}
