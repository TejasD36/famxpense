import '../../../auth/data/datasources/local/auth_local_datasource.dart';
import '../../xcore.dart';

part 'partner_bloc.freezed.dart';
part 'partner_event.dart';
part 'partner_state.dart';

class PartnerBloc extends Bloc<PartnerEvent, PartnerState> {
  final SearchUserUsecase _searchUserUsecase;
  final SendPartnershipRequestUsecase _sendRequestUsecase;
  final GetPartnershipsUsecase _getPartnershipsUsecase;
  final AuthLocalDatasource _authLocalDatasource;
  final UserLocalDatasource _userLocalDatasource;

  PartnerBloc({
    required SearchUserUsecase searchUserUsecase,
    required SendPartnershipRequestUsecase sendRequestUsecase,
    required GetPartnershipsUsecase getPartnershipsUsecase,
    required AuthLocalDatasource authLocalDatasource,
    required UserLocalDatasource userLocalDatasource,
  }) : _searchUserUsecase = searchUserUsecase,
       _sendRequestUsecase = sendRequestUsecase,
       _getPartnershipsUsecase = getPartnershipsUsecase,
       _authLocalDatasource = authLocalDatasource,
       _userLocalDatasource = userLocalDatasource,
       super(const PartnerState.initial()) {
    on<_SearchUser>(_onSearchUser);
    on<_SendRequest>(_onSendRequest);
    on<_LoadPartners>(_onLoadPartners);
    on<_AcceptRequest>(_onAcceptRequest);
    on<_RejectRequest>(_onRejectRequest);
    on<_ClearSearch>(_onClearSearch);
  }

  Future<void> _onSearchUser(_SearchUser event, Emitter<PartnerState> emit) async {
    try {
      emit(const PartnerState.loading());

      final currentUserId = _authLocalDatasource.getUserId();

      if (currentUserId == null) {
        throw Exception('User not logged in');
      }

      /// PRESERVE existing partner lists while showing search results
      final currentState = state;
      final connected = currentState is _Loaded ? currentState.connectedPartners : <PartnershipEntity>[];
      final incoming = currentState is _Loaded ? currentState.incomingRequests : <PartnershipEntity>[];
      final outgoing = currentState is _Loaded ? currentState.outgoingRequests : <PartnershipEntity>[];

      final user = await _searchUserUsecase(query: event.query, currentUserId: currentUserId);

      emit(PartnerState.loaded(
        searchedUser: user,
        connectedPartners: connected,
        incomingRequests: incoming,
        outgoingRequests: outgoing,
      ));
    } catch (e) {
      emit(PartnerState.error(message: e.toString()));
    }
  }

  Future<void> _onSendRequest(_SendRequest event, Emitter<PartnerState> emit) async {
    try {
      final currentUserId = _authLocalDatasource.getUserId();

      if (currentUserId == null) throw Exception('User not logged in');

      final currentState = state;

      if (currentState is! _Loaded) return;

      final currentUser = _userLocalDatasource.getCurrentUser();

      if (currentUser == null) throw Exception('Current user not found');

      final now = DateTime.now().toUtc();

      final partnership = PartnershipEntity(
        id: const Uuid().v4(),

        /// SENDER
        senderId: currentUser.id,
        senderEmail: currentUser.email,
        senderNickname: currentUser.nickname,

        /// RECEIVER
        receiverId: event.user.id,
        receiverEmail: event.user.email,
        receiverNickname: event.user.nickname,

        /// STATUS
        status: PartnershipStatus.pending,
        createdAt: now,
        updatedAt: now,
      );

      await _sendRequestUsecase(partnership);

      emit(currentState.copyWith(outgoingRequests: [...currentState.outgoingRequests, partnership]));
    } catch (e) {
      emit(PartnerState.error(message: e.toString()));
    }
  }

  Future<void> _onLoadPartners(_LoadPartners event, Emitter<PartnerState> emit) async {
    try {
      emit(const PartnerState.loading());

      final currentUserId = _authLocalDatasource.getUserId();

      if (currentUserId == null) {
        throw Exception('User not logged in');
      }

      final partnerships = await _getPartnershipsUsecase(userId: currentUserId);

      final connected = partnerships.where((e) {
        return e.status == PartnershipStatus.accepted;
      }).toList();

      final incoming = partnerships.where((e) {
        return e.status == PartnershipStatus.pending && e.receiverId == currentUserId;
      }).toList();

      final outgoing = partnerships.where((e) {
        return e.status == PartnershipStatus.pending && e.senderId == currentUserId;
      }).toList();

      emit(PartnerState.loaded(connectedPartners: connected, incomingRequests: incoming, outgoingRequests: outgoing));
    } catch (e) {
      emit(PartnerState.error(message: e.toString()));
    }
  }

  Future<void> _onAcceptRequest(_AcceptRequest event, Emitter<PartnerState> emit) async {
    try {
      final updated = event.partnership.copyWith(status: PartnershipStatus.accepted, updatedAt: DateTime.now().toUtc());
      await _sendRequestUsecase(updated);

      final currentState = state;
      if (currentState is _Loaded) {
        emit(currentState.copyWith(
          connectedPartners: [...currentState.connectedPartners, updated],
          incomingRequests: currentState.incomingRequests.where((e) => e.id != updated.id).toList(),
        ));
      } else {
        add(const _LoadPartners());
      }
    } catch (e) {
      emit(PartnerState.error(message: e.toString()));
    }
  }

  Future<void> _onRejectRequest(_RejectRequest event, Emitter<PartnerState> emit) async {
    try {
      final updated = event.partnership.copyWith(status: PartnershipStatus.rejected, updatedAt: DateTime.now().toUtc());
      await _sendRequestUsecase(updated);

      final currentState = state;
      if (currentState is _Loaded) {
        emit(currentState.copyWith(
          incomingRequests: currentState.incomingRequests.where((e) => e.id != updated.id).toList(),
        ));
      } else {
        add(const _LoadPartners());
      }
    } catch (e) {
      emit(PartnerState.error(message: e.toString()));
    }
  }

  Future<void> _onClearSearch(_ClearSearch event, Emitter<PartnerState> emit) async {
    emit(const PartnerState.initial());
  }
}
