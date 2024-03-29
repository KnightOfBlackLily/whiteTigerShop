import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:white_tiger_shop/common/controller/entity/meta_with_unsuccess_exception.dart';

abstract class BaseModel<T> extends ChangeNotifier {
  T? data;
  bool isInitiallyUpdated = false;
  String? lastFetchErrorMsg;
  Future<void> fetch();
  Future<void> update() async {
    try {
      lastFetchErrorMsg = null;
      await fetch();
    } on MetaWithUnsuccesException catch (e) {
      lastFetchErrorMsg = e.errorMsg;
      log(lastFetchErrorMsg!);
    } on ClientException catch (_) {
      lastFetchErrorMsg =
          'Проблема с подключением. Проверьте интернет или попробуйте позже';
    } on Exception catch (_) {
      lastFetchErrorMsg = 'I am a teapot';
    } finally {
      if (!isInitiallyUpdated) isInitiallyUpdated = true;
      notifyListeners();
    }
  }
}
