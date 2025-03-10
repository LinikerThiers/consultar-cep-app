import 'package:consultarcep/pages/busca_page.dart';
import 'package:consultarcep/pages/salvos_page.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
              child: PageView(
            controller: controller,
            onPageChanged: (value) {
              setState(() {
                posicaoPagina = value;
              });
            },
            children: [
              BuscaPage(),
              SalvosPage(),
            ],
          )),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BottomNavigationBar(
                    backgroundColor: Colors.amber[600],
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.blue[800],
                    type: BottomNavigationBarType.fixed,
                    onTap: (value) {
                      controller.jumpToPage(value);
                    },
                    currentIndex: posicaoPagina,
                    items: [
                      BottomNavigationBarItem(
                        label: "Buscar",
                        icon: Icon(Icons.location_on),
                      ),
                      BottomNavigationBarItem(
                        label: "Salvos",
                        icon: Icon(Icons.save_alt),
                      ),
                    ]),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
