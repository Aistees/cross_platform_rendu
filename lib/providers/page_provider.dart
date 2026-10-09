import 'package:riverpod/riverpod.dart';

class PageNotifier extends Notifier<int> {
  @override
  int build() {
    return 1;
  }

  void nextPage()  {
    state++;
  } 

  void previousPage() {
    if(state > 1) {
      state--;
    }
  }
}

final pageProvider = NotifierProvider<PageNotifier,int>(() => PageNotifier());