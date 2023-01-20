import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:json_bank_data/model/api_model.dart';

Future<List<InterestDataModel>?> getInterestData() async {
  try {
    var request =
        http.Request('GET', Uri.parse('https://www.jsonkeeper.com/b/XK4L'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      debugPrint(data);
      final interestDataFromJS = (interestDataFromJson(data));
      interestDataFromJS.sort((a, b) => a.tenuresInMonth
          .toString()
          .compareTo(b.tenuresInMonth.toString()));
      return interestDataFromJS;
    } else {
      debugPrint(response.reasonPhrase);
      EasyLoading.showError(response.reasonPhrase!);
      return [];
    }
  } on SocketException catch (e) {
    debugPrint(e.toString());
    EasyLoading.showError('No Internet Connection. $e');
    return [];
  } catch (e) {
    debugPrint(e.toString());
    EasyLoading.showError(e.toString());
    return [];
  }
}

final getInsertDataProvider =
    FutureProvider.autoDispose<List<InterestDataModel>?>((ref) async {
  return await getInterestData();
});
