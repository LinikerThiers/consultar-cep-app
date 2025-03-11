import 'package:consultarcep/model/viacep_model.dart';
import 'package:consultarcep/repository/enderecos_back4app_repository.dart';
import 'package:flutter/material.dart';

class ResultDialog extends StatefulWidget {
  final dynamic result;
  const ResultDialog({super.key, this.result});

  @override
  State<ResultDialog> createState() => _ResultDialogState();
}

class _ResultDialogState extends State<ResultDialog> {
  EnderecosBack4appRepository enderecosBack4appRepository =
      EnderecosBack4appRepository();

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
                        onPressed: () async {
                          bool sucesso = await _salvarEndereco(endereco);

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  sucesso
                                      ? "Endereço salvo com sucesso!"
                                      : "Erro ao salvar o endereço!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor:
                                    sucesso ? Colors.green : Colors.red,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.all(16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                duration: Duration(seconds: 2),
                              ),
                            );

                            await Future.delayed(Duration(seconds: 2));

                            if (mounted) {
                              Navigator.pop(context);
                            }
                          }
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

  Future<bool> _salvarEndereco(ViaCEPModel endereco) async {
    try {
      await enderecosBack4appRepository.adicionarEndereco(endereco);
      return true;
    } catch (e) {
      return false;
    }
  }
}
