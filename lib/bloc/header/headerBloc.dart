import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komsum/bloc/header/headerEvent.dart';
import 'package:komsum/bloc/header/headerState.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class HeaderBloc extends Bloc<HeaderEvent, HeaderState> {
  final http.Client httpClient = http.Client();

  HeaderBloc() : super(HeaderState(true));

  @override
  Stream<Transition<HeaderEvent, HeaderState>> transformEvents(
      Stream<HeaderEvent> events,
      TransitionFunction<HeaderEvent, HeaderState> transitionFn,
      ) {
    return super.transformEvents(
      events.throttleTime(const Duration(milliseconds: 1000)),
      transitionFn,
    );
  }

  @override
  Stream<HeaderState> mapEventToState(HeaderEvent event) async*{
    if(event is HeaderPinned) {
      yield state.copyWith(true);
    }else if(event is HeaderNotPinned) {
      yield state.copyWith(false);
    }
  }
}