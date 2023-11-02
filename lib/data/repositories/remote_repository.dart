import 'package:local_test/data/models/paper_model.dart';
import 'package:local_test/data/models/profile_model.dart';

abstract class RemoteRepository {
  Future<ProfileModel?> getProfile({
    required String username,
    required String password,
  });
  Future<List<PaperModel>> getPapers({
    required int offset,
  });
  Future<PaperModel> getDetailPaper({
    required PaperModel paper,
  });
}
