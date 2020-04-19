import 'package:get_it/get_it.dart';
import 'package:q_ours_mobile/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}