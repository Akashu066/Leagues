import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:leauges/bloc/musicalbum.dart';
import 'package:leauges/bloc/search.dart';
import 'package:leauges/network/apiservice.dart';
import 'package:leauges/screens/musicdetailspage.dart';

class BuildBody extends StatefulWidget {
  const BuildBody({Key? key}) : super(key: key);

  @override
  State<BuildBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  Widget appBarTitle = const Text('Search Album',
      style: TextStyle(
        color: Colors.white,
      ));

  Icon alertIcon = const Icon(Icons.search);

  final musicBloc = MusicBloc();
  final musicSearchBloc = AlbunsearchBloc("");

  final TextEditingController _searchQuery = TextEditingController();

  // ignore: non_constant_identifier_names
  bool _IsSearching = false;
  // ignore: unused_field
  String _searchText = "";

  List<Post>? _list = [];

  final client = ResetClient(Dio(BaseOptions()));

  _BuildBodyState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    musicBloc.eventSink.add(MusicAction.Fetch);
    _IsSearching = false;
    _searchText = "";
    super.initState();
  }

  @override
  void dispose() {
    _searchQuery.dispose();
    super.dispose();
  }
  // final client = ResetClient(Dio(BaseOptions()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: _buildBar(context),
        ),
        body: _IsSearching ? _buildSearchList() : _buildList());
  }

  Widget _buildList() {
    return StreamBuilder<List<Post>>(
      stream: musicBloc.musicStream,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        } else {
          if (snapshot.hasData) {
            _list = snapshot.data;
            return ListView.builder(
              itemCount: _list?.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: ((context, index) {
                return Card(
                  elevation: 4,
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Musicdetailspage(
                            albumid: _list?[index].id ?? 0,
                            albumname: _list?[index].title ?? "",
                          ),
                        ),
                      );
                    }),
                    child: Text(
                      _list?[index].title ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      }),
    );
  }

  Widget _buildSearchList() {
    if (_searchQuery.text.isEmpty) {
      return _buildList();
    } else {
      return FutureBuilder(
        future: _getSearchedResults(_searchQuery.text),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              _list = snapshot.data as List<Post>?;
              return ListView.builder(
                itemCount: _list?.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: ((context, index) {
                  return Card(
                    elevation: 4,
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Musicdetailspage(
                              albumid: _list?[index].id ?? 0,
                              albumname: _list?[index].title ?? "",
                            ),
                          ),
                        );
                      }),
                      child: Text(
                        _list?[index].title ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        }),
      );
    }
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: appBarTitle,
      backgroundColor: Colors.blueGrey,
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                if (alertIcon.icon == Icons.search) {
                  alertIcon = const Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  appBarTitle = TextField(
                    controller: _searchQuery,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
            icon: alertIcon)
      ],
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      alertIcon = const Icon(
        Icons.search,
        color: Colors.white,
      );
      appBarTitle = const Text(
        "Search Album",
        style: TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
      musicBloc.eventSink.add(MusicAction.Fetch);
      _buildList();
    });
  }

  Future<List<Post>> _getSearchedResults(String data) async {
    return await client.getmusicTask(data);
  }
}

class ChildItem extends StatelessWidget {
  final String name;
  const ChildItem(this.name, {super.key});
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(name));
  }
}
