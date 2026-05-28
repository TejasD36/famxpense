part of 'partner_bloc.dart';

@freezed
sealed class PartnerState with _$PartnerState {
  const factory PartnerState.initial() = _Initial;

  const factory PartnerState.loading() = _Loading;

  const factory PartnerState.loaded({
    /// SEARCH RESULT
    UserEntity? searchedUser,

    /// CONNECTED
    @Default([]) List<PartnershipEntity> connectedPartners,

    /// INCOMING
    @Default([]) List<PartnershipEntity> incomingRequests,

    /// OUTGOING
    @Default([]) List<PartnershipEntity> outgoingRequests,
  }) = _Loaded;

  const factory PartnerState.error({required String message}) = _Error;
}
