part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final UserData? user;
  final bool isEditing;
  final bool isUpdating;
  final bool updateSuccess;
  final String successMessage;

  const ProfileState({
    this.isLoading = false,
    this.errorMessage = '',
    this.user,
    this.isEditing = false,
    this.isUpdating = false,
    this.updateSuccess = false,
    this.successMessage = '',
  });

  ProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    UserData? user,
    bool? isEditing,
    bool? isUpdating,
    bool? updateSuccess,
    String? successMessage,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      isEditing: isEditing ?? this.isEditing,
      isUpdating: isUpdating ?? this.isUpdating,
      updateSuccess: updateSuccess ?? this.updateSuccess,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    user,
    isEditing,
    isUpdating,
    updateSuccess,
    successMessage,
  ];
}
