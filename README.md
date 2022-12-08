# Movies APP

## Ideia do aplicativo
Aplicativo que consome a TMDB API, onde você pode buscar o filme que deseja, ver os detalhes como sinópse, avaliação, comentários, filmes similares e adicioná-lo a lista de favoritos. 

https://user-images.githubusercontent.com/101711941/206420938-1f4cfec2-85e7-427a-a9e8-9790e748d3fc.mp4

## Principais Tecnologias
* Swift e UIKit
* Gerenciador de dependências:  Cocoapods
* Requisições para API TMDB
* SDWebImage para baixar imagens de forma assíncrona e cache em memória.

## Como rodar
* Abrir o terminal e rodar o comando pod Install no diretório do projeto 
* Utilizar o Xcode para abrir o arquivo MariFlix.xcworkspace

## Sobre o aplicativo
* O aplicativo possui 3 telas principais: 

* Tela de Home: 
    * Em uma TableView, listamos os filmes da API TMDB;
    * Utilizando um Segmented Control, temos a opção de “Filmes Populares” ou “Top Filmes” para selecionar o tipo desejado;
    * Utilizando um Searchbar, o usuário pode buscar o filme desejado;
    * Utilizando a dependência do SDWebImage para carregar as imagens das células da TableView de forma assíncrona.
    * Detectamos o clique do usuário para abrir uma Tela de Detalhe do Filme. 

* Tela de Favoritos:
    * Em uma TableView, apresentamos os filmes favoritados pelo usuário;
    * Também é possível favoritar e desfavoritar um filme na Tela de favoritos;
    * Criamos uma classe chamada MovieStorage quem tem a responsabilidade em armazenar e entregar itens persistidos no UserDefault;
    * Detectamos o clique do usuário para abrir uma Tela de Detalhe do Filme.

* Tela de Detalhes: 
    * Em uma TableView, apresentamos as informações básicas do filme. Na primeira célula, utilizamos a dependência do SDWebImage para carregar a imagem, a avaliação e a descrição do filme. Na segunda célula, apresentamos um botão em que é possível favoritar o filme. Já  na terceira apresentamos o segmented control, onde é possível selecionar entre “ver os filmes similares” ou os “comentários” através de uma collectionView apresentando itens na Horizontal. 

* Implementamos uma TabBar como estrutura central do aplicativo para acessar a Tela de Home e a Tela de Favoritos.

* Trabalhamos com completion e delegate para treinar diferentes maneiras de transporte de dados no aplicativo.

* Utilizamos a URLRequest para fazer a requisição dos dados 

