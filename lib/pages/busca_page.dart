import 'package:flutter/material.dart';

class BuscaPage extends StatefulWidget {
  const BuscaPage({
    super.key,
  });

  @override
  State<BuscaPage> createState() => _BuscaPageState();
}

class _BuscaPageState extends State<BuscaPage> {
  String _selectedOption = "cep";
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[600],
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 65,
              ),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/consulta_cep_logo.png",
                      height: 100,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 65,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: 'cep',
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value.toString();
                                });
                              },
                              fillColor: WidgetStateProperty.resolveWith<Color>(
                                  (states) {
                                if (states.contains(WidgetState.selected)) {
                                  return Colors.blue;
                                }
                                return Colors.blue.shade100;
                              }),
                            ),
                            Text(
                              "Buscar por CEP",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(width: 20),
                            Radio(
                              value: 'cidade',
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value.toString();
                                });
                              },
                              fillColor: WidgetStateProperty.resolveWith<Color>(
                                  (states) {
                                if (states.contains(WidgetState.selected)) {
                                  return Colors.blue;
                                }
                                return Colors.blue.shade100;
                              }),
                            ),
                            Text(
                              "Buscar por Cidade",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        if (_selectedOption == 'cep')
                          TextField(
                            controller: _cepController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.amber[50],
                              contentPadding: EdgeInsets.only(top: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(
                                Icons.location_on_outlined,
                                color: Colors.blueAccent,
                              ),
                              hintText: "CEP",
                              hintStyle: TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        if (_selectedOption == 'cidade')
                          Column(
                            children: [
                              TextField(
                                controller: _estadoController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.amber[50],
                                  contentPadding: EdgeInsets.only(top: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.blueAccent,
                                  ),
                                  hintText: "Estado (UF)",
                                  hintStyle: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _cidadeController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.amber[50],
                                  contentPadding: EdgeInsets.only(top: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.location_city_rounded,
                                    color: Colors.blueAccent,
                                  ),
                                  hintText: "Cidade",
                                  hintStyle: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _logradouroController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.amber[50],
                                  contentPadding: EdgeInsets.only(top: 0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.home_filled,
                                    color: Colors.blueAccent,
                                  ),
                                  hintText: "Logradouro (Rua)",
                                  hintStyle: TextStyle(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  Colors.blue), // Cor de fundo
                            ),
                            onPressed: () {
                              if (_selectedOption == 'cep') {
                                String cep = _cepController.text;
                                print("Buscar CEP: $cep");
                              } else {
                                String uf = _estadoController.text;
                                String cidade = _cidadeController.text;
                                String logradouro = _logradouroController.text;
                                print("Buscar Cidade: $uf, $cidade, $logradouro");
                              }
                            },
                            child: Text("Buscar", style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
