// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostStore on _PostStore, Store {
  late final _$postsFutureAtom =
      Atom(name: '_PostStore.postsFuture', context: context);

  @override
  ObservableFuture<List<PostModel>>? get postsFuture {
    _$postsFutureAtom.reportRead();
    return super.postsFuture;
  }

  @override
  set postsFuture(ObservableFuture<List<PostModel>>? value) {
    _$postsFutureAtom.reportWrite(value, super.postsFuture, () {
      super.postsFuture = value;
    });
  }

  late final _$postFutureAtom =
      Atom(name: '_PostStore.postFuture', context: context);

  @override
  ObservableFuture<PostModel>? get postFuture {
    _$postFutureAtom.reportRead();
    return super.postFuture;
  }

  @override
  set postFuture(ObservableFuture<PostModel>? value) {
    _$postFutureAtom.reportWrite(value, super.postFuture, () {
      super.postFuture = value;
    });
  }

  late final _$fetchPostsAsyncAction =
      AsyncAction('_PostStore.fetchPosts', context: context);

  @override
  Future<void> fetchPosts() {
    return _$fetchPostsAsyncAction.run(() => super.fetchPosts());
  }

  late final _$fetchPostByIdAsyncAction =
      AsyncAction('_PostStore.fetchPostById', context: context);

  @override
  Future<void> fetchPostById(int id) {
    return _$fetchPostByIdAsyncAction.run(() => super.fetchPostById(id));
  }

  @override
  String toString() {
    return '''
postsFuture: ${postsFuture},
postFuture: ${postFuture}
    ''';
  }
}
