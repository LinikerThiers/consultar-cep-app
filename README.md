# Consulta CEP

Este projeto é uma aplicação Flutter que permite consultar endereços a partir de um CEP ou buscar CEPs a partir de um endereço (cidade, estado e logradouro). Além disso, ele permite salvar os endereços consultados em um banco de dados na nuvem utilizando o Back4App.

## Imagens do Aplicativo

<img src="https://github.com/user-attachments/assets/7c6e8ffb-6f93-4202-97fe-fb2683c82de4" width="200">
<img src="https://github.com/user-attachments/assets/596d7744-7131-472d-8f69-6c9bfc756c52" width="200">
<img src="https://github.com/user-attachments/assets/2c43232e-cc26-4ae0-8d88-047b3ef5ea44" width="200">
<img src="https://github.com/user-attachments/assets/ff0e303d-2387-45d0-9dbd-79223415f3a9" width="200">
<img src="https://github.com/user-attachments/assets/98a1a8a8-82ac-4d23-a59a-9072dc61e3af" width="200">
<img src="https://github.com/user-attachments/assets/b37cbe7e-e887-449b-abee-683008bcbe29" width="200">
<img src="https://github.com/user-attachments/assets/57327f97-9e00-4766-a48e-274707b41cdd" width="200">

## Funcionalidades

- **Consulta por CEP**: Busca um endereço completo a partir de um CEP.
- **Consulta por Endereço**: Busca CEPs a partir de um endereço (cidade, estado e logradouro).
- **Salvar Endereços**: Salva os endereços consultados em um banco de dados na nuvem.
- **Listar Endereços Salvos**: Exibe uma lista de endereços salvos, com a possibilidade de remover ou visualizar detalhes.

## APIs Utilizadas

### ViaCEP
A API [ViaCEP](https://viacep.com.br/) é utilizada para consultar endereços a partir de um CEP e para buscar CEPs a partir de um endereço.

### Back4App
O [Back4App](https://www.back4app.com/) é uma plataforma que oferece um banco de dados na nuvem baseado no Parse Server. Ele é utilizado para salvar os endereços consultados.

## Estrutura do Projeto

### Arquivos Principais

- `main.dart`: Ponto de entrada da aplicação. Carrega as variáveis de ambiente e inicializa o app.
- `my_app.dart`: Define o tema da aplicação e configura a navegação inicial para a `SplashScreen`.
- `splash_screen.dart`: Tela de splash que exibe uma logo e redireciona para a tela principal após 3 segundos.
- `main_page.dart`: Tela principal que gerencia a navegação entre as páginas de busca e endereços salvos.
- `busca_page.dart`: Tela para realizar consultas de CEP ou endereço.
- `salvos_page.dart`: Tela para listar os endereços salvos, com opções de remoção e visualização de detalhes.
- `viacep_model.dart`: Modelo de dados para os endereços retornados pela API ViaCEP.
- `enderecos_back4app_model.dart`: Modelo de dados para os endereços salvos no Back4App.
- `back4app_custom_dio.dart`: Configuração do cliente HTTP (Dio) para interagir com o Back4App.
- `back4app_dio_interceptor.dart`: Interceptor para adicionar headers às requisições do Back4App.
- `enderecos_back4app_repository.dart`: Repositório para gerenciar as operações de CRUD no Back4App.
- `viacep_repository.dart`: Repositório para consultar a API ViaCEP.
- `result_dialog.dart`: Widget para exibir os resultados das consultas e permitir salvar endereços.

### Pastas

- `lib/model`: Contém os modelos de dados utilizados no projeto.
- `lib/repository`: Contém as classes responsáveis por fazer as requisições às APIs.
- `lib/shared/widget`: Contém widgets reutilizáveis.
- `lib/pages`: Contém as páginas da aplicação.

## Configuração do Projeto

### Pré-requisitos

- [Flutter](https://flutter.dev/) instalado e configurado.
- Conta no [Back4App](https://www.back4app.com/) para configurar o banco de dados.

### Passos para Configuração

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/LinikerThiers/consultar-cep-app.git
   cd consulta-cep
   ```

2. **Instale as dependências**:
   ```bash
   flutter pub get
   ```

3. **Configuração do Back4App**:

   - Crie uma nova aplicação no Back4App.
   - Crie uma classe chamada `Endereco` com os seguintes campos:

     ```text
     cep (String)
     logradouro (String)
     complemento (String)
     bairro (String)
     localidade (String)
     uf (String)
     ibge (String)
     gia (String)
     ddd (String)
     siafi (String)
     ```

   - Obtenha as chaves de API (`Application ID` e `REST API Key`) da sua aplicação no Back4App.

4. **Configuração das Chaves de API**:

   No arquivo `.env`, adicione as seguintes variáveis de ambiente:

   ```env
   BACK4APPBASEURL="SUA_BACK4APP_BASE_URL"
   BACK4APPAPLICATIONID="SUA_APPLICATION_ID"
   BACK4APPRESTAPIKEY="SUA_REST_API_KEY"
   ```

5. **Execute o projeto**:
   ```bash
   flutter run
   ```

## Como Usar

### Tela Inicial

Ao abrir o app, você será redirecionado para a tela de busca após 3 segundos.

### Buscar por CEP

1. Selecione a opção "Buscar por CEP".
2. Insira o CEP no campo de texto e clique em "Buscar".
3. O endereço correspondente será exibido em um diálogo, com a opção de salvar.

### Buscar por Endereço

1. Selecione a opção "Buscar por Cidade".
2. Insira o estado (UF), cidade e logradouro nos campos de texto e clique em "Buscar".
3. Os CEPs correspondentes serão exibidos em um diálogo, com a opção de salvar.

### Endereços Salvos

- Na aba "Salvos", você pode visualizar todos os endereços salvos.
- Clique em um endereço para ver os detalhes ou deslize para a esquerda para removê-lo.
