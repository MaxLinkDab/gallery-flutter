import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../const.dart';
import '../../../data/repository.dart';
import '../../entity/post.dart';
import '../../entity/user.dart';

part 'new_event.dart';
part 'new_state.dart';

class NewBloc extends Bloc<NewEvent, NewState> {
  NewBloc() : super(NewLoading()) {
    on<GetNewPost>(_onGetNewPost);
    on<RefreshNewPost>(_onRefreshNewPost);
    on<GetUserData>(_onGetUserData);
  }
  final _repository = Repository();

  _onGetNewPost(GetNewPost event, Emitter emit) async {
    try {
      List<Post> post =
          await _getNewPost('new', state.page != null ? state.page! + 1 : 1);
      emit(NewLoaded(
          page: state.page != null ? state.page! + 1 : 1,
          posts: state.posts != null ? state.posts! + post : post));
    } catch (e) {
      emit(NewError(error: e.toString()));
    }
  }

  _onRefreshNewPost(RefreshNewPost event, Emitter emit) async {
    try {
      emit(NewLoading());
      List<Post> post = await _getNewPost('new', 1);
      emit(NewLoaded(page: 1, posts: post));
    } catch (e) {
      emit(NewError(error: e.toString()));
    }
  }

  _onGetUserData(GetUserData event, Emitter emit) async {
    int id = int.parse(event.id.split('/').last);
    User user = await _repository.getUserInfo(id);
    emit(NewLoaded(page: state.page, posts: state.posts, user: user));
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
}
