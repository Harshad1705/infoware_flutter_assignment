import 'package:clean_architecture/features/form/presentation/bloc/form_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(const FormLoading());



  late String name;
  late String email;
  late String phone;
  String? gender = "";
  String? country = "";
  late String states;
  late String city;


  void clearValue() {
    gender = "";
    country = "";
  }



  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); // This regex is basic, you can adjust it based on your needs

    return emailRegex.hasMatch(email);
  }
}
