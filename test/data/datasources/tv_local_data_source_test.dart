import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

 
    group('save tv watchlist', () {
      test('should return success message when insert to database is success', () async {
        // arrange
        when(mockDatabaseHelper.insertWatchlistTv(testTvTable)).thenAnswer((_) async => testTvTable.id);
        // act
        final result = await dataSource.insertWatchlistTv(testTvTable);
        // assert
        expect(result, 'Tv Series Added To Watchlist');
      });

      test('should return error message when insert to database is failed', 
      () async {
        // arrange
        when(mockDatabaseHelper.insertWatchlistTv(testTvTable)).thenThrow(Exception());
        // act
        final result =  dataSource.insertWatchlistTv(testTvTable);
        // assert
        expect(() => result,  throwsA(isA<DatabaseException>()));
      });
    });
  
}
