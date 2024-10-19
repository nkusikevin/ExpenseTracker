import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_category_bloc_event.dart';
part 'get_category_bloc_state.dart';

class GetCategoryBlocBloc extends Bloc<GetCategoryBlocEvent, GetCategoryBlocState> {
  GetCategoryBlocBloc() : super(GetCategoryBlocInitial()) {
    on<GetCategoryBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
