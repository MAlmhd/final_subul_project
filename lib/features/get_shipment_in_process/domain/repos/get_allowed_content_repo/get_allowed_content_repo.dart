import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/allowed_content_entity/allowed_content_entity.dart';

abstract class GetAllowedContentRepo {
  Future<Either<Failure, List<AllowedContentEntity>>> getAllowedContent();
}
