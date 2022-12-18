import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasenotes/src/bloc/auth_bloc/auth_repository.dart';
import 'package:firebasenotes/src/helpers/storage_helper.dart';
import 'package:firebasenotes/src/helpers/storage_key.dart';
import 'package:firebasenotes/src/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthRepository _repository = AuthRepository();

  createUser(UserModel userModel) async {
    emit(AuthLoading());
    try {
      UserCredential user =
          await _repository.createUser(userModel.email, userModel.password);
      String token = await user.user!.getIdToken();
      String uid = user.user!.uid;
      StorageHelper.writeData(StorageKey.token.name, token);
      StorageHelper.writeData(StorageKey.userId.name, uid);
      emit(AuthSuccess());
      userModel.id = uid;
      await _repository.storeUserData(userModel);
    } catch (ex) {
      emit(AuthError("error creating user"));
    }
  }

  loginUser(String email, String password) async {
    emit(AuthLoading());
    try {
      UserCredential user = await _repository.loginUser(email, password);

      String token = await user.user!.getIdToken();
      String uid = user.user!.uid;
      StorageHelper.writeData(StorageKey.token.name, token);
      StorageHelper.writeData(StorageKey.userId.name, uid);
      //TODO: store token, and id to the storage
      emit(AuthSuccess());
    } catch (ex) {
      emit(AuthError("errorMessage"));
    }
  }
}
