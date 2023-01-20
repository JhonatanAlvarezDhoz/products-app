import 'package:flutter/material.dart';
import 'package:validate_form/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _productCardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BacgrounImageProductCard(
              url: product.picture,
            ),
            _ProductDetails(product: product),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(
                price: product.price,
              ),
            ),

            //Todo conditional visibility
            if (!product.avaliable)
              Positioned(
                top: 0,
                left: 0,
                child: _NotStock(),
              )
          ],
        ),
      ),
    );
  }

  BoxDecoration _productCardBorders() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, 8), blurRadius: 10),
        ],
      );
}

class _NotStock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: 110,
      height: 60,
      decoration: _notStockBoxDecoration(),
      child: const Text(
        'Not Avaliable',
        style: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }

  BoxDecoration _notStockBoxDecoration() => const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      );
}

class _PriceTag extends StatelessWidget {
  final double price;

  const _PriceTag({required this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: 150,
      height: 70,
      decoration: _priceTagBorder(),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          child: Text(
            '\$$price',
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  BoxDecoration _priceTagBorder() {
    return const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50), topRight: Radius.circular(40)));
  }
}

class _ProductDetails extends StatelessWidget {
  final Product product;

  const _ProductDetails({required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 100),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      height: 70,
      decoration: __productDetailsBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            product.id.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration __productDetailsBoxDecoration() {
    return const BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(50), bottomLeft: Radius.circular(40)),
    );
  }
}

class _BacgrounImageProductCard extends StatelessWidget {
  final String? url;

  const _BacgrounImageProductCard({required this.url});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        // ignore: unnecessary_null_comparison
        child: url == null
            ? const Image(
                image: AssetImage('assets/placeholder/no-image.png'),
                fit: BoxFit.cover,
              )
            : FadeInImage(
                placeholder:
                    const AssetImage('assets/placeholder/jar-loading.gif'),
                image: NetworkImage(url!),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
