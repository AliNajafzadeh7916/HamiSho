import 'package:candidate/Data/api_data.dart';
import 'package:candidate/Data/static_data.dart';
import 'package:dio/dio.dart';

import '../Data/dynamic_data.dart';

header() {
  return Options(
    headers: {
      'API-X-KEY': StaticData.apiKey,
      'IMEI': uniqueId,
      'Candidate': StaticData.candidateCode,
      'Version': StaticData.versionApp,
    },
  );
}

class Api {
  //

  getCandidateInfo() async {
    final response = await Dio()
        .get(
          ApiData.getCandidateInfoUrl,
          options: header(),
        )
        .timeout(const Duration(seconds: 15));

    return response;
  }

  getPostCandidate() async {
    final response = await Dio()
        .get(
          ApiData.getPostCandidateUrl,
          options: header(),
        )
        .timeout(const Duration(seconds: 15));

    return response;
  }

  getNewsCandidate() async {
    final response = await Dio()
        .get(
          ApiData.getNewsCandidateUrl,
          options: header(),
        )
        .timeout(const Duration(seconds: 15));

    return response;
  }

  setSupporter() async {
    final response = await Dio()
        .get(
          ApiData.setSupporterUrl,
          options: header(),
        )
        .timeout(const Duration(seconds: 15));

    return response;
  }

  setMessageToCandidate({
    required String name,
    required String phone,
    required String city,
    required String message,
  }) async {
    final response = await Dio().post(
      ApiData.setMessageToCandidateUrl,
      options: header(),
      data: {
        'Name': name,
        'Phone': phone,
        'Address': city,
        'Message': message,
      },
    ).timeout(const Duration(seconds: 15));

    return response;
  }
}
