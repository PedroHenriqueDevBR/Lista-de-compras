<h1 align="center">:shopping_cart: Lista de Compras</h1>

<p align="center">
Aplicação desenvolvida para facilitar o controle dos gastos no momento das compras.<br>
:woman: Desenvolvida para a minha mãe.
</p>

<p align="center">
<img alt="Developer" src="https://img.shields.io/badge/Developer-PedroHenriqueDevBR-green">
<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/pedrohenriquedevbr/app-market-shopping-list">
<img alt="Framework" src="https://img.shields.io/badge/Framework-Flutter-blue">
</p>

<hr>

# :memo: Visão Geral

<div>
<img src="https://raw.githubusercontent.com/PedroHenriqueDevBR/app-market-shopping-list/main/docs/screenshots/flutter_01.png" width="210" />
<img src="https://raw.githubusercontent.com/PedroHenriqueDevBR/app-market-shopping-list/main/docs/screenshots/flutter_05.png" width="210" />
</div>

Um dia fui fazer as compras com a minha mãe, fui ajudar ela a fazer as compras do mês, no decorrer das compras eu observei que ela utilizava a calculadora para manter o controle dos gastos, para saber exatamente o que estava sendo gasto, o método funciona, porém muitas dúvidas aparecem no decorrer das compras, já a única informação que possuimos no monento é o total das compras.

Abaixo algumas funcionalidades que são implementadas nessa aplicação para facilitar o gerenciamento das compras. <br>
(Funcionalidades gerais)

- [X] Saber o que está sendo comprado
- [X] Saber a quantidade do que está sendo comprado
- [X] Saber o total de cada item (Preço X Quantidade)
- [X] Divisão dos registros de compras em categorias
- [X] Manter as compras registradas
- [X] Preparar uma listas de compras com antecedência

<h1 id="tecnologias">:rocket: Tecnologias utilizadas</h1>

<br>

* <img alt="Dart" src="https://img.shields.io/badge/-Dart-blue"> - Linguagem de programação utilizada pelo Framework Flutter.
* <img alt="Flutter" src="https://img.shields.io/badge/-Flutter-blue"> - Framework utilizado no desenvolvimento da aplicação.
* <img alt="RxNotifier" src="https://img.shields.io/badge/-RxNotifier-blue"> - Biblioteca utilizada para facilitar a reatividade da aplicação.

<h1 id="modelagem">:bulb: Modelagem da aplicação</h1>

A modelagem foi criada antes de iniciar o desenvolvimento da aplicação, com o objetivo de guiar o desenvolvimento e evitar erros que pudessem atrapalhar o andamento do desenvolvimento.

<h2 id="modelagem-classes">Modelagem das classes</h2>

<img width="100%" src="https://raw.githubusercontent.com/PedroHenriqueDevBR/app-market-shopping-list/main/docs/model/model.png" />


### Descrição das páginas

* **Home page** - Página principal da aplicação, onde as categorias e as listas de compras serão listadas.

* **Criar categoria** - Página para a criação e edição de categorias.

* **Criação de lista de compras** - Página para a criação e edição de uma lista de compras.

* **Apresentação da lista de compras** - Página onde a lista de compras será gerenciada, onde é possivel adicionar novos itens e editar os itens já adicionados.

<h1 id="requisitos">:warning: Pré-requisitos</h1>

O desenvolvimento dessa aplicação utiliza como base as seguintes tecnologias e versões apresentadas abaixo. Caso ocorra algum erro na execução da aplicação ou mesmo nos comandos de configurações, verifique se a versão do Dart e do Flutter no seu computador estão devidamente atualizados.

1. Dart 2.12.4 (stable)
2. Flutter 2.2.0 (stable)
3. git version 2.17.1

<h1 id="instalacao">:information_source: Instalação</h1>

```bash
# Execute o comando abaixo e clone o repositório do projeto
git clone https://github.com/PedroHenriqueDevBR/app-market-shopping-list.git

# Acesse o projeto
cd app-market-shopping-list

# Execute o comanmdo para obter as dependências do projeto
flutter pub get 

# Por fim, para executar o projeto execute o comando abaixo
flutter run 
```

<h2 id="funcionalidades">:heavy_check_mark: Funcionalidades</h2>

- [x] Cadastro de categorias;
- [x] Edição de uma categorias;
- [x] Apresentação de todas as categorias cadastradas;
- [X] Deletar categoria (Deletar todas as listas de compras vinculadas);
- [x] Apresentação de todas as listas de compras;
- [x] Cadastrar nova lista de compras;
- [x] Editar lista de compras cadastradas;
- [x] Apresentar detalhes de uma lista de compras;
- [X] Deletar lista de compras (Deletar todos os itens vinculados);
- [x] Adicionar item em uma lista de compras;
- [x] editar item em uma lista de compras;
- [X] Remover item da lista de compras.

<h2 id="screenshots">:iphone: Screenshots (All screenshots)</h2>

<div>
<img src="https://raw.githubusercontent.com/PedroHenriqueDevBR/app-market-shopping-list/main/docs/screenshots/flutter_01.png" width="210" />
<img src="https://raw.githubusercontent.com/PedroHenriqueDevBR/app-market-shopping-list/main/docs/screenshots/flutter_02.png" width="210" />
<img src="https://raw.githubusercontent.com/PedroHenriqueDevBR/app-market-shopping-list/main/docs/screenshots/flutter_04.png" width="210" />
<img src="https://raw.githubusercontent.com/PedroHenriqueDevBR/app-market-shopping-list/main/docs/screenshots/flutter_05.png" width="210" />
<img src="https://raw.githubusercontent.com/PedroHenriqueDevBR/app-market-shopping-list/main/docs/screenshots/flutter_06.png" width="210" />
</div>
