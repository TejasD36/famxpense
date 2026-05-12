import '../../xcore.dart';

class DraftExpenseLocalDatasourceImpl extends BaseHiveService<DraftExpenseDto> implements DraftExpenseLocalDatasource {
  DraftExpenseLocalDatasourceImpl() : super(Hive.box<DraftExpenseDto>(HiveBoxes.draftExpenses));

  String _draftKey(String userId) => 'draft_$userId';

  @override
  Future<void> saveDraft(DraftExpenseDto draft) async {
    await put(key: _draftKey(draft.userId), value: draft);
  }

  @override
  DraftExpenseDto? getDraft(String userId) {
    return get(_draftKey(userId));
  }

  @override
  Future<void> clearDraft(String userId) async {
    await delete(_draftKey(userId));
  }
}
