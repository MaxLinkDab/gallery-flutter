import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gallery/data/repository.dart';
import 'package:gallery/domain/entity/post.dart';
import 'package:gallery/domain/entity/user.dart';

import '../../../const.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  PopularBloc() : super(PopularLoading()) {
    on<GetPopularPost>(_onGetPopularPost);
    on<RefreshPopularPost>(_onRefreshPopularPost);
    on<GetUserData>(_onGetUserData);
  }
  final _repository = Repository();

  _onGetPopularPost(GetPopularPost event, Emitter emit) async {
    try {
      List<Post> post = await _getNewPost(
          'popular', state.page != null ? state.page! + 1 : 1);

      emit(PopularLoaded(
          page: state.page != null ? state.page! + 1 : 1,
          posts: state.posts != null ? state.posts! + post : post));
    } catch (e) {
      emit(PopularError(error: e.toString()));
    }
  }

  _onRefreshPopularPost(RefreshPopularPost event, Emitter emit) async {
    emit(PopularLoading());

    try {
      List<Post> post = await _getNewPost('popular', 1);

      emit(PopularLoaded(page: 1, posts: post));
    } catch (e) {
      emit(PopularError(error: e.toString()));
    }
  }

  Future<List<Post>> _getNewPost(String trend, int page) async {
    List<Post> post =
        await _repository.getPosts(trend: trend, limit: 10, page: page);
    for (int i = 0; i < post.length; i++) {
      if (post[i].image?.name == null) {
        post.removeAt(i);
      } else {
        post[i].image?.name = baseUrl + mediaUrl + post[i].image!.name;
      }
    }
    return post;
  }

  _onGetUserData(GetUserData event, Emitter emit) async {
    int id = int.parse(event.id.split('/').last);
    User user = await _repository.getUserInfo(id);
    emit(PopularLoaded(page: state.page, posts: state.posts, user: user));
  }
}
