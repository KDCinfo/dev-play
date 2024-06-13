part of 'wait_for_bot_bloc.dart';

abstract class WaitForBotEvent extends Equatable {
  const WaitForBotEvent();
}

class WaitForBotOnEvent extends WaitForBotEvent {
  const WaitForBotOnEvent();

  @override
  List<Object> get props => [];
}

class WaitForBotOffEvent extends WaitForBotEvent {
  const WaitForBotOffEvent();

  @override
  List<Object> get props => [];
}
