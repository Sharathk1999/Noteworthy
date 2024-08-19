part of 'note_cubit.dart';

sealed class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

final class NoteInitial extends NoteState {

    @override
  List<Object> get props => [];
}

final class NoteLoading extends NoteState {

    @override
  List<Object> get props => [];
}
final class NoteFailure extends NoteState {

    @override
  List<Object> get props => [];
}
final class NoteLoaded extends NoteState {
  final List<NoteEntity> notes;

 const NoteLoaded({required this.notes});
    @override
  List<Object> get props => [];
}
