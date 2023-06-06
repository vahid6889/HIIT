part of 'home_bloc.dart';

class HomeState extends Equatable {
  CwStatus cwStatus;
  FwStatus fwStatus;
  FhStatus fhStatus;
  LwStatus lwStatus;

  HomeState({
    required this.cwStatus,
    required this.fwStatus,
    required this.fhStatus,
    required this.lwStatus,
  });

  HomeState copyWith({
    CwStatus? newCwStatus,
    FwStatus? newFwStatus,
    FhStatus? newFhStatus,
    LwStatus? newLwStatus,
  }) {
    return HomeState(
      cwStatus: newCwStatus ?? cwStatus,
      fwStatus: newFwStatus ?? fwStatus,
      fhStatus: newFhStatus ?? fhStatus,
      lwStatus: newLwStatus ?? lwStatus,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        cwStatus,
        fwStatus,
        fhStatus,
        lwStatus,
      ];
}
