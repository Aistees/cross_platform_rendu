import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() {
    return ''; 
  }

  void updateSearch(String query) {
    state = query;
  }
}