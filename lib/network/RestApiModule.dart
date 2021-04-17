
import 'package:dio/dio.dart';
import 'package:flutter_github_search/network/service/github_service.dart';

abstract class IRestApiModule {
  IGithubService get githubService;
}

class RestApiModule implements IRestApiModule {
  static const TIMEOUT_SEC = 10000;
  static const DOMAIN_BASE_URL = "https://api.github.com";

  LogInterceptor _logInterceptor;
  LogInterceptor get logInterceptor {
    _logInterceptor ??= LogInterceptor(requestBody: true, responseBody: true);
    return _logInterceptor;
  }

  Dio _githubSearchDio;
  Dio get githubSearchDio {
    _githubSearchDio ??= Dio(BaseOptions(connectTimeout: TIMEOUT_SEC, receiveTimeout: TIMEOUT_SEC))
      ..interceptors.add(logInterceptor)
      ..options.baseUrl = DOMAIN_BASE_URL;
    return _githubSearchDio;
  }

  GithubService _githubService;

  @override
  IGithubService get githubService {
    return _githubService ??= GithubService(githubSearchDio);
  }
}