import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_demo/blocs/get_infor/get_infor_bloc.dart';
import 'package:iot_demo/blocs/profile/profile_bloc.dart';
import 'package:iot_demo/configs/colors.dart';
import 'package:iot_demo/models/infor_res.dart';
import 'package:iot_demo/models/user_res.dart';
import 'package:iot_demo/network/apis.dart';
class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProFileBloc>(
            create: (_) => DeviceBloc()..add(DeviceEventStated())),
      ],
      child: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ProFileBloc? profileBloc;
  Api? api;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    UserResponse userResponse;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Card(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<DeviceBloc, DeviceState>(
                          builder: (context, state) {
                            if (state is DeviceLoadingState) {
                              return Container(
                                  alignment: Alignment.topCenter,
                                  height: size.height * 0.18,
                                  child: const CircularProgressIndicator());
                            } else if (state is DeviceLoadedState) {
                              // userResponse = state.listProfile;
                              // User? user = userResponse.user;
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 15, 0, 5),
                                      child: Text(
                                        "Điện thoại: " + user!.phone.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle( fontStyle: FontStyle.italic,
                                          fontSize: 15, ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 64,),
            ],
          ),
        ),
      ),
    );
  }
}
