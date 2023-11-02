import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_test/data/models/profile_model.dart';

abstract class LocalRepository {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProfileModelAdapter());
  }

  Future<ProfileModel?> getProfile();
  Future<bool> addProfile(ProfileModel profile);
  Future<bool> deleteProfile();
}
