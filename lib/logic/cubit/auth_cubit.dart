import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spsr/data/models/user_sp_model.dart';
import 'package:spsr/data/models/user_sr_model.dart';
import 'package:spsr/data/repositories/auth_repo.dart';
import 'package:spsr/data/dataproviders/api_service.dart';
import 'package:spsr/data/utility/user_data.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  //For Real Login By User
  void loginSpUser(String loginId, String refrence) async {
    try {
      //Emit Auth Loading
      emit(AuthLoading());

      await Future.delayed(const Duration(seconds: 2));

      final data =
          await APIWeb().post(AuthRepository.loginSp(loginId, refrence));

      //Save User Data Locally
      User.setUserAsLogined(spUser: data);
      //Emit Auth Loading

      emit(AuthLoginSPSuccess(spUser: data));
    } catch (e) {
      print(e.toString());
      emit(AuthFailure(erroMsg: e.toString()));
    }
  }

  //For Real Login By User
  void loginSrUser(String loginId, String refrence) async {
    try {
      //Emit Auth Loading
      emit(AuthLoading());

      await Future.delayed(const Duration(seconds: 2));

      final data =
          await APIWeb().post(AuthRepository.loginSr(loginId, refrence));

      //Save User Data Locally
      User.setUserAsLogined(srUser: data);
      //Emit Auth Loading
      emit(AuthLoginSRSuccess(srUser: data));
    } catch (e) {
      emit(AuthFailure(erroMsg: e.toString()));
    }
  }

  //For Backend Automatic Login of the Appropriate User.

  //For Real Login By User
  void loginSPSrUserBackend({SPModel? spUser, SRModel? srUser}) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      //Save SP User Locally
      if (spUser != null) {
        emit(AuthLoginSPSuccess(spUser: spUser));
      } else if (srUser != null) {
        emit(AuthLoginSRSuccess(srUser: srUser));
      }
    } catch (e) {
      emit(AuthFailure(erroMsg: e.toString()));
    }
  }

//Emit Need To Login State

  void emitAuthInitialState() {
    emit(AuthInitial());
  }
}
