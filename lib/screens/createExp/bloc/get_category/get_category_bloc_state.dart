part of 'get_category_bloc_bloc.dart';

sealed class GetCategoryBlocState extends Equatable {
  const GetCategoryBlocState();
  
  @override
  List<Object> get props => [];
}

final class GetCategoryBlocInitial extends GetCategoryBlocState {}
