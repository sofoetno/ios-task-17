import UIKit

class MovieCell: UICollectionViewCell {
    private let moviewStackView = UIStackView()
    private var movie: Movie?
    private var imageView = UIImageView()
    private let nameLabel = UILabel()
    private let ganreLabel = UILabel()
    private var isFavoriteButton = UIButton()
    private let ratingLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        contentView.addSubview(ganreLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(isFavoriteButton)
        contentView.addSubview(moviewStackView)
        contentView.addSubview(isFavoriteButton)
        contentView.addSubview(ratingLabel)

        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        ganreLabel.textColor = UIColor(red: 0.39, green: 0.45, blue: 0.58, alpha: 1)
        ganreLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        isFavoriteButton.setImage(UIImage(named: "greyHeart"), for: .normal)
        isFavoriteButton.addAction(UIAction(handler: { [weak self] action in
            if let isFavorite = self?.movie?.isFavorite {
                if isFavorite == true {
                    self?.movie?.isFavorite = false
                    self?.isFavoriteButton.setImage(UIImage(named: "greyHeart"), for: .normal)
                } else {
                    self?.movie?.isFavorite = true
                    self?.isFavoriteButton.setImage(UIImage(named: "heart"), for: .normal)
                }
            }
            
        }), for: .touchUpInside)
        
        ratingLabel.backgroundColor = UIColor(red: 1, green: 0.5, blue: 0.21, alpha: 1)
        ratingLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        ratingLabel.textColor = .white
        ratingLabel.layer.masksToBounds = true
        ratingLabel.layer.cornerRadius = 4
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        ganreLabel.translatesAutoresizingMaskIntoConstraints = false
        isFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            isFavoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            isFavoriteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            ganreLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            ganreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ganreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(movie: Movie) {
        self.movie = movie
        
        imageView.image = movie.image?.scalePreservingAspectRatio(targetSize: CGSize(width: 164, height: 230))
        nameLabel.text = movie.name
        ganreLabel.text = movie.genre
        ratingLabel.text = "\(movie.rating)"
        
    }
}
