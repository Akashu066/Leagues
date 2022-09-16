import 'package:dio/dio.dart';
import 'package:leauges/network/apiservice.dart';
import 'dart:async';

// ignore: constant_identifier_names
enum MusicAction { Fetch }

class MusicBloc {
  final _stateStreamController = StreamController<List<Post>>.broadcast();

  StreamSink<List<Post>> get _musicSink => _stateStreamController.sink;

  Stream<List<Post>> get musicStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<MusicAction>.broadcast();

  StreamSink<MusicAction> get eventSink => _eventStreamController.sink;

  Stream<MusicAction> get _eventStream => _eventStreamController.stream;

  final client = ResetClient(Dio(BaseOptions()));

  MusicBloc() {
    _eventStream.listen((event) async {
      if (event == MusicAction.Fetch) {
        try {
          var musics = await client.getTask();
          // ignore: unnecessary_null_comparison
          if (musics != null) {
            _musicSink.add(musics);
            // print(musics);
          } else {
            _musicSink.addError('Something went wrong');
          }
        // ignore: unused_catch_clause
        } on Exception catch (e) {
          _musicSink.addError('Something went wrong');
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
