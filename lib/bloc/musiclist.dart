import 'dart:async';

import 'package:dio/dio.dart';

import '../network/apiservice.dart';

// ignore: constant_identifier_names
enum MusicListAction { Fetch }

class MusicListBloc {
  final _stateStreamController = StreamController<List<Musiclist>>.broadcast();

  StreamSink<List<Musiclist>> get _musicListSink => _stateStreamController.sink;

  Stream<List<Musiclist>> get musicListStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<MusicListAction>.broadcast();

  StreamSink<MusicListAction> get eventSink => _eventStreamController.sink;

  Stream<MusicListAction> get _eventStream => _eventStreamController.stream;

  final client = ResetClient(Dio(BaseOptions()));
  int id;

  MusicListBloc(this.id) {
    _eventStream.listen((event) async {
      if (event == MusicListAction.Fetch) {
        try {
          var musicList = await client.getMusic(id.toString());
          // ignore: unnecessary_null_comparison
          if (musicList != null) {
            _musicListSink.add(musicList);
            // print(musicList);
          } else {
            _musicListSink.addError('Something went wrong');
          }
        // ignore: unused_catch_clause
        } on Exception catch (e) {
          _musicListSink.addError('Something went wrong');
        }
      }
    });
  }

  @override
  // ignore: override_on_non_overriding_member
  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
