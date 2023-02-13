import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogincubit/src/cubit/auth/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

final AuthRepo repo=AuthRepo();

  loginWithEmailPassword(String email, String password)async{
    UserCredential loggedInUser;
    emit(AuthLoading());
    try{
      UserCredential userCredential=await repo.loginWithEmailPassword(email, password);
      if(userCredential==null){

        emit(AuthError());
        await Future.delayed(Duration(seconds: 2));
        emit(AuthInitial());
      }else{
        emit(AuthLoaded(userCredential));
      }
    }catch(ex){
      emit(AuthError());
    }
  }
  registerWithEmailPassword(String email, String password) async{
    emit(AuthLoading());
    try{
      UserCredential userCredential= await repo.registerWithEmailPassword(email, password);
      if(userCredential==null){
        emit(AuthError());
        await Future.delayed(Duration(seconds: 2));
        emit(AuthInitial());
      }else{
        emit(AuthLoaded(userCredential));
      }
    }catch(ex){
      emit(AuthError());
    }
  }

}
