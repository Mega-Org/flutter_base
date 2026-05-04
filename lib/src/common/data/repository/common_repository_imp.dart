import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_base/core/core.dart';

import '../../domain/repository/common_repository.dart';

@Injectable(as: CommonRepository)
class CommonRepositoryImp implements CommonRepository {
  final DioHelper _dioHelper;

  const CommonRepositoryImp(this._dioHelper);

  @override
  DomainServiceType<AppLanguageEnum> changeLanguage(AppLanguageEnum lang) {
    return collectFailure(() async {
      await _dioHelper.post(
        url: "auth/change-language",
        body: {
          "language": lang.value,
        },
      );
      return Right(lang);
    });
  }
}
