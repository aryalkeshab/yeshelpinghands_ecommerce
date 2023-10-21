import 'package:flutter/material.dart';
import 'package:yeshelpinghand/core/presentation/resources/colors.dart';

enum OrderStatus {
  processing,
  cancelled,
  delivered,
  pending,
}

extension OrderStatusExtension on OrderStatus {
  static OrderStatus getStatus(String value) {
    switch (value) {
      case "pending":
        return OrderStatus.pending;
      case "delivered":
        return OrderStatus.delivered;
      case "cancelled":
        return OrderStatus.cancelled;

      case "processing":
        return OrderStatus.processing;

      default:
        return OrderStatus.processing;
    }
  }

  String get name {
    switch (this) {
      case OrderStatus.processing:
        return "PROCESSING";

      case OrderStatus.pending:
        return "PENDING";
      case OrderStatus.delivered:
        return "DELIVERED";
      case OrderStatus.cancelled:
        return "CANCELLED";

      default:
        return "";
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.processing:
        return secondaryColorDark;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
      case OrderStatus.pending:
        return Colors.orange;

      default:
        return Colors.white;
    }
  }
}
