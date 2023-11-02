import 'package:local_test/data/models/paper_model.dart';
import 'package:local_test/data/models/profile_model.dart';
import 'package:local_test/data/repositories/remote_repository.dart';

class RemoteRepositoryImpl implements RemoteRepository {
  @override
  Future<ProfileModel?> getProfile({
    required String username,
    required String password,
  }) async {
    const profile = ProfileModel(
      username: 'admin',
      password: 'password123',
    );

    if (profile.username == username && profile.password == password) {
      return profile;
    }

    return null;
  }

  @override
  Future<List<PaperModel>> getPapers({required int offset}) async {
    final papers = <PaperModel>[];
    for (var i = 0; i < 10; i++) {
      papers.add(PaperModel(
        title: 'Title $i',
        descr:
            'Descr $offset Descr $offset Descr $offset Descr $offset Descr $offset Descr $offset Descr $offset',
      ));
    }
    return papers;
  }

  @override
  Future<PaperModel> getDetailPaper({required PaperModel paper}) async {
    return PaperModel(
      title: paper.title,
      descr: paper.descr,
      createdAt: DateTime.now(),
    );
  }
}
