import 'package:consultarcep/model/enderecos_back4app_model.dart';
import 'package:consultarcep/repository/enderecos_back4app_repository.dart';
import 'package:flutter/material.dart';

class SalvosPage extends StatefulWidget {
  const SalvosPage({super.key});

  @override
  State<SalvosPage> createState() => _SalvosPageState();
}

class _SalvosPageState extends State<SalvosPage> {
  EnderecosBack4appRepository enderecosBack4appRepository =
      EnderecosBack4appRepository();
  var _enderecosBack4app = EnderecosBack4appModel([]);
  var carregando = false;

  @override
  void initState() {
    super.initState();
    obterEnderecos();
  }

  Future<void> obterEnderecos() async {
    setState(() {
      carregando = true;
    });

    try {
      _enderecosBack4app = await enderecosBack4appRepository.obterEnderecos();
    } catch (e) {
      print("Erro ao obter endereços: $e");
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Endereços Salvos",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: carregando
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.amber.shade600),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _enderecosBack4app.enderecos.length,
                      itemBuilder: (context, index) {
                        var endereco = _enderecosBack4app.enderecos[index];
                        return Dismissible(
                          key: Key(endereco.objectId.toString()),
                          onDismissed:
                              (DismissDirection dismissDirection) async {
                            String objectId = endereco.objectId.toString();

                            bool removido = await enderecosBack4appRepository
                                .remover(objectId);

                            if (mounted) {
                              setState(() {
                                _enderecosBack4app.enderecos
                                    .removeWhere((e) => e.objectId == objectId);
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        removido
                                            ? "Endereço removido com sucesso!"
                                            : "Erro ao remover o endereço!",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "CEP: ${endereco.cep}\n"
                                        "Logradouro: ${endereco.logradouro}\n"
                                        "Localidade: ${endereco.localidade} - ${endereco.uf}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  backgroundColor:
                                      removido ? Colors.green : Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          },
                          background: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.red,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerRight,
                              child: const Icon(Icons.delete,
                                  color: Colors.white, size: 30),
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          child: GestureDetector(
                            onTap: () {
                              _mostrarDetalhesEndereco(context, endereco);
                            },
                            child: Card(
                              color: Colors.blue[700],
                              margin: const EdgeInsets.all(10),
                              elevation: 3,
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      endereco.logradouro.toString(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              _mostrarEditarEndereco(
                                                  context, endereco);
                                            },
                                            child: Icon(Icons.edit,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  "CEP: ${endereco.cep} | ${endereco.localidade} - ${endereco.uf}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarDetalhesEndereco(
      BuildContext context, EnderecoBack4appModel endereco) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.amber[50],
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Detalhes do Endereço",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700]),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.blue[700],
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text("CEP: ${endereco.cep}",
                  style: TextStyle(
                      color: Colors.blue[700], fontWeight: FontWeight.bold)),
              Text("Logradouro: ${endereco.logradouro}",
                  style: TextStyle(
                      color: Colors.blue[700], fontWeight: FontWeight.bold)),
              Text("Complemento: ${endereco.complemento}",
                  style: TextStyle(
                      color: Colors.blue[700], fontWeight: FontWeight.bold)),
              Text("Unidade: ${endereco.unidade}",
                  style: TextStyle(
                      color: Colors.blue[700], fontWeight: FontWeight.bold)),
              Text("Bairro: ${endereco.bairro}",
                  style: TextStyle(
                      color: Colors.blue[700], fontWeight: FontWeight.bold)),
              Text("Cidade: ${endereco.localidade}",
                  style: TextStyle(
                      color: Colors.blue[700], fontWeight: FontWeight.bold)),
              Text("UF: ${endereco.uf}",
                  style: TextStyle(
                      color: Colors.blue[700], fontWeight: FontWeight.bold)),
              Text("Estado: ${endereco.estado}",
                  style: TextStyle(
                      color: Colors.blue[700], fontWeight: FontWeight.bold)),
              Text("Região: ${endereco.regiao}",
                  style: TextStyle(
                      color: Colors.blue[700], fontWeight: FontWeight.bold)),
              Text("Ibge: ${endereco.ibge}",
                  style: TextStyle(
                      color: Colors.blue[700], fontWeight: FontWeight.bold)),
              Text("Gia: ${endereco.gia}",
                  style: TextStyle(
                      color: Colors.blue[700], fontWeight: FontWeight.bold)),
              Text("DDD: ${endereco.ddd}",
                  style: TextStyle(
                      color: Colors.blue[700], fontWeight: FontWeight.bold)),
              Text("Siafi: ${endereco.siafi}",
                  style: TextStyle(
                      color: Colors.blue[700], fontWeight: FontWeight.bold)),
              SizedBox(
                height: 35,
              ),
            ],
          ),
        );
      },
    );
  }

  void _mostrarEditarEndereco(
      BuildContext context, EnderecoBack4appModel endereco) {
    final logradouroController =
        TextEditingController(text: endereco.logradouro);
    final complementoController =
        TextEditingController(text: endereco.complemento);
    final bairroController = TextEditingController(text: endereco.bairro);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Editar Endereço",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700]),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.blue[700],
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: logradouroController,
                    style: TextStyle(
                      color: Colors.blue[700],
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue[50],
                      contentPadding: EdgeInsets.only(top: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.blue[700],
                      ),
                      hintText: "Logradouro",
                      hintStyle: TextStyle(
                        color: Colors.blue[700],
                      ),
                      counterText: "",
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: complementoController,
                    style: TextStyle(
                      color: Colors.blue[700],
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue[50],
                      contentPadding: EdgeInsets.only(top: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        Icons.apartment,
                        color: Colors.blue[700],
                      ),
                      hintText: "Complemento",
                      hintStyle: TextStyle(
                        color: Colors.blue[700],
                      ),
                      counterText: "",
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: bairroController,
                    style: TextStyle(
                      color: Colors.blue[700],
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue[50],
                      contentPadding: EdgeInsets.only(top: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(
                        Icons.location_city,
                        color: Colors.blue[700],
                      ),
                      hintText: "Bairro",
                      hintStyle: TextStyle(
                        color: Colors.blue[700],
                      ),
                      counterText: "",
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        endereco.logradouro = logradouroController.text;
                        endereco.complemento = complementoController.text;
                        endereco.bairro = bairroController.text;

                        Navigator.pop(context);

                        try {
                          await enderecosBack4appRepository.atualizar(endereco);
                          await obterEnderecos();
                          if (mounted) {
                            setState(() {});
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text("Endereço atualizado com sucesso!")),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text("Erro ao atualizar endereço: $e")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Salvar Alterações",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
