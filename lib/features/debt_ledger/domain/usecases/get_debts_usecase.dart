import '../../xcore.dart';

class GetDebtsUsecase {
  final DebtLedgerRepository _repository;

  GetDebtsUsecase({required DebtLedgerRepository repository}) : _repository = repository;

  Future<List<DebtLedgerEntity>> call({required String userId}) => _repository.getLedgers(userId: userId);
}
