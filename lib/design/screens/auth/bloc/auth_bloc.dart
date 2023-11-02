import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_test/data/repositories/local_repository.dart';
import 'package:local_test/data/repositories/remote_repository.dart';
import 'package:local_test/design/widgets/toast_widget.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required LocalRepository localRepo,
    required RemoteRepository remoteRepo,
  })  : _localRepo = localRepo,
        _remoteRepo = remoteRepo,
        super(AuthInitial()) {
    on<AuthInitEvent>(_initEvent);
    on<AuthRequestEvent>(_authRequestEvent);
  }

  final LocalRepository _localRepo;
  final RemoteRepository _remoteRepo;

  void _initEvent(AuthInitEvent even, Emitter<AuthState> emit) async {
    emit(AuthInProgressState());
    final profile = await _localRepo.getProfile();
    if (profile != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthNotState());
    }
  }

  void _authRequestEvent(AuthRequestEvent even, Emitter<AuthState> emit) async {
    emit(AuthInProgressState());
    final profile = await _remoteRepo.getProfile(
      username: even.username,
      password: even.password,
    );
    if (profile != null) {
      await _localRepo.addProfile(profile);
      emit(AuthSuccessState());
    } else {
      emit(AuthNotState());
      showToast('User not found');
    }
  }
}
