import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_test/data/models/paper_model.dart';
import 'package:local_test/data/repositories/remote_repository.dart';

part 'paper_event.dart';
part 'paper_state.dart';

class PaperBloc extends Bloc<PaperEvent, PaperState> {
  PaperBloc({
    required RemoteRepository remoteRepo,
  })  : _remoteRepo = remoteRepo,
        super(PaperInitial()) {
    on<PaperInitEvent>(_initEvent);
    on<PaperGetPapersEvent>(_getPapersEvent);
    on<PaperRefreshEvent>(_refreshEvent);
    on<PaperDetailEvent>(_detailEvent);
  }

  final RemoteRepository _remoteRepo;
  int _offset = 0;

  void _initEvent(PaperInitEvent even, Emitter<PaperState> emit) async {
    _offset = 1;
    emit(PaperLoadingState());
    final papers = await _remoteRepo.getPapers(offset: _offset);
    emit(PaperCompleteState(papers: papers));
  }

  void _getPapersEvent(
      PaperGetPapersEvent even, Emitter<PaperState> emit) async {
    emit(PaperLoadingState());
    final papers = await _remoteRepo.getPapers(offset: _offset);
    emit(PaperCompleteState(papers: papers));
  }

  void _refreshEvent(PaperRefreshEvent even, Emitter<PaperState> emit) async {
    _offset++;
    emit(PaperLoadingState());
    final papers = await _remoteRepo.getPapers(offset: _offset);
    emit(PaperCompleteState(papers: papers));
  }

  void _detailEvent(PaperDetailEvent even, Emitter<PaperState> emit) async {
    emit(PaperLoadingState());
    final paper = await _remoteRepo.getDetailPaper(paper: even.paper);
    emit(PaperDetailState(paper: paper));
  }
}
