import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfileData>(_onFetchProfileData);
  }

  Future<void> _onFetchProfileData(
      FetchProfileData event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      // Fetch data from Firebase Realtime Database
      final profile = await _databaseRef.child('portfolio/profile').get();
      final project = await _databaseRef.child('portfolio/works').get();

      if (profile.exists && project.exists) {
        // Convert data to a Map<String, dynamic>
        final profileData = Map<String, dynamic>.from(profile.value as Map);
        final projectData = Map<String, dynamic>.from(project.value as Map);
        emit(ProfileLoaded(profileData: profileData, projectData: projectData));
      } else {
        emit(ProfileError(errorMessage: 'No data found in the database.'));
      }
    } catch (e) {
      emit(ProfileError(errorMessage: 'Failed to fetch data: ${e.toString()}'));
    }
  }
}
