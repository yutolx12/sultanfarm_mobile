import 'package:rxdart/rxdart.dart';

enum Navigation { dashboard, breeding, dombaSaya, akun }

class NavigationBloc {
  final BehaviorSubject<Navigation> _navigationController =
      BehaviorSubject.seeded(Navigation.dashboard);

  Stream<Navigation> get currentNavigationIndex => _navigationController.stream;

  void changeNavigationIndex(final Navigation option) =>
      _navigationController.sink.add(option);

  void dispose() => _navigationController.close();
}

class NavigationBloc1 {
  final BehaviorSubject<Navigation> _navigationController =
      BehaviorSubject.seeded(Navigation.dashboard);

  Stream<Navigation> get currentNavigationIndex => _navigationController.stream;

  void changeNavigationIndex(final Navigation option) =>
      _navigationController.sink.add(option);

  void dispose() => _navigationController.close();
}