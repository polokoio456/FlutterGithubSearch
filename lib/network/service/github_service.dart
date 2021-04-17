
import 'package:dio/dio.dart';
import 'package:flutter_github_search/network/model/github_search_result.dart';

abstract class IGithubService {

  Future<GithubSearchResult> search(String keyword, int page);

  IGithubService._();
}

class GithubService implements IGithubService {

  final Dio _githubSearchDio;

  GithubService(this._githubSearchDio);

  @override
  Future<GithubSearchResult> search(String keyword, int page) =>
      _githubSearchDio.get("/search/users?&per_page=20", queryParameters: {"q": keyword, "page": page})
      .then((response) => GithubSearchResult.fromJson(response.data));
}