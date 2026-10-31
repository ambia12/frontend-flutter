/// Model entitas menu makanan/minuman pada aplikasi Kantingo.
class MenuItemModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final String description;
  final String estimatedTime;
  final double rating;
  final List<String> spiceLevels;
  final List<String> toppings;

  const MenuItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.estimatedTime,
    required this.rating,
    this.spiceLevels = const ['Level 0', 'Level 1', 'Level 2', 'Level 3'],
    this.toppings = const ['Pangsit Goreng', 'Siomay Kukus', 'Ekstra Bawang'],
  });

  String get formattedPrice {
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }
}

/// Data statis menu kantin ala Gacoan & Kantin Modern.
final List<MenuItemModel> sampleMenuItems = [
  const MenuItemModel(
    id: 'm1',
    name: 'Mie Pedas Kantingo Level 1-4',
    category: 'Mie & Makanan',
    price: 13000,
    description: 'Mie pedas gurih dengan taburan ayam cincang halus, pangsit goreng renyah, dan racikan cabai segar.',
    estimatedTime: '8-10 Menit',
    rating: 4.9,
    spiceLevels: [
      'Level 0 (Gurih)',
      'Level 1',
      'Level 2',
      'Level 3',
      'Level 4',
    ],
  ),
  const MenuItemModel(
    id: 'm2',
    name: 'Mie Manis Pedas Kantingo',
    category: 'Mie & Makanan',
    price: 13000,
    description: 'Mie pedas manis dengan perpaduan kecap istimewa, taburan ayam cincang, dan daun bawang segar.',
    estimatedTime: '8-10 Menit',
    rating: 4.8,
    spiceLevels: ['Level 0 (Manis)', 'Level 1', 'Level 2', 'Level 3'],
  ),
  const MenuItemModel(
    id: 'm3',
    name: 'Dimsum Siomay Ayam (3 pcs)',
    category: 'Dimsum & Side',
    price: 11000,
    description: 'Siomay ayam lembut dan kenyal disajikan hangat dengan cocolan saus pedas manis khas.',
    estimatedTime: '5-7 Menit',
    rating: 4.9,
    spiceLevels: [],
    toppings: ['Ekstra Saus Sambal', 'Mayones'],
  ),
  const MenuItemModel(
    id: 'm4',
    name: 'Pangsit Goreng Renyah (3 pcs)',
    category: 'Dimsum & Side',
    price: 11000,
    description: 'Pangsit goreng isi olahan ayam berpadu kulit renyah kriuk dengan saus cocolan gurih.',
    estimatedTime: '5 Menit',
    rating: 4.7,
    spiceLevels: [],
    toppings: ['Ekstra Saus Sambal', 'Bumbu Tabur'],
  ),
  const MenuItemModel(
    id: 'm5',
    name: 'Es Segar Kantingo',
    category: 'Minuman Segar',
    price: 8000,
    description: 'Es campur buah segar dengan sirup manis harum dan jelly kenyal pelepas pedas.',
    estimatedTime: '3-5 Menit',
    rating: 4.8,
    spiceLevels: [],
    toppings: ['Ekstra Es Batu', 'Less Sugar'],
  ),
  const MenuItemModel(
    id: 'm6',
    name: 'Es Teh Melati Jumbo',
    category: 'Minuman Segar',
    price: 4000,
    description: 'Seduhan teh melati tradisional dengan gula murni dan es batu melimpah segar.',
    estimatedTime: '2 Menit',
    rating: 4.7,
    spiceLevels: [],
    toppings: ['Less Sugar', 'Ekstra Es Batu'],
  ),
];
