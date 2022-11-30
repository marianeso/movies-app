//
//  HomeViewController.swift
//  MariFlix
//
//  Created by Wellington on 01/06/22.
//

import UIKit



final class HomeViewController: UIViewController {
    
    @IBOutlet weak private var homeTable: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var switchPopTop: UISegmentedControl!
    
    private let movieStorage = MovieStorage()

    private let popMovieManager = PopularMovieManager()  // colocando a classe dentro da variavel
    private let topMovieManager = TopMovieManager()  // colocando a classe dentro da variavel
    
    private var popularMovies: [Movie] = []  //criando uma variavel do tipo Movie
    private var topMovies: [Movie] = []  //criando uma variavel do tipo Movie
    private var filteredMovies: [Movie] = []  //criando uma variavel do tipo Movie
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.setupSearchBar()
        self.fetchPopularMovie()
        self.setupSegmentedControl()
    }
    
    private func fetchPopularMovie() {
        self.popMovieManager.fetchPopularMovieWithCompletion { popularMovies in
            DispatchQueue.main.async {
                self.popularMovies = popularMovies ?? []
                self.filteredMovies = self.popularMovies
                self.homeTable.reloadData()
            }
        }
    }
    
    // MARK: - viewWillAppear

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.homeTable.reloadData()
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        self.homeTable.dataSource = self
        self.homeTable.delegate = self

        self.homeTable.registerNib(FIlmTableViewCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FIlmTableViewCell") as? FIlmTableViewCell else {
                return UITableViewCell()
        }
        
        //escuta o clique que tiver na celula
        cell.delegate = self
        
        let movie = self.filteredMovies[indexPath.row]
        
        //acesso ao banco para saber se o drink.id está favoritado ou nao
        let storageMovie = self.movieStorage.getMovie(movieID: movie.id ?? 0)
        let isFavorite = storageMovie != nil ? true : false
        
        cell.setup(movieID: movie.id ?? 0,
                   image: movie.backdrop_path ?? "",
                   nameFilm: movie.originalTitle ?? "",
                   yearFIlm: movie.releaseDate ?? "",
                   rateFilme: movie.voteAverage ?? 0,
                   isFavorite: isFavorite)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsView = DetailsViewController()
        let movie = self.filteredMovies[indexPath.row]
        detailsView.movie = movie
        self.navigationController?.pushViewController(detailsView, animated: true)
        self.navigationController?.navigationBar.tintColor = .white

    }
}


// MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate {
    
    private func setupSearchBar() {
        self.searchBar.backgroundColor = .black //customiza
        self.searchBar.searchTextField.backgroundColor = .white
        self.searchBar.searchTextField.placeholder = "Digite o nome do filme" //texto que vc vai ver por atras
        
        self.searchBar.delegate = self //conexao das funcoes do protocolo com o componente search bar, a tela escuta a search bar.
        
        self.navigationController?.navigationBar.topItem?.titleView = self.searchBar
        self.navigationController?.hidesBarsOnSwipe = true //quando scrolla a tela, esconde a search bar
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { //nao precisa chamar a funcao pq [e um delegate da searchbar, os delegates sao escutados
        
        if searchText == "" {
            self.reloadTableViewWithoutFilter()
        } else {
            self.reloadTableViewWithFilter(searchText: searchText)
        }
    }
    
    private func reloadTableViewWithFilter(searchText: String) { // private deixa a função privada na classe
        self.filteredMovies = []
        
        let digitedText = searchText.lowercased() //lowercased: coloca todos os caracteres minusculos - texto digitado pelo usuário
        

        DispatchQueue.main.async {
            for movieSelect in self.popularMovies {
                let movieName = movieSelect.originalTitle?.lowercased()
                if movieName?.contains(digitedText) == true { // contains: o texto existe em outro texto
                    self.filteredMovies.append(movieSelect) // salva o drink cujo o nome contém o texto digitado
                }
            }
            self.homeTable.reloadData()
        }
    }
    
    private func reloadTableViewWithoutFilter() {
        DispatchQueue.main.async {
            self.filteredMovies = self.popularMovies
            self.homeTable.reloadData()
        }
    }
}


// MARK: - FIlmTableViewCellDelegate

extension HomeViewController: FIlmTableViewCellDelegate {
    
    func didClickFavoriteButton(movieID: Int, isFavorite: Bool) {
        
        // quando usar a funcao first, devolve um array, nesse caso como é so um drink, pode usar o .first
        guard let popularMovie = self.popularMovies.filter({ $0.id ==  movieID }).first else { return }
        
        let movie = LocalMovie(movieID: popularMovie.id ?? 0,
                               backdrop_path: popularMovie.backdrop_path ?? "",
                          originalTitle: popularMovie.originalTitle ?? "",
                          releaseDate: popularMovie.releaseDate ?? "",
                          voteAverage: popularMovie.voteAverage ?? 0,
                           overview: popularMovie.overview ?? "")
        
        if isFavorite == true {
            self.movieStorage.save(movieID: movieID, movie: movie)
        } else {
            self.movieStorage.delete(movieID: movieID)
        }
    }
}


// MARK: - Segmented Control

extension HomeViewController {
    
    func setupSegmentedControl() {
        switchPopTop.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        switchPopTop.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
    }
    
    @IBAction func didClick(_ sender: Any) {
        
        let index = switchPopTop.selectedSegmentIndex
        
        switch index {
        case 0:
            self.popMovieManager.fetchPopularMovieWithCompletion { popularMovies in
                
                DispatchQueue.main.async {
                    self.popularMovies = popularMovies ?? []
                    self.filteredMovies = self.popularMovies
                    self.homeTable.reloadData()
                }
            }
        case 1:
            self.topMovieManager.fetchTopMovieWithCompletion { topMovies in
                
                DispatchQueue.main.async {
                    self.topMovies = topMovies ?? []
                    self.filteredMovies = self.topMovies
                    self.homeTable.reloadData()
                }
            }
        default:
            break
        }
    }
}





