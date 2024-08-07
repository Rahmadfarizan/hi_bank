import 'package:hi_bank/pages/home/state/state.dart';

class MobXHelper {
  static final MobXHelper _instance = MobXHelper._internal();
  factory MobXHelper() => _instance;

  MobXHelper._internal();

  final PostStore postStore = PostStore();
}