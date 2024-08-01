part of 'wait_for_bot_bloc.dart';

class WaitForBotState extends Equatable {
  const WaitForBotState({
    this.isWaiting = false,
  });

  final bool isWaiting;

  WaitForBotState copyWith({
    required bool isWaiting,
  }) {
    return WaitForBotState(
      isWaiting: isWaiting,
    );
  }

  @override
  List<Object> get props => [
        isWaiting,
      ];
}
