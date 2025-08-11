import 'package:dartz/dartz.dart';
import 'package:final_subul_project/core/errors/failure.dart';
import 'package:final_subul_project/core/use_cases/use_case.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/entities/allowed_content_entity/allowed_content_entity.dart';
import 'package:final_subul_project/features/get_shipment_in_process/domain/repos/get_allowed_content_repo/get_allowed_content_repo.dart';

class GetAllowedContentUseCase
    extends UseCase<List<AllowedContentEntity>, NoParam> {
  final GetAllowedContentRepo getAllowedContentRepo;

  GetAllowedContentUseCase(this.getAllowedContentRepo);
  @override
  Future<Either<Failure, List<AllowedContentEntity>>> call([
    NoParam? params,
  ]) async {
    return await getAllowedContentRepo.getAllowedContent();
  }
}
