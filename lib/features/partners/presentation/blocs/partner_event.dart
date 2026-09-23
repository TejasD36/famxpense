part of 'partner_bloc.dart';

@freezed
sealed class PartnerEvent with _$PartnerEvent {
  /// SEARCH USER
  const factory PartnerEvent.searchUser({required String query}) = _SearchUser;

  /// SEND REQUEST
  const factory PartnerEvent.sendRequest({required UserEntity user}) =
      _SendRequest;

  /// LOAD PARTNERSHIPS
  const factory PartnerEvent.loadPartners() = _LoadPartners;

  /// ACCEPT REQUEST
  const factory PartnerEvent.acceptRequest({
    required PartnershipEntity partnership,
  }) = _AcceptRequest;

  /// REJECT REQUEST
  const factory PartnerEvent.rejectRequest({
    required PartnershipEntity partnership,
  }) = _RejectRequest;

  /// REMOVE PARTNER
  const factory PartnerEvent.removePartner({required String partnershipId}) =
      _RemovePartner;

  const factory PartnerEvent.clearSearch() = _ClearSearch;
}
