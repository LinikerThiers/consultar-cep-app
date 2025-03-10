import 'package:consultarcep/model/enderecos_back4app_model.dart';
import 'package:consultarcep/repository/back4app_custom_dio.dart';

class EnderecosBack4appRepository {
  final _customDio = Back4appCustomDio();

  EnderecosBack4appRepository() {}

  Future<EnderecosBack4appModel> obterEnderecos() async {
    var url = "/Enderecos";
    var result = await _customDio.dio.get(url);
    return EnderecosBack4appModel.fromJson(result.data);
  }

  Future<void> adicionarEndereco(EnderecoBack4appModel endereco) async {
    try{
      await _customDio.dio.post("/Enderecos", data: endereco.toJsonEndpoint());
    } catch (e) {
      throw e;
    }
  }

  Future<void> remover(String objectId) async {
    try{
      await _customDio.dio.delete("/Enderecos/$objectId");
    } catch (e) {
      throw e;
    }
  }

}