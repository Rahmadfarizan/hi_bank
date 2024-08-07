import 'package:flutter/foundation.dart';
import 'package:hi_bank/pages/home/model/post_model.dart';
import 'package:hi_bank/services/dio_helper.dart';
import 'package:mobx/mobx.dart';

part 'state.g.dart';

class PostStore extends _PostStore with _$PostStore {}

abstract class _PostStore with Store {
  @observable
  ObservableFuture<List<PostModel>>? postsFuture;

  @observable
  ObservableFuture<PostModel>? postFuture;

  @action
  Future<void> fetchPosts() async {
    try {
      postsFuture = ObservableFuture(DioHelper().get('posts'));
      await postsFuture;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @action
  Future<void> fetchPostById(int id) async {
    try {
      postFuture =
          ObservableFuture(DioHelper().getById('posts', id));
      await postFuture;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
