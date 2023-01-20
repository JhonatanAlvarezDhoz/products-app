import 'package:flutter/material.dart';

class AuthBcakground extends StatelessWidget {
  final Widget child;
  const AuthBcakground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          const _IconTop(),
          child,
        ],
      ),
    );
  }
}

class _IconTop extends StatelessWidget {
  const _IconTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBoxDecoration(),
      child: Stack(
        children: const [
          Positioned(
              top: 90, left: 30, child: _Bubbles(heigth: 100, width: 100)),
          Positioned(
              top: -40, left: -30, child: _Bubbles(heigth: 100, width: 100)),
          Positioned(
              top: -50, right: -20, child: _Bubbles(heigth: 100, width: 100)),
          Positioned(
              bottom: -50, left: 10, child: _Bubbles(heigth: 100, width: 100)),
          Positioned(
              bottom: 120, right: 20, child: _Bubbles(heigth: 50, width: 50)),
          Positioned(
              bottom: 80, left: -20, child: _Bubbles(heigth: 50, width: 50)),
          Positioned(
              bottom: 60, left: 30, child: _Bubbles(heigth: 25, width: 25)),
          Positioned(
              bottom: 90, right: 70, child: _Bubbles(heigth: 25, width: 25)),
          Positioned(
              bottom: 70, right: 100, child: _Bubbles(heigth: 15, width: 15)),
          Positioned(top: 40, right: 80, child: _Bubbles(heigth: 60, width: 60))
        ],
      ),
    );
  }

  BoxDecoration _purpleBoxDecoration() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 120, 255, 1),
      ]));
}

class _Bubbles extends StatelessWidget {
  final double heigth;
  final double width;

  const _Bubbles({required this.width, required this.heigth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: heigth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}
