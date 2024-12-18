import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ibnelbarh/views/cart/screen/cart_screen.dart';
import 'package:ibnelbarh/views/home/screen/home_screen.dart';
import 'package:ibnelbarh/views/settings/screen/settings_screen.dart';

import '../../../shared/resources/enums.dart';

part 'base_screen_navigation_state.dart';

class BaseScreenNavigationCubit extends Cubit<BaseScreenNavigationState> {
  int currentIndex = 0;
  TabController? tabController;


  // BaseScreenNavigationCubit()
  //     : super(BaseScreenNavigationInitial(
  //     navigationBarTab: HomeNavigationBarTabs.home, index: 0));
  static BaseScreenNavigationCubit get(context)=>BlocProvider.of(context);
  //
  void getNavBarItem(HomeNavigationBarTabs tabs) {
    switch (tabs) {
      case HomeNavigationBarTabs.home:
        currentIndex = 0;
        emit(NavigationBarStateSucces());
        break;
      case HomeNavigationBarTabs.cart:
        currentIndex = 1;
        emit(NavigationBarStateSucces());
        // emit(BaseScreenNavigationInitial(
        //     navigationBarTab: HomeNavigationBarTabs.cart, index: 1));
        break;
      case HomeNavigationBarTabs.settings:
        currentIndex = 2;
        emit(NavigationBarStateSucces());
        // emit(BaseScreenNavigationInitial(
        //     navigationBarTab: HomeNavigationBarTabs.settings, index: 2));
        break;
    }
  }
  //
  reset(){
    emit(NevbarInitial());
    tabController!.animateTo(0);
    currentIndex = 0;
    // emit(BaseScreenNavigationInitial(
    //     navigationBarTab: HomeNavigationBarTabs.home, index: 0));
    emit(NavigationBarStateSucces());
  }
  //
  //
  reset2(){
    emit(NevbarInitial());
    tabController!.animateTo(1);
    currentIndex = 1;
    // emit(BaseScreenNavigationInitial(
    //     navigationBarTab: HomeNavigationBarTabs.home, index: 0));
    emit(NavigationBarStateSucces());

    // emit(NevbarInitial());
    // currentIndex = 1;
    // emit(NavigationBarStateSucces());
  }

  reset3(){
    emit(NevbarInitial());
    tabController!.animateTo(2);
    currentIndex = 2;
    // emit(BaseScreenNavigationInitial(
    //     navigationBarTab: HomeNavigationBarTabs.home, index: 0));
    emit(NavigationBarStateSucces());
  }

  BaseScreenNavigationCubit() : super(NevbarInitial());



  // List<Widget> patientBottomScreens = const [
  //   HomeScreen(
  //     guest:false ,
  //   ),
  //   CartScreen(),
  //   SettingsScreen(),
  //
  // ];
  List<Widget> bottomScreens(bool guest) {
    return [
      HomeScreen(
        guest: guest,
      ),
      const CartScreen(),
      const SettingsScreen(),
    ];
  }

  void changeBottom(int index) {
    currentIndex = index;
    emit(NavigationBarStateSucces());
  }


}
