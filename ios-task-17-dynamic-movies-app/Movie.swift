import UIKit

class Movie {
    var name: String
    var genre: String
    var rating: Double
    var isFavorite: Bool = false
    var description: String
    var imageUrl: String
    var coverImageUrl: String
    var details: [(String, String)]? = nil
    var image: UIImage? = nil
    var coverImage: UIImage? = nil
    
    init(
        name: String,
        genre: String,
        rating: Double,
        description: String,
        imageUrl: String,
        coverImageUrl: String,
        details: [(String, String)]? = nil
    ) {
        self.name = name
        self.genre = genre
        self.rating = rating
        self.description = description
        self.imageUrl = imageUrl
        self.coverImageUrl = coverImageUrl
        self.details = details
        
        NetworkService.shared.getImage(imageUrl: imageUrl) { [weak self] data, error in
            if let _ = error {
                return
            }
            
            if let data = data {
                self?.image = UIImage(data: data)
                self?.coverImage = UIImage(data: data)
            }
        }
    }
}
