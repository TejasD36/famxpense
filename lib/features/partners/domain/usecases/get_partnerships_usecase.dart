import '../../xcore.dart';

class GetPartnershipsUsecase {
  final PartnershipRepository _repository;

  GetPartnershipsUsecase(this._repository);

  Future<List<PartnershipEntity>> call({required String userId}) async {
    return _repository.getPartnerships(userId: userId);
  }
}
