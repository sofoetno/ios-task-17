import UIKit

class ViewController: UIViewController {
    private let maincStackView = UIStackView()
    private var collectionView: UICollectionView?
    private var movies: [Movie] = []
    private let mainLabel = UILabel()
    private let topBar = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        NetworkService.shared.movieList { [weak self] (movies: [MovieModel]?, error: Error?) in
            if let _ = error {
                return
            }
            
            self?.movies = movies!.map({
                Movie(
                    name: $0.title,
                    genre: $0.title,
                    rating: $0.voteAverage,
                    description: $0.overview,
                    imageUrl: $0.posterPath,
                    coverImageUrl: $0.posterPath,
                    details: [
                        ("Certificate", "15+"),
                        ("Runtime", "02:56"),
                        ("Release", "2022"),
                        ("Genre", "Action, Crime, Drama"),
                        ("Director", "Matt Reeves"),
                        ("Cast", "Robert Pattinson, Zoë Kravitz, Jeffrey Wright, Colin Farrell, Paul Dano, John Turturro, Andy Serkis, Peter Sarsgaard"),
                    ]
                )
            })
            
            self?.collectionView?.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self?.collectionView?.reloadData()
            }
        }
        
        view.backgroundColor = UIColor(red: 0.1, green: 0.13, blue: 0.2, alpha: 1)
        
        setupTopbar()
        setupMainStackView()
        setupConstraints()
    }
    
    func setupTopbar() {
        let logo = UIImageView()
        logo.image = UIImage(named: "Product Logo")
        logo.frame = CGRect(x: 0, y: 0, width: 33, height: 37)
        
        let profileButton = ButtonWithPadding()
        profileButton.setPadding(top: 8, left: 16, bottom: 8, right: 16)
        profileButton.setTitle("Profile", for: .normal)
        profileButton.backgroundColor = UIColor(red: 1, green: 0.5, blue: 0.21, alpha: 1)
        profileButton.layer.cornerRadius = 8
        
        topBar.addArrangedSubview(logo)
        topBar.addArrangedSubview(profileButton)
        topBar.alignment = .center
        topBar.axis = .horizontal
        topBar.distribution = .equalSpacing
        
        view.addSubview(topBar)
    }
    
    func setupMainStackView() {
        maincStackView.backgroundColor = UIColor(red: 0.1, green: 0.13, blue: 0.2, alpha: 1)
        
        maincStackView.axis = .vertical
        maincStackView.spacing = 15
        
        mainLabel.text = "Now in cinemas"
        mainLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        mainLabel.textColor = .white
        
        maincStackView.addArrangedSubview(mainLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collectionView?.backgroundColor = UIColor(red: 0.1, green: 0.13, blue: 0.2, alpha: 1)
        
        maincStackView.addArrangedSubview(collectionView!)
        
        view.addSubview(maincStackView)
    }
    
    func setupConstraints() {
        maincStackView.translatesAutoresizingMaskIntoConstraints = false
        topBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            topBar.heightAnchor.constraint(equalToConstant: 64),
            
            maincStackView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            maincStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            maincStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            maincStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell
        
        cell?.configure(movie: movies[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 164, height: 300)
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newItem = MovieInformationViewController()
        
        newItem.movie = movies[indexPath.row]
        
        self.navigationController?.pushViewController(newItem, animated: true)
    }
}
