import 'package:dio/dio.dart';
import '/core/cache/locale_manager.dart';
import '/core/constants/constants.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final _localStorage = LocaleManager.instance;

  AuthInterceptor(this._dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // get tokens from local storage, you can use Hive or flutter_secure_storage
    final accessToken = _localStorage.getStringValue(TOKEN);
    // final refreshToken = _localStorage.getStringValue(REFRESH_TOKEN);

    // add access token to the request header
    options.headers["Authorization"] = "Bearer $accessToken";
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      // for some reasons the token can be invalidated before it is expired by the backend.
      // then we should navigate the user back to login page

      _performLogout(_dio);
    }

    return handler.next(err);
  }

  void _performLogout(Dio dio) {
    _dio.interceptors.requestLock.clear();
    _dio.interceptors.requestLock.lock();

    _localStorage.clearAll(); // remove token from local storage

    // back to login page without using context
    // check this https://stackoverflow.com/a/53397266/9101876
    // NavigationService.instance
    //     .navigateToPage(path: NavigationConstants.LOGIN);

    _dio.interceptors.requestLock.unlock();
  }

  // /// return true if it is successfully regenerate the access token
  // Future<bool> _regenerateAccessToken() async {
  //   try {
  //     var dio =
  //         Dio(); // should create new dio instance because the request interceptor is being locked

  //     // get refresh token from local storage
  //     final refreshToken = _localStorage.getStringValue(REFRESH_TOKEN);

  //     // make request to server to get the new access token from server using refresh token
  //     final response = await dio.post(
  //       "https://yourDomain.com/api/refresh",
  //       options: Options(headers: {"Authorization": "Bearer $refreshToken"}),
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final newAccessToken = response
  //           .data["accessToken"]; // parse data based on your JSON structure
  //       _localStorage.saveAccessToken(newAccessToken); // save to local storage
  //       return true;
  //     } else if (response.statusCode == 401 || response.statusCode == 403) {
  //       // it means your refresh token no longer valid now, it may be revoked by the backend
  //       _performLogout(_dio);
  //       return false;
  //     } else {
  //       print(response.statusCode);
  //       return false;
  //     }
  //   } on DioError {
  //     return false;
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
