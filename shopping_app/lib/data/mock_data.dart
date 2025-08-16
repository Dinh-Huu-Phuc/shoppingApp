import '../models/product.dart';
import '../models/category.dart';

const categories = <Category>[
  Category(id: 'c_top', name: 'Top'),
  Category(id: 'c_outer', name: 'Outer'),
  Category(id: 'c_bottom', name: 'Bottom'),
  Category(id: 'c_accessory', name: 'Accessory'),
];

const mockProducts = <Product>[
  Product(
    id: 'p1',
    name: 'Oversized Tee',
    image: 'assets/images/tee_oversized.webp',
    brand: 'UrbanBasic',
    categoryId: 'c_top',
    price: 299000,
    salePrice: 249000,
    sizes: ['S', 'M', 'L', 'XL'],
    description: 'Áo thun oversize cotton 2 chiều, form relaxed.',
  ),
  Product(
    id: 'p2',
    name: 'Denim Jacket',
    image: 'assets/images/denim_jacket.webp',
    brand: 'StreetWave',
    categoryId: 'c_outer',
    price: 899000,
    sizes: ['S', 'M', 'L'],
    description: 'Áo khoác denim wash nhẹ, street style.',
  ),
  Product(
    id: 'p3',
    name: 'Wide-leg Pants',
    image: 'assets/images/wide_pants.webp',
    brand: 'FormLab',
    categoryId: 'c_bottom',
    price: 559000,
    sizes: ['M', 'L', 'XL'],
    description: 'Quần ống suông chất liệu thoáng, phù hợp daily.',
  ),
];