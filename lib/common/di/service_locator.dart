import 'package:done/common/services/navigation_service.dart';
import 'package:done/common/services/remote_config_service.dart';
import 'package:done/feature/app/repositories/task_connect_repository.dart';
import 'package:done/feature/app/repositories/task_local_repository.dart';
import 'package:done/feature/app/repositories/task_network_repository.dart';
import 'package:done/feature/app/task_api/local_storage_api.dart';
import 'package:done/feature/app/task_api/network_task_backend.dart';
import 'package:done/feature/main_page/bloc/tasklist_bloc.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  late TaskListBloc bloc;
  late NavigationService navigationService;
  late RemoteConfigService remoteConfig;
  final getIt = GetIt.instance;

  ServiceLocator() {
    navigationService = NavigationService();
    remoteConfig = RemoteConfigService();
    final networkTaskBackend = NetworkTaskBackend();
    final taskNetworkRepository = TaskNetworkRepository(networkTaskBackend);
    final taskLocalRepository = TaskLocalRepository(LocalStorageApi());
    final taskConnectRepository = TaskConnectRepository(
        taskLocalRepository: taskLocalRepository,
        taskNetworkRepository: taskNetworkRepository);
    bloc = TaskListBloc(taskRepository: taskConnectRepository)
      ..add(const GetListEvent());
    register();
  }

  void register() {
    getIt.registerSingleton<NavigationService>(navigationService);
    getIt.registerSingleton<RemoteConfigService>(remoteConfig);
    getIt.registerSingleton<TaskListBloc>(bloc);
  }
}
