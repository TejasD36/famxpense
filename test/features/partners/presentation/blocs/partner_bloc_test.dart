import 'package:bloc_test/bloc_test.dart';
import 'package:famxpense/core/services/refresh/refresh_notifier.dart';
import 'package:famxpense/features/partners/presentation/blocs/partner_bloc.dart';
import 'package:famxpense/shared/data/transformers/dtos/user/user_dto.dart';
import 'package:famxpense/shared/domain/entities/partnership/partnership_entity.dart';
import 'package:famxpense/shared/domain/entities/user/user_entity.dart';
import 'package:famxpense/shared/enums/partnership_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

final sl = GetIt.instance;

void main() {
  late MockSearchUserUsecase mockSearch;
  late MockSendPartnershipRequestUsecase mockSend;
  late MockGetPartnershipsUsecase mockGet;
  late MockPartnershipRepository mockRepo;
  late MockAuthLocalDatasource mockAuth;
  late MockUserLocalDatasource mockUser;

  final now = DateTime(2026, 7, 21, 12, 0, 0).toUtc();

  final currentUserDto = UserDto(
    id: 'user-a',
    name: 'Alice',
    nickname: 'alice',
    email: 'alice@test.com',
    createdAt: now,
    updatedAt: now,
  );

  final searchUser = UserEntity(
    id: 'user-b',
    name: 'Bob',
    nickname: 'bob',
    email: 'bob@test.com',
    createdAt: now,
    updatedAt: now,
  );

  final connectedPartner = PartnershipEntity(
    id: 'p-1',
    senderId: 'user-a',
    senderEmail: 'alice@test.com',
    senderNickname: 'alice',
    receiverId: 'user-b',
    receiverEmail: 'bob@test.com',
    receiverNickname: 'bob',
    status: PartnershipStatus.accepted,
    createdAt: now,
    updatedAt: now,
  );

  final incomingRequest = PartnershipEntity(
    id: 'p-2',
    senderId: 'user-b',
    senderEmail: 'bob@test.com',
    senderNickname: 'bob',
    receiverId: 'user-a',
    receiverEmail: 'alice@test.com',
    receiverNickname: 'alice',
    status: PartnershipStatus.pending,
    createdAt: now,
    updatedAt: now,
  );

  setUp(() {
    registerFallbacks();

    mockSearch = MockSearchUserUsecase();
    mockSend = MockSendPartnershipRequestUsecase();
    mockGet = MockGetPartnershipsUsecase();
    mockRepo = MockPartnershipRepository();
    mockAuth = MockAuthLocalDatasource();
    mockUser = MockUserLocalDatasource();

    sl.registerSingleton<RefreshNotifier>(RefreshNotifier());

    when(() => mockAuth.getUserId()).thenReturn('user-a');
    when(mockUser.getCurrentUser).thenReturn(currentUserDto);
  });

  tearDown(() {
    sl.reset();
  });

  group('PartnerBloc', () {
    late PartnerBloc bloc;

    setUp(() {
      bloc = PartnerBloc(
        searchUserUsecase: mockSearch,
        sendRequestUsecase: mockSend,
        getPartnershipsUsecase: mockGet,
        partnershipRepository: mockRepo,
        authLocalDatasource: mockAuth,
        userLocalDatasource: mockUser,
      );
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is initial', () {
      expect(bloc.state, const PartnerState.initial());
    });

    blocTest<PartnerBloc, PartnerState>(
      'loads connected partners and requests',
      build: () {
        when(() => mockGet(userId: any(named: 'userId'))).thenAnswer(
          (_) async => [connectedPartner, incomingRequest],
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const PartnerEvent.loadPartners()),
      expect: () => [
        const PartnerState.loading(),
        PartnerState.loaded(
          connectedPartners: [connectedPartner],
          incomingRequests: [incomingRequest],
        ),
      ],
    );

    blocTest<PartnerBloc, PartnerState>(
      'searches user preserving existing partners',
      build: () {
        when(() => mockGet(userId: any(named: 'userId'))).thenAnswer(
          (_) async => [connectedPartner, incomingRequest],
        );
        when(() => mockSearch(
          query: any(named: 'query'),
          currentUserId: any(named: 'currentUserId'),
        )).thenAnswer((_) async => searchUser);
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const PartnerEvent.loadPartners());
        await untilCalled(() => mockGet(userId: any(named: 'userId')));
        bloc.add(const PartnerEvent.searchUser(query: 'bob'));
      },
      expect: () => [
        const PartnerState.loading(),
        PartnerState.loaded(
          connectedPartners: [connectedPartner],
          incomingRequests: [incomingRequest],
        ),
        PartnerState.loaded(
          searchedUser: searchUser,
          connectedPartners: [connectedPartner],
          incomingRequests: [incomingRequest],
        ),
      ],
    );

    blocTest<PartnerBloc, PartnerState>(
      'sends request and adds to outgoing list',
      build: () {
        when(() => mockGet(userId: any(named: 'userId'))).thenAnswer(
          (_) async => [connectedPartner],
        );
        when(() => mockSend(any())).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const PartnerEvent.loadPartners());
        await untilCalled(() => mockGet(userId: any(named: 'userId')));
        bloc.add(PartnerEvent.sendRequest(user: searchUser));
      },
      expect: () => [
        const PartnerState.loading(),
        PartnerState.loaded(
          connectedPartners: [connectedPartner],
        ),
        isA<PartnerState>(),
      ],
    );

    blocTest<PartnerBloc, PartnerState>(
      'accepts incoming request',
      build: () {
        when(() => mockGet(userId: any(named: 'userId'))).thenAnswer(
          (_) async => [incomingRequest],
        );
        when(() => mockSend(any())).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const PartnerEvent.loadPartners());
        await untilCalled(() => mockGet(userId: any(named: 'userId')));
        bloc.add(PartnerEvent.acceptRequest(partnership: incomingRequest));
      },
      expect: () => [
        const PartnerState.loading(),
        PartnerState.loaded(
          incomingRequests: [incomingRequest],
        ),
        isA<PartnerState>(),
      ],
    );

    blocTest<PartnerBloc, PartnerState>(
      'rejects incoming request',
      build: () {
        when(() => mockGet(userId: any(named: 'userId'))).thenAnswer(
          (_) async => [incomingRequest],
        );
        when(() => mockSend(any())).thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const PartnerEvent.loadPartners());
        await untilCalled(() => mockGet(userId: any(named: 'userId')));
        bloc.add(PartnerEvent.rejectRequest(partnership: incomingRequest));
      },
      expect: () => [
        const PartnerState.loading(),
        PartnerState.loaded(
          incomingRequests: [incomingRequest],
        ),
        isA<PartnerState>(),
      ],
    );

    blocTest<PartnerBloc, PartnerState>(
      'removes partner',
      build: () {
        when(() => mockGet(userId: any(named: 'userId'))).thenAnswer(
          (_) async => [connectedPartner],
        );
        when(() => mockRepo.deletePartnership(any()))
            .thenAnswer((_) async {});
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const PartnerEvent.loadPartners());
        await untilCalled(() => mockGet(userId: any(named: 'userId')));
        bloc.add(const PartnerEvent.removePartner(partnershipId: 'p-1'));
      },
      expect: () => [
        const PartnerState.loading(),
        PartnerState.loaded(
          connectedPartners: [connectedPartner],
        ),
        PartnerState.loaded(),
      ],
    );

    blocTest<PartnerBloc, PartnerState>(
      'clearSearch resets searched user',
      build: () {
        when(() => mockGet(userId: any(named: 'userId'))).thenAnswer(
          (_) async => [connectedPartner],
        );
        when(() => mockSearch(
          query: any(named: 'query'),
          currentUserId: any(named: 'currentUserId'),
        )).thenAnswer((_) async => searchUser);
        return bloc;
      },
      act: (bloc) async {
        bloc.add(const PartnerEvent.loadPartners());
        await untilCalled(() => mockGet(userId: any(named: 'userId')));
        bloc.add(const PartnerEvent.searchUser(query: 'bob'));
        bloc.add(const PartnerEvent.clearSearch());
      },
      expect: () => [
        const PartnerState.loading(),
        PartnerState.loaded(
          connectedPartners: [connectedPartner],
        ),
        PartnerState.loaded(
          searchedUser: searchUser,
          connectedPartners: [connectedPartner],
        ),
        PartnerState.loaded(
          connectedPartners: [connectedPartner],
        ),
      ],
    );

    blocTest<PartnerBloc, PartnerState>(
      'emits error on failure',
      build: () {
        when(() => mockGet(userId: any(named: 'userId')))
            .thenThrow(Exception('Failed to load'));
        return bloc;
      },
      act: (bloc) => bloc.add(const PartnerEvent.loadPartners()),
      expect: () => [
        const PartnerState.loading(),
        const PartnerState.error(message: 'Exception: Failed to load'),
      ],
    );
  });
}
