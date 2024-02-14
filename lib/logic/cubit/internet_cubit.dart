import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_using_bloc/constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState>{
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit(this.connectivity) : super(InternetLoading()){
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
              if(connectivityResult == ConnectivityResult.wifi){
                emitInternetConnected(ConnectionType.Wifi);
              }else if(connectivityResult == ConnectivityResult.mobile){
                emitInternetConnected(ConnectionType.Mobile);
              } else if(connectivityResult == ConnectivityResult.none){
                emitInternetDisconnected();
              }
            });
  }


  void emitInternetConnected (ConnectionType connectionType) =>
      emit(InternetConnected(connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close(){
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}