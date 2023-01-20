import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: _styleCardContainer(),
        child: child,
      ),
    );
  }

  BoxDecoration _styleCardContainer() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              offset: Offset(
                  0, 10), //! Posicion a la que se quiere mover la sombra (x,y)
              blurRadius: 15, //! Expancion de la sombra
              color: Color.fromRGBO(0, 0, 0, 0.200),
            ),
          ]);
}
