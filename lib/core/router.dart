import 'package:go_router/go_router.dart';
import '../pages/home_page.dart';
import '../pages/detail_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(title: 'Adopte un Wouf',),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final itemId = state.pathParameters['id']!;
        return DetailsPage(id: itemId, title: 'Adopte un Wouf',);
      }
    ),
  ],
);