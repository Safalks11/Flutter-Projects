import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  ServicesBloc() : super(ServicesInitial()) {
    on<FetchServicesData>(_onFetchServiceData);
    on<HoverEntered>(_onHoverEntered);
    on<HoverExited>(_onHoverExited);
  }

  Future<void> _onFetchServiceData(
      FetchServicesData event, Emitter<ServicesState> emit) async {
    emit(ServicesLoading());
    try {
      final snapshot = await _databaseRef.child('portfolio/services').get();
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        // Initialize hoverState as a list of `false`
        final hoverState = List<bool>.filled(data.length, false);
        emit(ServicesLoaded(serviceData: data, hoverState: hoverState));
      } else {
        emit(ServiceError(errorMessage: 'No data found in the database.'));
      }
    } catch (e) {
      emit(ServiceError(errorMessage: 'Failed to fetch data: ${e.toString()}'));
    }
  }

  void _onHoverEntered(HoverEntered event, Emitter<ServicesState> emit) {
    if (state is ServicesLoaded) {
      final currentState = state as ServicesLoaded;
      final newHoverState = List<bool>.from(currentState.hoverState);
      newHoverState[event.index] = true; // Set the specific index to `true`
      emit(ServicesLoaded(
        serviceData: currentState.serviceData,
        hoverState: newHoverState,
      ));
    }
  }

  void _onHoverExited(HoverExited event, Emitter<ServicesState> emit) {
    if (state is ServicesLoaded) {
      final currentState = state as ServicesLoaded;
      final newHoverState = List<bool>.from(currentState.hoverState);
      newHoverState[event.index] = false; // Set the specific index to `false`
      emit(ServicesLoaded(
        serviceData: currentState.serviceData,
        hoverState: newHoverState,
      ));
    }
  }
}
