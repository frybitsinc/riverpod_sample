import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:munto_sample/model/memo.dart';
import 'package:munto_sample/provider/memo_provider.dart';
import 'package:munto_sample/resource/app_strings.dart';

final _currentMemo = ScopedProvider<Memo>(null);

class MemoTile extends HookWidget {
  const MemoTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final memo = useProvider(_currentMemo);
    return Card(
      child: ListTile(
        leading: Text(memo.id.toString()),
        title: Text(memo.title),
        subtitle: Text(memo.content),
        trailing: Text(memo.createdAt),
      ),
    );
  }
}

class HomeView extends HookWidget {
  static const int MAX_PAGE = 3;
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read(memosViewController).initState();
      return context.read(memosViewController).dispose;
    }, []);

    final List<Memo> memos = [];//useProvider(_totalMemos).state;

    if (memos.isEmpty) {
      return Container(child: const Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.appTitle),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              AppStrings.homeContentPageCounter + '$currentPage',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: memos.length,
                itemBuilder: (ctx, int index) => ProviderScope(
                  overrides: [
                    _currentMemo.overrideWithValue(memos[index]),
                  ],
                  child: const MemoTile(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {

        },
      ),
    );
  }
}