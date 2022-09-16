import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'apiservice.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class ResetClient {
  factory ResetClient(Dio dio) = _ResetClient;
  @GET('albums')
  Future<List<Post>> getTask();

  @GET('albums/{id}/photos')
  Future<List<Musiclist>> getMusic(@Path('id') String id);

  @GET('albums')
  Future<List<Post>> getmusicTask(@Query('title') String title);

}

@JsonSerializable()
class Musiclist {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  Musiclist({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Musiclist.fromJson(Map<String, dynamic> json) =>
      _$MusiclistFromJson(json);
  Map<String, dynamic> toJson() => _$MusiclistToJson(this);
}

@JsonSerializable()
class Post {
  //int userid;
  int id;
  String title;

  Post({
    //required this.userid,
    required this.id,
    required this.title,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
