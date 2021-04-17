
import 'package:json_annotation/json_annotation.dart';

part 'github_search_result.g.dart';

@JsonSerializable()
class GithubSearchResult extends Object {
  @JsonKey(name: 'total_count')
  int totalCount;

  @JsonKey(name: 'incomplete_results')
  bool incompleteResult;

  @JsonKey(name: 'items')
  List<GithubUser> userList;

  GithubSearchResult(this.totalCount, this.incompleteResult, this.userList);

  factory GithubSearchResult.fromJson(Map<String, dynamic> srcJson) => _$GithubSearchResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GithubSearchResultToJson(this);
}

@JsonSerializable()
class GithubUser extends Object {
  @JsonKey(name: 'login')
  String name;

  @JsonKey(name: 'avatar_url')
  String avatar;

  GithubUser(this.name, this.avatar);

  factory GithubUser.fromJson(Map<String, dynamic> srcJson) => _$GithubUserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GithubUserToJson(this);
}