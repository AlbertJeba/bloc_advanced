import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_advanced/core/utils/configuration.dart';
import 'package:bloc_advanced/features/profile/data/models/update_profile_request.dart';
import 'package:bloc_advanced/features/profile/domain/use_case/profile_use_case.dart';
import 'package:bloc_advanced/shared/models/user_data.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUseCase profileUseCase;

  ProfileCubit(this.profileUseCase)
    : super(ProfileState(user: UserPreferences.instance.getUser()));

  Future<void> fetchProfile() async {
    final hasCached = state.user != null;
    if (!hasCached) {
      emit(state.copyWith(isLoading: true, errorMessage: ''));
    }

    final result = await profileUseCase.getProfile();

    result.fold(
      (error) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: hasCached ? '' : error.message,
        ),
      ),
      (response) {
        if (response.data != null) {
          UserPreferences.instance.setUser(response.data!);
        }
        emit(
          state.copyWith(isLoading: false, user: response.data ?? state.user),
        );
      },
    );
  }

  void toggleEditMode([bool? force]) {
    emit(
      state.copyWith(
        isEditing: force ?? !state.isEditing,
        updateSuccess: false,
        errorMessage: '',
      ),
    );
  }

  Future<void> updateProfile(UpdateProfileRequest request) async {
    emit(
      state.copyWith(isUpdating: true, errorMessage: '', updateSuccess: false),
    );

    final result = await profileUseCase.updateProfile(request);

    result.fold(
      (error) =>
          emit(state.copyWith(isUpdating: false, errorMessage: error.message)),
      (response) {
        if (response.data != null) {
          UserPreferences.instance.setUser(response.data!);
        }
        emit(
          state.copyWith(
            isUpdating: false,
            isEditing: false,
            updateSuccess: true,
            user: response.data ?? state.user,
            successMessage: response.message ?? 'Profile updated successfully',
          ),
        );
      },
    );
  }
}
