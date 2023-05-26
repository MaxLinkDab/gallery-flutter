part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  final int? page;
  final List<Post>? posts;
  final User? user;

  const PopularState({
    this.page,
    this.posts,
    this.user,
  });
}

class PopularLoading extends PopularState {
  @override
  List<Object?> get props => [];
}

class PopularLoaded extends PopularState {
  const PopularLoaded({
    required super.page,
    required super.posts,
    super.user,
  });

  @override
  List<Object?> get props => [posts, page];

  PopularLoaded copyWith({
    int? page,
    List<Post>? posts,
    User? user,
  }) {
    return PopularLoaded(
      page: page ?? this.page,
      posts: posts ?? this.posts,
      user: user ?? this.user,
    );
  }
}

class PopularError extends PopularState {
  final String error;
  const PopularError({
    required this.error,
  });
  @override
  List<Object?> get props => [error];
}
