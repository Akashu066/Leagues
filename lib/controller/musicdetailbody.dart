import 'package:flutter/material.dart';
import 'package:leauges/network/apiservice.dart';
import 'package:leauges/bloc/musiclist.dart';

class BuildmusicBody extends StatefulWidget {
  const BuildmusicBody({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  State<BuildmusicBody> createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildmusicBody> {
  // ignore: prefer_typing_uninitialized_variables
  late final musicListBloc;

  @override
  void initState() {
    musicListBloc = MusicListBloc(widget.id);
    musicListBloc.eventSink.add(MusicListAction.Fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Musiclist>>(
      stream: musicListBloc.musicListStream,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          final List<Musiclist>? posts = snapshot.data;
          return _buildmusicPosts(context, posts!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  ListView _buildmusicPosts(BuildContext context, List<Musiclist> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: ((context, index) {
        return GestureDetector(
          onTap: (() {
            setState(() {

            });
          }),
          child: Card(
            elevation: 4,
            child: Container(
              height: 100,
              margin: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        posts[index].thumbnailUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Text(
                      posts[index].title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
