import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'memo.freezed.dart';

@freezed
abstract class Memo with _$Memo {
  const factory Memo(int id, String title, String content, String createdAt) = _Memo;
  factory Memo.fromJson(Map<String, dynamic> json) => _$MemoFromJson(json);
}