import 'dart:developer';

import 'package:white_tiger_shop/types/types.dart';
import 'package:http/http.dart' as http;

class BaseApi {
  final key =
      'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';
  final adress = 'ostest.whitetigersoft.ru';

  Future<http.Response> makeApiCall(String apiPath, ApiArgs? queryArgs) {
    final uri = Uri(
        scheme: 'http',
        host: adress,
        path: apiPath,
        queryParameters: queryArgs != null
            ? {...queryArgs, 'appKey': key}
            : {'appKey': key});
    return http.Client().get(uri);
  }
}
