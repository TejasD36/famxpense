import '../../../xcore.dart';

abstract interface class PartnershipLocalDatasource {
  Future<void> savePartnership(PartnershipDto partnership);
  Future<void> savePartnerships(List<PartnershipDto> partnerships);
  PartnershipDto? getPartnership(String id);
  List<PartnershipDto> getPartnerships();
  Future<void> deletePartnership(String id);
}
