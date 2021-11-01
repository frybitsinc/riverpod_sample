import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:munto_sample/model/memo.dart';

final memoRepository = Provider.autoDispose<MemoRepository>((ref) => MemoRepositoryImpl(ref.read));

abstract class MemoRepository {
  Future<List<Memo>> getMemos(int page);
}

class MemoRepositoryImpl implements MemoRepository {
  final Reader read;
  MemoRepositoryImpl(this.read);

  Future<List<Memo>> getMemos(int page) async {
    final file = await File.fromUri(Uri.file('page${page.toString()}.json')).readAsString();
    final jsonData = json.decode(file);

    return jsonData.map((data) => Memo.fromJson(data)).toList();
  }
}