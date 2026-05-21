import '../../xcore.dart';

class SendPartnershipRequestUsecase {
  final PartnershipRepository _repository;

  SendPartnershipRequestUsecase(this._repository);

  Future<void> call(PartnershipEntity partnership) async {
    await _repository.sendRequest(partnership);
  }
}
