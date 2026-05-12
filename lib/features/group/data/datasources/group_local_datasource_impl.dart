import '../../xcore.dart';

class GroupLocalDatasourceImpl extends BaseHiveService<GroupDto> implements GroupLocalDatasource {
  GroupLocalDatasourceImpl() : super(Hive.box<GroupDto>(HiveBoxes.groups));

  @override
  Future<void> saveGroup(GroupDto group) async {
    await put(key: group.id, value: group);
  }

  @override
  Future<List<GroupDto>> getGroups() async {
    return getAll();
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    await delete(groupId);
  }
}
