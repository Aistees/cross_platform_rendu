import 'package:cross_platform_rendu/pages/favorites_page.dart';
import 'package:go_router/go_router.dart';
import '../pages/home_page.dart';
import '../pages/detail_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(title: 'Adopt a Woof',),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final itemId = state.pathParameters['id']!;
        return DetailsPage(id: itemId, title: 'Adopt a Woof',);
      }
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesPage(),
    ),
  ],
);