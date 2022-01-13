import 'package:equatable/equatable.dart';

class HeaderState extends Equatable {
  final bool isPinned;

  const HeaderState([this.isPinned = true]);

  HeaderState copyWith(bool isPinned) {
    return HeaderState(isPinned ?? this.isPinned);
  }

  @override
  List<Object> get props => [isPinned];
}