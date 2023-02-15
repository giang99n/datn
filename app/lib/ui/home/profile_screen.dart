import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_demo/blocs/get_infor/get_infor_bloc.dart';
import 'package:iot_demo/blocs/profile/profile_bloc.dart';
import 'package:iot_demo/configs/colors.dart';
import 'package:iot_demo/models/infor_res.dart';
import 'package:iot_demo/models/user_res.dart';
import 'package:iot_demo/network/apis.dart';
class ProFileScreen extends StatelessWidget {
  const ProFileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProFileBloc>(
            create: (_) => ProFileBloc()..add(ProFileEventStated())),
        // BlocProvider<GetInforBloc>(
        //     create: (_) => GetInforBloc()..add(GetInforEventStated())),
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
              const SizedBox(height: 16,),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                width: 100,
                height: 100,
                child: const Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
              const SizedBox(height: 8,),
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<ProFileBloc, ProFileState>(
                    builder: (context, state) {
                  if (state is ProFileLoadingState) {
                    return Container(
                        alignment: Alignment.topCenter,
                        height: size.height * 0.18,
                        child: const CircularProgressIndicator());
                  } else if (state is ProFileLoadedState) {
                    userResponse = state.listProfile;
                    User? user = userResponse.user;
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        user!.name.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
              ),
              Card(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<ProFileBloc, ProFileState>(
                          builder: (context, state) {
                        if (state is ProFileLoadingState) {
                          return Container(
                              alignment: Alignment.topCenter,
                              height: size.height * 0.18,
                              child: const CircularProgressIndicator());
                        } else if (state is ProFileLoadedState) {
                          userResponse = state.listProfile;
                          User? user = userResponse.user;
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
                    SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<ProFileBloc, ProFileState>(
                          builder: (context, state) {
                            if (state is ProFileLoadingState) {
                              return Container(
                                  alignment: Alignment.topCenter,
                                  height: size.height * 0.18,
                                  child: const CircularProgressIndicator());
                            } else if (state is ProFileLoadedState) {
                              userResponse = state.listProfile;
                              User? listProfileResponse = userResponse.user;
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
                                      child: Icon(
                                        Icons.email,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 15, 0, 5),
                                      child: Text(
                                        "Email: " + listProfileResponse!.email.toString(),
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
                    SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<ProFileBloc, ProFileState>(
                          builder: (context, state) {
                            if (state is ProFileLoadingState) {
                              return Container(
                                  alignment: Alignment.topCenter,
                                  height: size.height * 0.18,
                                  child: const CircularProgressIndicator());
                            } else if (state is ProFileLoadedState) {
                              userResponse = state.listProfile;
                              User? user = userResponse.user;
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 15, 0, 5),
                                      child: Text(
                                        "Họ tên:  " + user!.name.toString(),
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
                    SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<ProFileBloc, ProFileState>(
                          builder: (context, state) {
                            if (state is ProFileLoadingState) {
                              return Container(
                                  alignment: Alignment.topCenter,
                                  height: size.height * 0.18,
                                  child: const CircularProgressIndicator());
                            } else if (state is ProFileLoadedState) {
                              userResponse = state.listProfile;
                              User? user = userResponse.user;
                              return Align(
                                alignment: Alignment.topLeft,
                                child: Wrap(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(10, 10, 5, 5),
                                      child: Icon(
                                        Icons.location_on_sharp,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 15, 0, 5),
                                      child: Text(
                                        "Địa chỉ:  " + user!.location.toString(),
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
              SizedBox(
                width: size.width ,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  child: ElevatedButton(
                    child: const Text(
                      "Edit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: size.width ,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  child: ElevatedButton(
                    child: const Text(
                      "Change Password",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
