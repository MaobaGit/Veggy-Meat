part of 'form_cubit.dart';

enum StatudSummit { pure, error, summited }

class FormCubitState extends Equatable {
  final Email email;
  final UserName userNameComplete;
  final AddrresForm addres;
  final NumberNoEmpty id;
  final NumberPhone phone;
  final FormzStatus status;
  final StatudSummit statusSummit;
  final String errormessage;
  const FormCubitState({
    this.userNameComplete = const UserName.pure(),
    this.addres = const AddrresForm.pure(),
    this.phone = const NumberPhone.pure(),
    this.id = const NumberNoEmpty.pure(),
    this.email = const Email.pure(),
    this.errormessage = '',
    this.statusSummit = StatudSummit.pure,
    this.status = FormzStatus.pure,
  });

  FormCubitState copyWith({
    Email? email,
    UserName? userNameComplete,
    AddrresForm? addres,
    NumberNoEmpty? id,
    NumberPhone? phone,
    FormzStatus? status,
    StatudSummit? statusSummit,
    String? message,
  }) {
    return FormCubitState(
      email: email ?? this.email,
      userNameComplete: userNameComplete ?? this.userNameComplete,
      addres: addres ?? this.addres,
      phone: phone ?? this.phone,
      id: id ?? this.id,
      status: status ?? this.status,
      errormessage: message ?? this.errormessage,
      statusSummit: statusSummit ?? this.statusSummit
    );
  }

  @override
  List<Object> get props =>
      [email, userNameComplete, addres, phone, id, status,statusSummit,errormessage];
}
