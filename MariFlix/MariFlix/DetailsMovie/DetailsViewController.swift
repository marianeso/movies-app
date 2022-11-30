//
//  DetailsViewController.swift
//  MariFlix
//
//  Created by Wellington on 01/06/22.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak private var DetailsTable: UITableView!
    
    private let movieStorage = MovieStorage()

    private let detailsManager = DetailsMovieManager ()  // colocando a classe dentro da variavel
    
    private var detailsMovie: DetailsMovieResponse? //criando uma variavel do tipo Movie
    
    var movie: Movie?
    
    private var segmentedControlIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        
        self.fetchDetailsMovie()
        
        navigationController?.hidesBarsOnSwipe = false

    }
    
    private func fetchDetailsMovie() {
        
        let movieID = self.movie?.id ?? 0
        self.detailsManager.fetchDetailsMovieWithCompletion(movieID: String(movieID))  { detailsMovie in
            DispatchQueue.main.async {
                self.detailsMovie = detailsMovie   //pegar o details Movie do movieID escolhido e apresentar na tela.
                self.DetailsTable.reloadData()
            }
        }
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func setupTableView() {
        self.DetailsTable.dataSource = self
        self.DetailsTable.delegate = self
        
        self.DetailsTable.registerNib(DescriptionTableViewCell.self)
        self.DetailsTable.registerNib(SegmentedControlTableViewCell.self)
        self.DetailsTable.registerNib(FichaTecnicaTableViewCell.self)
        self.DetailsTable.registerNib(ReviewsTableViewCell.self)
        self.DetailsTable.registerNib(SimilarMovieTableViewCell.self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row{
            
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell") as? DescriptionTableViewCell else {
                return UITableViewCell()
            }
            
            cell.delegate = self
            
            
            let storageMovie = self.movieStorage.getMovie(movieID: detailsMovie?.id ?? 0)
            let isSelect = storageMovie != nil ? true : false

            cell.setup_Details(image: detailsMovie?.backdrop_path ?? "" ,
                               nameFilm: detailsMovie?.title ?? "",
                               voute: detailsMovie?.voteAverage ?? 0,
                               details: detailsMovie?.overview ?? "",
                               movieID: detailsMovie?.id ?? 0,
                               isSelect: isSelect)
            
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SegmentedControlTableViewCell") as? SegmentedControlTableViewCell else {
                return UITableViewCell()
            }
            
            cell.delegate = self

            return cell
            
        case 2:
            switch segmentedControlIndex {
                
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "SimilarMovieTableViewCell") as? SimilarMovieTableViewCell else {
                    return UITableViewCell()
                }
                cell.delegate = self
                
                let movieID = self.movie?.id ?? 0
                cell.setup(movieID: String(movieID))
                return cell
                
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell") as? ReviewsTableViewCell else {
                    return UITableViewCell()
                }
                let movieID = self.movie?.id ?? 0
                cell.setup(movieID: String(movieID))
                
                return cell
                
            default:
                break
                
            }
        default:
            break
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 && indexPath.section == 0 {
            return 220
        }
        if indexPath.row == 0 && indexPath.section == 0 {
            return 480
        }
        else {
            return UITableView.automaticDimension
        }
    }
    
}


// MARK: - SegmentedManagerDelegate
// para os botoes de click. A variavel segmentedControlIndex é preenchida para usar acima de acordo com o click. Quando o click [e feito, recarrega a tabela para recarregar a celula necessaria.
extension DetailsViewController: SegmentedManagerDelegate {
    
    func didClickSegmentedControl(click: Int) {
        
        self.segmentedControlIndex = click
        
        self.DetailsTable.reloadData()
    }
}

// MARK: - DescriptionTableViewCellDelegate

extension DetailsViewController: DescriptionTableViewCellDelegate {
    
    func didClickAddButton(movieID: Int, isSelect:Bool) {
        
        let movie = LocalMovie(movieID: detailsMovie?.id ?? 0,
                               backdrop_path: detailsMovie?.backdrop_path ?? "",
                               originalTitle: detailsMovie?.originalTitle ?? "",
                               releaseDate: detailsMovie?.releaseDate ?? "",
                               voteAverage: detailsMovie?.voteAverage ?? 0,
                               overview: detailsMovie?.overview ?? "")
        
        if isSelect == true {
            self.movieStorage.save(movieID: movieID, movie: movie)
        } else {
            self.movieStorage.delete(movieID: movieID)
        }
    }
}

// MARK: - SimilarMovieTableViewCellDelegate

extension DetailsViewController: SimilarMovieTableViewCellDelegate {
    func didClickFilm(selectedMovie: SimilarMovie) {
        var movie = Movie()
        movie.id = selectedMovie.id
        movie.originalTitle = selectedMovie.originalTitle
        movie.overview = selectedMovie.overview
        movie.backdrop_path = selectedMovie.backdropPath
        movie.title = selectedMovie.title
        movie.voteAverage = selectedMovie.voteAverage
        
        let detailsView = DetailsViewController()
        detailsView.movie = movie
        self.navigationController?.pushViewController(detailsView, animated: true)
        self.navigationController?.navigationBar.tintColor = .white
    }
}
