part of 'device_bloc.dart';

abstract class DeviceEvents extends Equatable {
  @override
  List<Object> get props => [];
}

class StartEvent extends DeviceEvents {}

class DeviceEventStated extends DeviceEvents {
  // final String token;
  // ProfileEventStated({required this.token});
}
