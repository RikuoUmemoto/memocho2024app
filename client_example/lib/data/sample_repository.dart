import 'package:client_example/data/sample_api.dart';

import '../model/api_error.dart';
import '../model/human.dart';

class SampleRepository {
  SampleRepository({required this.sampleApi});

  final SampleApi sampleApi;

  Future<String> getRoot() async {
    try {
      return sampleApi.getRoot();
    } catch (e) {
      throw ApiError(
        code: ERROR_CODE.NETWORK_ERROR,
        error: e,
      );
    }
  }

  Future<String> getEcho() async {
    try {
      return sampleApi.getEcho();
    } catch (e) {
      throw ApiError(
        code: ERROR_CODE.NETWORK_ERROR,
        error: e,
      );
    }
  }

  Future<Human> getHuman() async {
    try {
      final response = await sampleApi.getJson();
      return Human(
        name: response['name'],
        age: response['age'],
      );
    } catch (e) {
      throw ApiError(
        code: ERROR_CODE.NETWORK_ERROR,
        error: e,
      );
    }
  }
}
