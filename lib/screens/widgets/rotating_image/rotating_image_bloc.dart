import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';

part 'rotating_image_event.dart';
part 'rotating_image_state.dart';

class RotatingImageBloc extends Bloc<RotatingImageEvent, RotatingImageState> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  RotatingImageBloc() : super(RotatingImageInitial()) {
    on<FetchProfileImg>(_onFetchProfileImg);
    on<HoverEntered>(_onHoverEntered);
    on<HoverExited>(_onHoverExited);
  }

  FutureOr<void> _onFetchProfileImg(
      FetchProfileImg event, Emitter<RotatingImageState> emit) async {
    emit(RotatingImageLoading());
    try {
      final snapshot = await _databaseRef.child('portfolio/profile').get();
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);

        emit(RotatingImageLoaded(profileImg: data, hoverState: true));
      } else {
        emit(
            RotatingImageError(errorMessage: 'No data found in the database.'));
      }
    } catch (e) {
      emit(RotatingImageError(
          errorMessage: 'Failed to fetch data: ${e.toString()}'));
    }
  }

  FutureOr<void> _onHoverEntered(
      HoverEntered event, Emitter<RotatingImageState> emit) {
    if (state is RotatingImageLoaded) {
      final currentState = state as RotatingImageLoaded;
      emit(RotatingImageLoaded(
        profileImg: currentState.profileImg,
        hoverState: false,
      ));
    }
  }

  FutureOr<void> _onHoverExited(
      HoverExited event, Emitter<RotatingImageState> emit) {
    if (state is RotatingImageLoaded) {
      final currentState = state as RotatingImageLoaded;
      emit(RotatingImageLoaded(
        profileImg: currentState.profileImg,
        hoverState: true,
      ));
    }
  }
}
