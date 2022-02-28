import 'package:flutter/foundation.dart';

import '../../../../app/auth/data/model/user.dart';
import '../../../../core/base/model/response_model.dart';
import '../../../../core/cache/locale_manager.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../app/auth/data/model/credential.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/network_exceptions.dart';

class AuthRepository {
  late DioClient dioClient;

  AuthRepository() {
    dioClient = DioClient();
  }

  Future<ApiResult<dynamic>> auth(Credential credential) async {
    try {
      String endpoint = describeEnum(credential.authType);
      var response = await dioClient.post('/${endpoint}', data: credential.toJson());
      ResponseModel responseModel = ResponseModel.fromJson(response);

      if (responseModel.success == true) {
        var user = User.fromJson(responseModel.data?.first);
        LocaleManager.instance.setStringValue(TOKEN, responseModel.data?.first['token']);
        return ApiResult.success(data: user);
      } else {
        return ApiResult.failure(error: responseModel.message);
      }
    } catch (e) {
      String message = NetworkExceptions.getErrorMessage(NetworkExceptions.getDioException(e));
      return ApiResult.failure(error: message);
    }
  }
}
