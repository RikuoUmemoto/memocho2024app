import '../data/cache_repository.dart';
import '../data/sample_repository.dart';
import '../model/human.dart';

class GetHumanUseCase {
  const GetHumanUseCase(
    this._sampleRepository,
    this._cacheRepository,
  );

  final SampleRepository _sampleRepository;
  final CacheRepository _cacheRepository;

  Future<Human> getHuman() async {
    Human? human = _cacheRepository.getHuman();
    if (human != null) {
      return human;
    }

    human = await _sampleRepository.getHuman();
    _cacheRepository.cache(human);
    return human;
  }
}
