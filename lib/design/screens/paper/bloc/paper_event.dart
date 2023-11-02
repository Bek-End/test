part of 'paper_bloc.dart';

sealed class PaperEvent extends Equatable {
  const PaperEvent();

  @override
  List<Object> get props => [];
}

class PaperInitEvent extends PaperEvent {}

class PaperGetPapersEvent extends PaperEvent {}

class PaperRefreshEvent extends PaperEvent {}

class PaperDetailEvent extends PaperEvent {
  const PaperDetailEvent({
    required this.paper,
  });

  final PaperModel paper;

  @override
  List<Object> get props => [...super.props, paper];
}
