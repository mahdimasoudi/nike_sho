import 'package:dio/dio.dart';
import 'package:nike_shop/data/common/http_response_validator.dart';
import 'package:nike_shop/data/model/banner.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAll();
}

class BannerRemoteDataSource
    with HttpResponseValidator
    implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource(this.httpClient);
  @override
  Future<List<BannerEntity>> getAll() async {
    final response = await httpClient.get('banners');
    validateResponse(response);
    final List<BannerEntity> banners = [];
    for (var jsonObject in (response.data as List)) {
      banners.add(BannerEntity.fromJson(jsonObject));
    }
    return banners;
  }
}
