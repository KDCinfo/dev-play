import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wait_for_bot_event.dart';
part 'wait_for_bot_state.dart';

class WaitForBotBloc extends Bloc<WaitForBotEvent, WaitForBotState> {
  WaitForBotBloc() : super(const WaitForBotState()) {
    on<WaitForBotOnEvent>(_updateWaiterOn);
    on<WaitForBotOffEvent>(_updateWaiterOff);
  }

  void _updateWaiterOn(
    WaitForBotOnEvent event,
    Emitter<WaitForBotState> emit,
  ) {
    emit(state.copyWith(isWaiting: true));
  }

  void _updateWaiterOff(
    WaitForBotOffEvent event,
    Emitter<WaitForBotState> emit,
  ) {
    emit(state.copyWith(isWaiting: false));
  }
}
