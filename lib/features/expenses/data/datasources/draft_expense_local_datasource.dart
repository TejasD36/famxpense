import '../../xcore.dart';

abstract interface class DraftExpenseLocalDatasource {
  Future<void> saveDraft(DraftExpenseDto draft);

  DraftExpenseDto? getDraft(String userId);

  Future<void> clearDraft(String userId);
}
