// ignore_for_file: file_names

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';

class PizzaCalc extends StatefulWidget {
  const PizzaCalc({Key? key}) : super(key: key);

  @override
  State<PizzaCalc> createState() => _PizzaCalcState();
}

enum Sauce { hot, sweet, cheese }

class _PizzaCalcState extends State<PizzaCalc> {
  bool _slimDough = false;
  double _pizzaSize = 30;
  int _cost = 300;
  Sauce? _sauce = Sauce.hot;
  bool _cheese = true;

  int _calcCost() {
    _cost = _pizzaSize.round() + 400;

    if (_slimDough == true) _cost += 100;
    if (_cheese == true) _cost += 50;

    switch (_sauce) {
      case Sauce.hot:
        _cost += 40;
        break;
      case Sauce.sweet:
        _cost += 60;
        break;
      case Sauce.cheese:
        _cost += 80;
        break;
      case null:
        _sauce = Sauce.hot;
        break;
    }
    return _cost;
  }

  void _onSauceChanged(Sauce? value) {
    setState(() {
      _sauce = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Собери свою пиццу'),
        ),
        body: Container(
          alignment: Alignment.topRight,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset('assets/pizza.png'),
                    ],
                  ),
                ),
                const Text("Калькулятор пиццы",
                    style: TextStyle(fontSize: 30, color: Color(0xff0000000))),
                const Text("Выберите параметры",
                    style: TextStyle(fontSize: 16, color: Color(0xff0000000))),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: 300,
                  child: SlidingSwitch(
                    value: false,
                    width: 300,
                    onChanged: (bool value) {
                      _slimDough = value;
                      setState(() {
                        _calcCost();
                      });
                    },
                    height: 30,
                    animationDuration: const Duration(milliseconds: 100),
                    textOff: "Обычное тесто",
                    textOn: "Тонкое тесто",
                    colorOn: const Color(0xffFFFFFF),
                    colorOff: const Color(0xf0FFFFFF),
                    background: const Color(0xffECEFF1),
                    buttonColor: const Color(0xff0079D0),
                    inactiveColor: const Color(0xff636f7B),
                    onTap: () {},
                    onDoubleTap: () {},
                    onSwipe: () {},
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: const Text("Размер:",
                      style: TextStyle(fontSize: 18, color: Color(0xFF000000))),
                ),
                SizedBox(
                    width: 300,
                    child: SfSlider(
                      min: 25,
                      max: 35,
                      value: _pizzaSize,
                      interval: 5,
                      showTicks: true,
                      showLabels: true,
                      numberFormat: NumberFormat(),
                      enableTooltip: false,
                      minorTicksPerInterval: 0,
                      stepSize: 5,
                      onChanged: (dynamic value) {
                        setState(() {
                          _pizzaSize = value;
                          _calcCost();
                        });
                      },
                    )),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: const Text("Соус",
                      style: TextStyle(fontSize: 18, color: Color(0xFF000000))),
                ),
                RadioListTile<Sauce>(
                  title: const Text("Острый"),
                  value: Sauce.hot,
                  groupValue: _sauce,
                  onChanged: _onSauceChanged,
                ),
                RadioListTile<Sauce>(
                  title: const Text("Кисло-сладкий"),
                  value: Sauce.sweet,
                  groupValue: _sauce,
                  onChanged: _onSauceChanged,
                ),
                RadioListTile<Sauce>(
                  title: const Text("Сырный"),
                  value: Sauce.cheese,
                  groupValue: _sauce,
                  onChanged: _onSauceChanged,
                ),
                SizedBox(
                  width: 300,
                  child: Card(
                    elevation: 0,
                    color: const Color(0xFFF0F0F0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                          ),
                          child: SizedBox(
                            width: 38,
                            height: 56,
                            child: Image.asset('assets/cheese.png'),
                          ),
                        ),
                        const Text('Дополнительный сыр',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF263238))),
                        Switch(
                          value: _cheese,
                          onChanged: (bool value) {
                            setState(() {
                              _cheese = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: const Text("Стоимость:  ",
                      style: TextStyle(fontSize: 18, color: Color(0xFF000000))),
                ),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: Card(
                    elevation: 0,
                    color: const Color(0xFFF0F0F0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "${_calcCost()}руб. ",
                      style: const TextStyle(
                          fontSize: 32, color: Color(0xFF000000)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                    width: 154,
                    height: 42,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Заказать'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF0079D0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36.0),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
