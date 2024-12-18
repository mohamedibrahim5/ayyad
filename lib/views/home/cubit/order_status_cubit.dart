import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/responses/track_order_model_response.dart';
import '../../../repository/repository.dart';
import '../../../shared/resources/constant.dart';
import '../../socket/socket_cubit.dart';

part 'order_status_state.dart';



enum OrderStatus {
  orderPlaced,
  preparingOrder,
  outForDelivery,
  orderDelivered,
  cancelOrder,
}

class OrderStatusCubit extends Cubit<OrderStatusState> {
  OrderStatusCubit({required this.repository}) : super(OrderStatusInitial());
  static OrderStatusCubit get(context) => BlocProvider.of(context);
  final Repository repository;

  Timer? timer;
  double currentValue1 = 0;
  double currentValue2 = 0;
  double currentValue3 = 0;
  static String orderStatus = '';

  TrackOrderModelResponse? trackOrderModelResponse;
  OrderStatus ? orderStatusEnum;





  Future<void> listen(
      SocketCubit socketCubit,
      ) async {
    socketCubit.internalStream?.listen(
          (socketData) async {
        Map<String, dynamic> jsonMap = json.decode(socketData);

        if (jsonMap[Constants.type] == Constants.createOrder || jsonMap[Constants.type] == Constants.prepareOrder || jsonMap[Constants.type] == Constants.outOfDelivery) {
          handleRideAccepted(jsonMap);
        }  else if (jsonMap[Constants.type] == Constants.deliveredOrder) {
          orderStatus = '' ;
          orderStatusEnum = OrderStatus.orderDelivered;
          emit(OrderStatusUpdatedDeliverd());
        }else {
          orderStatus = '' ;
          orderStatusEnum = OrderStatus.cancelOrder;
          emit(OrderStatusUpdated());
        }
      },
    );
  }

  handleRideAccepted(jsonMap) async {
    trackOrderModelResponse = TrackOrderModelResponse.fromJson(jsonMap);
    orderStatus = trackOrderModelResponse!.type!;
    resetValuesHome();
    resetValuesAtHome();
  }

  handleRideAcceptedModel(TrackOrderModelResponse trackOrderModel) async {
    trackOrderModelResponse = trackOrderModel;
    orderStatus = trackOrderModelResponse!.type!;
    resetValuesHome();
    resetValuesAtHome();
  }

  resetValuesAtHome(){
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (orderStatus == Constants.createOrder) {
        orderStatusEnum = OrderStatus.orderPlaced;
        if (currentValue1 == 0) {
          currentValue1 = 10;
        } else if (currentValue1 == 10) {
          currentValue1 = 100;
        } else if (currentValue1 == 100) {
          currentValue1 = 10;
        }
        emit(OrderStatusUpdated());
      }
      else if (orderStatus == Constants.prepareOrder) {
        orderStatusEnum = OrderStatus.preparingOrder;
        if (currentValue2 == 0) {
          currentValue2 = 10;
        } else if (currentValue2 == 10) {
          currentValue2 = 100;
        } else if (currentValue2 == 100) {
          currentValue2 = 10;
        }
        emit(OrderStatusUpdated());
      }
      else if (orderStatus == Constants.outOfDelivery) {
        orderStatusEnum = OrderStatus.outForDelivery;
          if (currentValue3 == 0) {
            currentValue3 = 10;
          }
          else if (currentValue3 == 10) {
            currentValue3 = 100;
          } else if (currentValue3 == 100) {
            currentValue3 = 10;
          }
        emit(OrderStatusUpdated());
      }
    });

  }


  void resetValuesHome() {
    currentValue1 = 0;
    currentValue2 = 0;
    currentValue3 = 0;
    emit(OrderStatusInitial());
  }

  trackOrderStatus() async {
    emit(OrderStatusInitial());
    final getHomeSuccessFailure = await repository.trackOrder();
    getHomeSuccessFailure.fold(
            (success) {
              if(success.data != null){
               // handleRideAccepted(success);
               handleRideAcceptedModel(success);
                // trackOrderModelResponse = success;
                // orderStatus = success.data!.type!;
              }

          // handleRideAccepted(success);
          emit(OrderStatusUpdated());
        },
            (failure) => emit(TrackErrorState(message: failure.message))
    );
  }

  void resetValues() {
    currentValue1 = 0;
    currentValue2 = 0;
    currentValue3 = 0;
    orderStatus = 'Order Placed';
    emit(OrderStatusInitial());
  }
  void startUpdatingValues() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (currentValue3 == 100) {
          timer.cancel();  // Stop the timer if the condition is met
          return;
        }

        if (timer.tick < 5) {
          if(currentValue1 == 0){
            currentValue1 = 10;
          }else if (currentValue1 == 10){
            currentValue1 = 100;
          }else if (currentValue1 == 100){
            currentValue1 = 10;
          }
        } else if (timer.tick < 10) {
          orderStatus = 'Preparing your order';
          currentValue1 = 100;
          if(currentValue2 == 0){
            currentValue2 = 10;
          }else if (currentValue2 == 10){
            currentValue2 = 100;
          }else if (currentValue2 == 100){
            currentValue2 = 10;
          }
        } else if (timer.tick < 15) {
          orderStatus = 'On the way';
          currentValue2 = 100;
          if(currentValue3 == 0){
            currentValue3 = 10;
          }else if (currentValue3 == 10){
            currentValue3 = 100;
          }else if (currentValue3 == 100){
            currentValue3 = 10;
          }
        }


        // if (currentValue1 < 100) {
        //   currentValue1 = currentValue1 + 10;
        // } else if (currentValue2 < 100) {
        //   orderStatus = 'Preparing your order ...';
        //   currentValue2 = currentValue2 + 10;
        // } else if (currentValue3 < 100) {
        //   orderStatus = 'On the way ...';
        //   currentValue3 = currentValue3 + 10;
        // }
        emit(OrderStatusUpdated());
      // Call setState or any other method to update the UI if needed
    });
  }

  void stopUpdatingValues() {
    timer?.cancel();  // Use this function to stop the timer manually if required
  }

}
