import 'package:consultarcep/model/viacep_model.dart';
import 'package:dio/dio.dart';

class ViaCEPRepository {
  Future<ViaCEPModel> consultarPorCep(String cep) async {
    var dio = Dio();
    var result = await dio.get("https://viacep.com.br/ws/$cep/json/");
    var viaCepModel = ViaCEPModel.fromJson(result.data);
    return viaCepModel;
  }

  Future<List<ViaCEPModel>> consultarPorCidade(String uf, String cidade, String logradouro) async {
    var dio = Dio();
    var result = await dio.get("https://viacep.com.br/ws/$uf/$cidade/$logradouro/json/");
    List<ViaCEPModel> viaCepModel = (result.data as List).map((json) => ViaCEPModel.fromJson(json)).toList();
    return viaCepModel;
  }
}
