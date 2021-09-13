import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spsr/data/models/user_sp_model.dart';
import 'package:spsr/data/models/user_sr_model.dart';
import 'package:spsr/data/repositories/auth_repo.dart';
import 'package:spsr/data/dataproviders/api_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void loginSpUser(String loginId, String refrence) async {
    try {
      //Emit Auth Loading
      emit(AuthLoading());

      await Future.delayed(const Duration(seconds: 2));

      final data =
          await APIWeb().post(AuthRepository.loginSp(loginId, refrence));

      // yield ProductState(products: data);
      //Emit Auth Loading
      emit(AuthLoginSPSuccess(spUser: data));
    } catch (e) {
      print(e.toString());
      emit(AuthFailure());
    }
  }

  void loginSrUser(String loginId, String refrence) async {
    try {
      //Emit Auth Loading
      emit(AuthLoading());

      await Future.delayed(const Duration(seconds: 2));

      final data =
          await APIWeb().post(AuthRepository.loginSr(loginId, refrence));

      // yield ProductState(products: data);
      //Emit Auth Loading
      emit(AuthLoginSRSuccess(srUser: data));
    } catch (e) {
      emit(AuthFailure());
    }
  }
}
