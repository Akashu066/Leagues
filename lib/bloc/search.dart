import 'dart:async';

import 'package:dio/dio.dart';

import '../network/apiservice.dart';

class AlbunsearchBloc {
  final _stateStreamController = StreamController<List<Post>>.broadcast();

  StreamSink<List<Post>> get _musicListSink => _stateStreamController.sink;

  Stream<List<Post>> get musicsearchStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<String>.broadcast();

  StreamSink<String> get eventSink => _eventStreamController.sink;

  Stream<String> get _eventStream => _eventStreamController.stream;

  final client = ResetClient(Dio(BaseOptions()));
  String albumname;

  AlbunsearchBloc(this.albumname) {
    _eventStream.listen((event) async {
      try {
        var musicList = await client.getmusicTask(albumname);
        // ignore: unnecessary_null_comparison
        if (musicList != null) {
          _musicListSink.add(musicList);
          //print(musicList);
        } else {
          _musicListSink.addError('Something went wrong');
        }
      // ignore: unused_catch_clause
      } on Exception catch (e) {
        _musicListSink.addError('Something went wrong');
      }
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  void dispose() {
    _eventStreamController.close();
    _stateStreamController.close();
  }
}
