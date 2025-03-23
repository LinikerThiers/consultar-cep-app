class EnderecosBack4appModel {
  List<EnderecoBack4appModel> enderecos = [];

  EnderecosBack4appModel(this.enderecos);

  EnderecosBack4appModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      enderecos = <EnderecoBack4appModel>[];
      json['results'].forEach((v) {
        enderecos.add(EnderecoBack4appModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = enderecos.map((v) => v.toJson()).toList();
      return data;
  }
}

class EnderecoBack4appModel {
  String? objectId;
  String? cep;
  String? logradouro;
  String? complemento;
  String? unidade;
  String? bairro;
  String? localidade;
  String? uf;
  String? estado;
  String? regiao;
  String? ibge;
  String? gia;
  String? ddd;
  String? siafi;
  String? createdAt;
  String? updatedAt;

  EnderecoBack4appModel(
      {this.objectId,
      this.cep,
      this.logradouro,
      this.complemento,
      this.unidade,
      this.bairro,
      this.localidade,
      this.uf,
      this.estado,
      this.regiao,
      this.ibge,
      this.gia,
      this.ddd,
      this.siafi,
      this.createdAt,
      this.updatedAt});

  EnderecoBack4appModel.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    unidade = json['unidade'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    estado = json['estado'];
    regiao = json['regiao'];
    ibge = json['ibge'];
    gia = json['gia'];
    ddd = json['ddd'];
    siafi = json['siafi'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['unidade'] = unidade;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['estado'] = estado;
    data['regiao'] = regiao;
    data['ibge'] = ibge;
    data['gia'] = gia;
    data['ddd'] = ddd;
    data['siafi'] = siafi;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['unidade'] = unidade;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['estado'] = estado;
    data['regiao'] = regiao;
    data['ibge'] = ibge;
    data['gia'] = gia;
    data['ddd'] = ddd;
    data['siafi'] = siafi;
    return data;
  }

  Map<String, dynamic> atualizarEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    return data;
  }

}
