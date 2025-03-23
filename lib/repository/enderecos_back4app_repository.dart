import 'package:consultarcep/model/enderecos_back4app_model.dart';
import 'package:consultarcep/model/viacep_model.dart';
import 'package:consultarcep/repository/back4app_custom_dio.dart';

class EnderecosBack4appRepository {
  final _customDio = Back4appCustomDio();

  EnderecosBack4appRepository();

  Future<EnderecosBack4appModel> obterEnderecos() async {
    var url = "/Enderecos";
    var result = await _customDio.dio.get(url);
    return EnderecosBack4appModel.fromJson(result.data);
  }

  Future<void> adicionarEndereco(ViaCEPModel endereco) async {
    try {
      await _customDio.dio.post("/Enderecos", data: {
        "cep": endereco.cep ?? '',
        "logradouro": endereco.logradouro ?? '',
        "complemento": endereco.complemento ?? '',
        "unidade": endereco.unidade ?? '',
        "bairro": endereco.bairro ?? '',
        "localidade": endereco.localidade ?? '',
        "uf": endereco.uf ?? '',
        "estado": endereco.estado ?? '',
        "regiao": endereco.regiao ?? '',
        "ibge": endereco.ibge ?? '',
        "gia": endereco.gia ?? '',
        "ddd": endereco.ddd ?? '',
        "siafi": endereco.siafi ?? '',
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> atualizar(EnderecoBack4appModel endereco) async {
    try {
      await _customDio.dio.put("/Enderecos/${endereco.objectId}",
          data: endereco.atualizarEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<bool> remover(String objectId) async {
    try {
      await _customDio.dio.delete("/Enderecos/$objectId");
      return true;
    } catch (e) {
      return false;
    }
  }
}
