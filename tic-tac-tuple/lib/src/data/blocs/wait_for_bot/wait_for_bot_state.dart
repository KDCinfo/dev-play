part of 'wait_for_bot_bloc.dart';

class WaitForBotState extends Equatable {
  const WaitForBotState({
    this.isWaiting = false,
  });

  final bool isWaiting;

  WaitForBotState copyWith({
    required bool botIsThinking,
  }) {
    return WaitForBotState(
      isWaiting: botIsThinking,
    );
  }

  @override
  List<Object> get props => [
        isWaiting,
      ];
}
