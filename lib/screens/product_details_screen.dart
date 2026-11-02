import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int page = 0;
  List<String> get images => widget.product.images.isNotEmpty
      ? widget.product.images
      : [widget.product.thumbnail];

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final themeColor = Theme.of(context).colorScheme.primary;
    final image = images;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        centerTitle: true,
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 200,
                width: double.infinity,
                color: Color(0xFFF3F4F6),
                child: PageView.builder(
                  itemCount: image.length,
                  onPageChanged: (i) => setState(() => page = i),
                  itemBuilder: (_, i) => Padding(
                    padding: EdgeInsets.all(12),
                    child: Image.network(
                      image[i],
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                          ? child
                          : Center(child: CircularProgressIndicator()),
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Icon(Icons.broken_image_outlined, size: 56),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (image.length > 1) ...[
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  image.length,
                  (i) => Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == page ? themeColor : Color(0xFFD1D5DB),
                    ),
                  ),
                ),
              ),
            ],
            SizedBox(height: 16),
            Text(
              product.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            SizedBox(height: 20),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 14,
                height: 1.45,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
