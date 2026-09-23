part of 'account_bloc.dart';

@freezed
sealed class AccountEvent with _$AccountEvent {
  const factory AccountEvent.loadAccounts() = _LoadAccounts;

  const factory AccountEvent.saveAccount({required AccountEntity account}) =
      _SaveAccount;

  const factory AccountEvent.deleteAccount({required String accountId}) =
      _DeleteAccount;

  const factory AccountEvent.updateBalance({
    required String accountId,
    required double newBalance,
  }) = _UpdateBalance;
}
