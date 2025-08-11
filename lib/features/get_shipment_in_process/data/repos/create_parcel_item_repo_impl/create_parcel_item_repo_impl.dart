import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/data/data_source/create_parcel_item_data_source/create_parcel_item_remote_data_source.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/create_parcel_item_entity/create_parcel_item_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/create_parcel_item_repo/create_parcel_item_repo.dart';

class CreateParcelItemRepoImpl implements CreateParcelItemRepo {
  final CreateParcelItemRemoteDataSource createParcelItemRemoteDataSource;

  CreateParcelItemRepoImpl(this.createParcelItemRemoteDataSource);
  @override
  Future<Either<Failure, CreateParcelItemEntity>> createParcelItem({
    required int id,
    required String type,
    required int quantity,
    required int valuePerItem,
    required String description,
  }) async {
    try {
      var data = await createParcelItemRemoteDataSource.createParcelItem(
        type: type,
        quantity: quantity,
        valuePerItem: valuePerItem,
        description: description,
        id: id,
      );
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
