import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'more_state.dart';

class MoreCubit extends Cubit<MoreState> {
  MoreCubit() : super(MoreInitial());
}
