abstract class APIConnectionState {}

class ConnnectionInitState extends APIConnectionState {}

class HasConnectionState extends APIConnectionState {}

class NoConnectionState extends APIConnectionState {}
class ConnectingState extends APIConnectionState {
  final double percentage;
  ConnectingState ({required this.percentage});
}

class ConnectionTimedOutState extends APIConnectionState {}
