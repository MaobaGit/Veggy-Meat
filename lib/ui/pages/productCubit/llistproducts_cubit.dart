import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:veggy/domain/models/product_api.dart';

part 'llistproducts_state.dart';

class LlistproductsCubit extends Cubit<LlistproductsState> {
  LlistproductsCubit() : super(LlistproductsInitial());
}
