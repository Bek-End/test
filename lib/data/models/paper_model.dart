import 'package:equatable/equatable.dart';

class PaperModel extends Equatable {
  const PaperModel({
    required this.title,
    required this.descr,
    this.createdAt,
  });

  final String title;
  final String descr;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [title, descr, createdAt];
}
