struct MovieModel: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
    
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let voteAverage: Double
}
