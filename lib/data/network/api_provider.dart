/// 산클 메인 서비스에서 사용하는 API 관리 */
class ApiProvider {
  static final ApiProvider _apiProvider = new ApiProvider._internal();

  static ApiProvider get instance => _apiProvider;

  ApiProvider._internal();
}
