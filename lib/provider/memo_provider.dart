import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:munto_sample/model/memo.dart';
import 'package:munto_sample/repository/memo_repository.dart';

final _totalMemos = StateProvider.autoDispose<List<Memo>>((ref) => null);

final memosViewController = Provider.autoDispose((ref) => MemosViewController(ref.read));

class MemosViewController {
  final Reader read;
  MemosViewController(this.read);

  void initState() async {
    read(_totalMemos).state = await read(memoRepository).getMemos(1);
  }

  void dispose() {
    read(_totalMemos).state.clear();
  }

  void loadMoreMemo(int newPage) async {
    final newMemo = await read(memoRepository).getMemos(newPage);
    final memos = List<Memo>.from(read(_totalMemos).state)..addAll(newMemo);
    read(_totalMemos).state = memos;
  }
}
