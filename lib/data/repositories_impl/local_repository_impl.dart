import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_test/data/models/profile_model.dart';
import 'package:local_test/data/repositories/local_repository.dart';

class LocalRepositoryImpl extends LocalRepository {
  @override
  Future<ProfileModel?> getProfile() async {
    try {
      final hiveBox = await Hive.openBox<ProfileModel>('auth');
      final targetsFromHive = hiveBox.values.toList();
      await hiveBox.close();
      if (targetsFromHive.isEmpty) return null;
      return targetsFromHive.first;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool> addProfile(ProfileModel profile) async {
    try {
      final hiveBox = await Hive.openBox<ProfileModel>('auth');
      await hiveBox.add(profile);
      await hiveBox.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteProfile() async {
    try {
      final hiveBox = await Hive.openBox<ProfileModel>('auth');
      await hiveBox.clear();
      await hiveBox.close();
      return true;
    } catch (e) {
      return false;
    }
  }
}
