import 'package:flutterapp2/data/data_resources_remotes/location_remote_data_source.dart';
import 'package:flutterapp2/domain/repositories_api/location_repo_api.dart';

class LocationRepoImpl implements LocationRepoApi {
  LocationRemoteDataSource locationRemoteDataSource =
      LocationRemoteDataSource();

  @override
  Future getLocationJson(double latitude, double longitude) {
    return locationRemoteDataSource.responseJsonLocation(
      latitude,
      longitude,
    );
  }
}
