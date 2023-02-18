
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../datasource/models/devices_res.dart';
import '../../datasource/network/apis.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvents, DeviceState> {
  DeviceBloc() : super(DeviceLoadingState());

  @override
  Stream<DeviceState> mapEventToState(DeviceEvents event) async* {
    final apiRepository = Api();
    final pref = await SharedPreferences.getInstance();
    String token = (pref.getString('token') ?? "");
    String email = (pref.getString('email') ?? "");
    if (event is StartEvent) {
      yield DeviceInitState();
    } else if (event is DeviceEventStated) {
      yield DeviceLoadingState();
      var data = await apiRepository.getDevice(token,email);
      if (data != null) {
          yield GetDeviceLoadedState(listDevice: data);
      } else {
        yield GetDeviceErrorState();
      }
    }
  }
}
