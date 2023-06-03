part of 'home_bloc.dart';

class HomeState extends Equatable {
  CwStatus cwStatus;
  FwStatus fwStatus;
  FhStatus fhStatus;

  HomeState({
    required this.cwStatus,
    required this.fwStatus,
    required this.fhStatus,
  });

  HomeState copyWith(
      {CwStatus? newCwStatus, FwStatus? newFwStatus, FhStatus? newFhStatus}) {
    return HomeState(
      cwStatus: newCwStatus ?? cwStatus,
      fwStatus: newFwStatus ?? fwStatus,
      fhStatus: newFhStatus ?? fhStatus,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        cwStatus,
        fwStatus,
        fhStatus,
      ];
}
