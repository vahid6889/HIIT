// ignore_for_file: must_be_immutable

part of 'home_bloc.dart';

class HomeState extends Equatable {
  CwStatus cwStatus;
  FwStatus fwStatus;
  FhStatus fhStatus;
  LwStatus lwStatus;
  AqStatus aqStatus;

  HomeState({
    required this.cwStatus,
    required this.fwStatus,
    required this.fhStatus,
    required this.lwStatus,
    required this.aqStatus,
  });

  HomeState copyWith({
    CwStatus? newCwStatus,
    FwStatus? newFwStatus,
    FhStatus? newFhStatus,
    LwStatus? newLwStatus,
    AqStatus? newAqStatus,
  }) {
    return HomeState(
      cwStatus: newCwStatus ?? cwStatus,
      fwStatus: newFwStatus ?? fwStatus,
      fhStatus: newFhStatus ?? fhStatus,
      lwStatus: newLwStatus ?? lwStatus,
      aqStatus: newAqStatus ?? aqStatus,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        cwStatus,
        fwStatus,
        fhStatus,
        lwStatus,
        aqStatus,
      ];
}
