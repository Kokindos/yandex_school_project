import 'package:dio/dio.dart';
import 'package:done/feature/app/models/response/task_response.dart';
import 'package:done/feature/app/models/task.dart';

import '../models/response/list_response.dart';
import 'task_api.dart';

class NetworkTaskBackend implements TaskApi {
  final Dio _client;

  NetworkTaskBackend(this._client);

  @override
  Future<Task> createTask({required Task task, int? revision}) async {
    final response = await _client.post(
      '/list',
      data: {
        "element": task.toJson(),
      },
      options: Options(
        headers: {'X-Last-Known-Revision': revision},
      ),
    );
    return TaskResponse.fromJson(response.data).element;
  }

  @override
  Future<List<Task>> getList() async {
    final response = await _client.get('/list');
    return ListResponse.fromJson(response.data).list;
  }

  Future<ListResponse> getRevision() async {
    final response = await _client.get('/list');
    return ListResponse.fromJson(response.data);
  }

  @override
  Future<List<Task>> updateList(
      {required List<Task> taskList, int? revision}) async {
    final response = await _client.patch(
      '/list',
      data: {"list": taskList.map((e) => e.toJson()).toList()},
      options: Options(
        headers: {'X-Last-Known-Revision': revision!},
      ),
    );
    return ListResponse.fromJson(response.data).list;
  }

  @override
  Future<Task> editTask({required Task task, int? revision}) async {
    final response = await _client.put(
      '/list/${task.id}',
      data: {
        "element": task.toJson(),
      },
      options: Options(
        headers: {'X-Last-Known-Revision': revision},
      ),
    );
    return TaskResponse.fromJson(response.data).element;
  }

  @override
  Future<Task> deleteTask({int? revision, required String id}) async {
    final response = await _client.delete(
      '/list/$id',
      options: Options(
        headers: {'X-Last-Known-Revision': revision},
      ),
    );
    return TaskResponse.fromJson(response.data).element;
  }

  @override
  Future<Task> getTask({int? revision, required String id}) async {
    final response = await _client.get(
      '/list/$id',
      options: Options(
        headers: {'X-Last-Known-Revision': revision},
      ),
    );
    return TaskResponse.fromJson(response.data).element;
  }
}
