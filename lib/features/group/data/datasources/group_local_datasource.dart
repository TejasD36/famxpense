import '../../xcore.dart';

abstract interface class GroupLocalDatasource {
  Future<void> saveGroup(GroupDto group);

  Future<List<GroupDto>> getGroups();

  Future<void> deleteGroup(String groupId);
}
