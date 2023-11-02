part of 'paper_bloc.dart';

sealed class PaperState extends Equatable {
  const PaperState();

  @override
  List<Object> get props => [];
}

final class PaperInitial extends PaperState {}

final class PaperLoadingState extends PaperState {}

final class PaperDetailState extends PaperState {
  const PaperDetailState({
    required this.paper,
  });

  final PaperModel paper;

  @override
  List<Object> get props => [...super.props, paper];
}

final class PaperCompleteState extends PaperState {
  const PaperCompleteState({
    required this.papers,
  });

  final List<PaperModel> papers;

  @override
  List<Object> get props => [...super.props, papers];
}
