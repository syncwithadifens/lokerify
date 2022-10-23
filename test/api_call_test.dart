import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:lokerify/model/job_model/job_model.dart';
import 'package:lokerify/service/api_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_call_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  String apiUrl = 'https://bwa-jobs.herokuapp.com/';
  String endpoint = 'jobs';
  group('Fetch List Job', () {
    test('returns an job if the http call completes successfully', () async {
      final client = MockClient();
      when(client.get(Uri.parse(apiUrl + endpoint)))
          .thenAnswer((_) async => http.Response('[{}]', 200));
      expect(await ApiRepository(client).getAllJob(), isA<List<JobModel>>());
    });
  });
}
