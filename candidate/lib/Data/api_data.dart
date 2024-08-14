import 'static_data.dart';

class ApiData {
  static String headUrl = '${StaticData.baseUrl}/api/';

  static String getCandidateInfoUrl = '${headUrl}getCandidateInfo/';
  static String getPostCandidateUrl = '${headUrl}getPostCandidate/';
  static String getNewsCandidateUrl = '${headUrl}getNewsCandidate/';
  static String setSupporterUrl = '${headUrl}setSupporter/';
  static String setMessageToCandidateUrl = '${headUrl}setMessageToCandidate/';
}
