import 'package:consultarcep/model/viacep_model.dart';
import 'package:consultarcep/repository/viacep_repository.dart';
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
  bool loading = false;
  var viaCEPModel = ViaCEPModel();
  var viaCEPRepository = ViaCEPRepository();

  Widget _buildResultDialog(dynamic result) {
    List<ViaCEPModel> enderecos =
        (result is List<ViaCEPModel>) ? result : [result];

    return AlertDialog(
      backgroundColor: Colors.amber[50],
      title: Text(
        enderecos.length == 1 ? "Resultado do CEP" : "Resultados encontrados",
        style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: enderecos.map((endereco) {
            return Card(
              color: Colors.blue[700],
              margin: EdgeInsets.only(bottom: 20),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        child: Text(
                          "Salvar",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          _salvarEndereco(endereco);
                        },
                      ),
                    ),
                    Text("CEP: ${endereco.cep}",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 10),
                    Text("Logradouro: ${endereco.logradouro}",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 10),
                    Text("Complemento: ${endereco.complemento}",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 10),
                    Text("Bairro: ${endereco.bairro}",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 10),
                    Text("Localidade: ${endereco.localidade}",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 10),
                    Text("UF: ${endereco.uf}",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 10),
                    Text("IBGE: ${endereco.ibge}",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(height: 10),
                    Text("DDD: ${endereco.ddd}",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Fechar",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  void _salvarEndereco(ViaCEPModel endereco) {}

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
                            style: TextStyle(
                              color: Colors.blue[600],
                              fontSize: 16,
                            ),
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
                                style: TextStyle(
                                  color: Colors.blue[600],
                                  fontSize: 16,
                                ),
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
                                style: TextStyle(
                                  color: Colors.blue[600],
                                  fontSize: 16,
                                ),
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
                                style: TextStyle(
                                  color: Colors.blue[600],
                                  fontSize: 16,
                                ),
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
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () async {
                              if (_selectedOption == 'cep') {
                                String cep = _cepController.text
                                    .replaceAll(RegExp(r'[^0-9]'), '');
                                if (cep.length == 8) {
                                  setState(() {
                                    loading = true;
                                  });

                                  try {
                                    viaCEPModel = await viaCEPRepository
                                        .consultarPorCep(cep);

                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext bc) {
                                        return _buildResultDialog(viaCEPModel);
                                      },
                                    );
                                  } catch (e) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext bc) {
                                        return AlertDialog(
                                          title: Text("Erro"),
                                          content: Text(
                                              "Não foi possível consultar o CEP: $e"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("OK"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } finally {
                                    setState(() {
                                      loading = false;
                                    });
                                  }
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext bc) {
                                      return AlertDialog(
                                        title: Text("CEP inválido"),
                                        content: Text(
                                            "O CEP deve conter exatamente 8 dígitos."),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else {
                                String uf =
                                    _estadoController.text.toUpperCase();
                                String cidade =
                                    _cidadeController.text.toLowerCase();
                                String logradouro =
                                    _logradouroController.text.toLowerCase();

                                setState(() {
                                  loading = true;
                                });

                                try {
                                  List<ViaCEPModel> enderecos =
                                      await viaCEPRepository.consultarPorCidade(
                                          uf, cidade, logradouro);
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext bc) {
                                      return _buildResultDialog(enderecos);
                                    },
                                  );
                                } catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext bc) {
                                      return AlertDialog(
                                        title: Text("Erro"),
                                        content: Text(
                                            "Não foi possível consultar o endereço: $e"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("OK"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } finally {
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              }
                            },
                            child: loading
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  )
                                : Text(
                                    "Buscar",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
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
