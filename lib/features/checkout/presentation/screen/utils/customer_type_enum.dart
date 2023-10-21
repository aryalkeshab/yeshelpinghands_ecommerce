enum CustomerType { individual, organization }

extension CustomerTypeExtension on CustomerType {
  String get value {
    switch (this) {
      case CustomerType.individual:
        return "individual";

      case CustomerType.organization:
        return "organization";

      default:
        return "";
    }
  }

  String get name {
    switch (this) {
      case CustomerType.individual:
        return "Individual";

      case CustomerType.organization:
        return "Organization";

      default:
        return "Null";
    }
  }
}
