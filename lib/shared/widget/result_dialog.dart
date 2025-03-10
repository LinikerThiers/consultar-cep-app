import 'package:consultarcep/model/viacep_model.dart';
import 'package:flutter/material.dart';

class ResultDialog extends StatefulWidget {
  final dynamic result;
  const ResultDialog({super.key, this.result});

  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
  @override
  Widget build(BuildContext context) {
    List<ViaCEPModel> enderecos =
        (widget.result is List<ViaCEPModel>) ? widget.result : [widget.result];
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
}
