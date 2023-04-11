abstract class APIConnectionState {}

class ConnnectionInitState extends APIConnectionState {}

class HasConnectionState extends APIConnectionState {}

class NoConnectionState extends APIConnectionState {}

class ConnectionTimedOutState extends APIConnectionState {}
