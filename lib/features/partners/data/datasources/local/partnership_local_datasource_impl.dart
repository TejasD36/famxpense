import '../../../xcore.dart';

class PartnershipLocalDatasourceImpl extends BaseHiveService<PartnershipDto>
    implements PartnershipLocalDatasource {
  PartnershipLocalDatasourceImpl()
    : super(Hive.box<PartnershipDto>(HiveBoxes.partnerships));

  @override
  Future<void> savePartnership(PartnershipDto partnership) async {
    await put(key: partnership.id, value: partnership);
  }

  @override
  Future<void> savePartnerships(List<PartnershipDto> partnerships) async {
    for (final p in partnerships) {
      await savePartnership(p);
    }
  }

  @override
  PartnershipDto? getPartnership(String id) => get(id);

  @override
  List<PartnershipDto> getPartnerships() => getAll();

  @override
  Future<void> deletePartnership(String id) async {
    await delete(id);
  }
}
