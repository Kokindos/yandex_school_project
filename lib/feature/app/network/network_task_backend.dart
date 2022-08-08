import 'package:dio/dio.dart';
import 'package:done/feature/app/models/response/task_response.dart';
import 'package:done/feature/app/models/task.dart';

import '../models/response/list_response.dart';


class NetworkTaskBackend {
  final Dio _client;

  NetworkTaskBackend(this._client);

  Future<TaskResponse> createTask(
      {required Task task, required int revision}) async {
    final response = await _client.post(
      '/list',
      data: {"element": task.toJson()},
      options: Options(
        headers: {'X-Last-Known-Revision': revision},
      ),
    );
    return TaskResponse.fromJson(response.data);
  }

  Future<ListResponse> getList() async {
    final response = await _client.get('/list');
    return ListResponse.fromJson(response.data);
  }

  Future<ListResponse> updateList({required ListResponse taskList}) async {
    final response = await _client.patch(
      '/list',
      data: {"list": taskList.list.map((e) => e.toJson()).toList()},
      options: Options(
        headers: {'X-Last-Known-Revision': taskList.revision},
      ),
    );
    return ListResponse.fromJson(response.data);
  }

  Future<TaskResponse> editTask(
      {required Task task, required int revision}) async {
    //print('${task.id}');
    final response = await _client.put(
      '/list/${task.id}',
      data: {"element": task.toJson()},
      options: Options(
        headers: {'X-Last-Known-Revision': revision},
      ),
    );
    return TaskResponse.fromJson(response.data);
  }

  Future<TaskResponse> deleteTask(
      {required int revision, required String id}) async {
    final response = await _client.delete(
      '/list/$id',
      options: Options(
        headers: {'X-Last-Known-Revision': revision},
      ),
    );
    return TaskResponse.fromJson(response.data);
  }

  Future<TaskResponse> getTask(
      {required int revision, required String id}) async {
    final response = await _client.get(
      '/list/$id',
      options: Options(
        headers: {'X-Last-Known-Revision': revision},
      ),
    );
    return TaskResponse.fromJson(response.data);
  }
}
