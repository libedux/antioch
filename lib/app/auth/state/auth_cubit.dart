import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/auth/data/model/credential.dart';
import '../../../app/auth/state/auth_state.dart';
import '../../../app/auth/data/repository/auth_repository.dart';
import '../../../core/network/api_result.dart';

// cubit only responsible for passing data to repositories and
// rendering UI according to the response
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthInitial());

  Future<void> auth(Credential credential) async {
    ApiResult<dynamic> apiResult = const ApiResult.failure(error: '');
    emit(const AuthLoading());

    apiResult = await _authRepository.auth(credential);

    apiResult.when(success: (dynamic data) {
      emit(const AuthSuccess());
    }, failure: (String message) {
      emit(AuthError(message));
    });
  }
}
