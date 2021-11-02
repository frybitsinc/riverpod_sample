import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:munto_sample/model/memo.dart';
import 'package:munto_sample/repository/memo_repository.dart';

final _memos = StateProvider.autoDispose<List<Memo>>((ref) => null) as AlwaysAliveProviderBase<Object, dynamic>;

final sortedMemos = StateProvider<List<Memo>>((ProviderReference ref) {
  final List<Memo> memos = ref.watch(_memos).state;
  return memos;
});

final memosViewController = Provider.autoDispose((ref) => MemosViewController(ref.read));

class MemosViewController {
  final Reader read;
  MemosViewController(this.read);

  void initState() async {
    read(_memos).state = await read(memoRepository).getMemos(1);
  }

  void dispose() {
    read(_memos).state.clear();
  }

  void loadMoreMemo(int newPage) async {
    final newMemo = await read(memoRepository).getMemos(newPage);
    final memos = List<Memo>.from(read(_memos).state)..addAll(newMemo);
    read(_memos).state = memos;
  }
}
