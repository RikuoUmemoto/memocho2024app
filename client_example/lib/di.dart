import 'package:client_example/usecase/get_human_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'data/cache_repository.dart';
import 'data/sample_api.dart';
import 'data/sample_repository.dart';

part 'di.g.dart';

// final sampleApiProvider = Provider((ref) => SampleApi(host: '10.0.2.2:8080'));
//
// final sampleRepositoryProvider =
//     Provider((ref) => SampleRepository(sampleApi: ref.read(sampleApiProvider)));
//
// final cacheRepositoryProvider = Provider((ref) => CacheRepository());
//
// final getHumanUseCaseProvider = Provider(
//   (ref) => GetHumanUseCase(
//     ref.read(sampleRepositoryProvider),
//     ref.read(cacheRepositoryProvider),
//   ),
// );

@Riverpod(keepAlive: true)
SampleApi sampleApi(Ref ref) => SampleApi(host: '10.0.2.2:8080');

@Riverpod(keepAlive: true)
SampleRepository sampleRepository(Ref ref) =>
    SampleRepository(sampleApi: ref.watch(sampleApiProvider));

@Riverpod(keepAlive: true)
CacheRepository cacheRepository(Ref ref) => CacheRepository();

@Riverpod(keepAlive: true)
GetHumanUseCase getHumanUseCase(Ref ref) => GetHumanUseCase(
      ref.watch(sampleRepositoryProvider),
      ref.watch(cacheRepositoryProvider),
    );
