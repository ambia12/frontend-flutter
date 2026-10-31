import 'menu_item_model.dart';

/// Item pesanan yang dipilih beserta opsi kustomisasinya.
class OrderItemModel {
  final MenuItemModel item;
  final int quantity;
  final String selectedSpiceLevel;
  final String selectedTopping;

  const OrderItemModel({
    required this.item,
    required this.quantity,
    this.selectedSpiceLevel = '',
    this.selectedTopping = '',
  });

  double get subtotal => item.price * quantity;

  String get formattedSubtotal {
    return 'Rp ${subtotal.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }
}

/// Sesi pesanan meja aktif di restoran.
class TableSessionModel {
  final String tableNumber;
  final String customerName;
  final List<OrderItemModel> items;
  final String paymentMethod;
  final String notes;

  const TableSessionModel({
    required this.tableNumber,
    required this.customerName,
    this.items = const [],
    this.paymentMethod = 'QRIS',
    this.notes = '',
  });

  double get totalAmount {
    return items.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  String get formattedTotalAmount {
    return 'Rp ${totalAmount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }
}

