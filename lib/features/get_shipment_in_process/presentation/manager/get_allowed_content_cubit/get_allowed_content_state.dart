part of 'get_allowed_content_cubit.dart';

sealed class GetAllowedContentState extends Equatable {
  const GetAllowedContentState();

  @override
  List<Object> get props => [];
}

final class GetAllowedContentInitial extends GetAllowedContentState {}

final class GetAllowedContentFailure extends GetAllowedContentState {
  final String message;

  const GetAllowedContentFailure(this.message);
}

final class GetAllowedContentLoading extends GetAllowedContentState {}

final class GetAllowedContentSuccess extends GetAllowedContentState {
  final List<AllowedContentEntity> contents;

  const GetAllowedContentSuccess(this.contents);
}
