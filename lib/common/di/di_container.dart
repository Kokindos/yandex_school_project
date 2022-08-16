import 'package:dio/dio.dart';
import 'package:done/common/internal/dio_logger_interceptor.dart';
import 'package:done/common/internal/dio_token_interceptor.dart';
import 'package:done/feature/app/network/network_task_backend.dart';
import 'package:done/feature/app/repositories/task_network_repository.dart';
import 'package:provider/provider.dart';

class DIContainer {
  final Dio dio;
  final NetworkTaskBackend networkTaskBackend;
  final TaskNetworkRepository taskRepository;

  DIContainer._({
    required this.networkTaskBackend,
    required this.dio,
    required this.taskRepository,
  });

  static DIContainer? _instance;

  static DIContainer get instance {
    if (_instance == null) {
      final dio = Dio(BaseOptions(
        baseUrl: 'https://beta.mrdekk.ru/todobackend',
        connectTimeout: 10000,
      ));
      dio.interceptors.add(DioTokenInterceptor());
      dio.interceptors.add(DioLoggerInterceptor());

      final networkTaskBackend = NetworkTaskBackend(dio);
      final taskRepository = TaskNetworkRepository(networkTaskBackend);

      _instance = DIContainer._(
        dio: dio,
        networkTaskBackend: networkTaskBackend,
        taskRepository: taskRepository,
      );
    }
    return _instance!;
  }

  List<Provider> get providers {
    return [
      Provider<NetworkTaskBackend>(
        create: (_) => networkTaskBackend,
      ),
      Provider<TaskNetworkRepository>(
        create: (_) => taskRepository,
      ),
    ];
  }
}
