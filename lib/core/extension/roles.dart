/// UserRole
///
/// Defines the types of users in the system.
enum UserRole { admin, customer }

/// Helper extension to convert Role to ID and back.
/// Useful when sending/receiving data from API.
extension UserRoleExtension on UserRole {
  /// Get ID from Role
  int get id {
    switch (this) {
      case UserRole.admin:
        return 1;
      case UserRole.customer:
        return 2;
    }
  }

  /// Get Role from ID
  static UserRole fromId(int id) {
    switch (id) {
      case 1:
        return UserRole.admin;
      case 2:
        return UserRole.customer;
      default:
        throw Exception("Invalid user role ID");
    }
  }
}
