part of 'device_bloc.dart';

class DeviceState extends Equatable {
  @override
  List<Object> get props => [];
}

class DeviceInitState extends DeviceState {}

class DeviceLoadingState extends DeviceState {}

class GetDeviceErrorState extends DeviceState {}

class GetDeviceLoadedState extends DeviceState {
  final DeviceResponse listDevice;

  GetDeviceLoadedState({required this.listDevice});

  @override
  List<Object> get props => [listDevice];
}
