import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base/core/core.dart';

abstract class DropDownCubit<T> extends Cubit<Async<List<T>>> {
  DropDownCubit() : super(const Async.initial());

  void fetch();

  void setData(List<T> data) {
    emit(Async.success(data));
  }

  @override
  void emit(Async<List<T>> state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}

class DefaultDropDownCubit<T> extends DropDownCubit<T> {
  DefaultDropDownCubit();

  @override
  void fetch() {}
}
