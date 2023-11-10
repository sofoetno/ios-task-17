import Foundation

struct MoviesData: Codable {
    let results: [MovieModel]
}

enum NetworkError: Error {
    case decodeError
    case wrongResponse
    case wrongStatusCode(code: Int)
}

class NetworkService {
    static var shared = NetworkService()
    
    func movieList(completion: @escaping ([MovieModel]?, Error?) -> Void) {
        let apiKey = "53b1afc277745d64ccd210af319cbed6"
        let urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.setValue("accept", forHTTPHeaderField: "application/json")
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, NetworkError.wrongResponse)
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(nil, NetworkError.wrongStatusCode(code: response.statusCode))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(object.results, nil)
                }
            } catch {
                print(String(describing: error))

                print("decoding error")
            }
        }).resume()
    }
    
    func getImage(imageUrl: String, completion: @escaping (Data?, Error?) -> Void) {
        let imageRootUrl = "https://image.tmdb.org/t/p/w300_and_h450_bestv2"
        let url = URL(string: "\(imageRootUrl)\(imageUrl)")
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(nil, NetworkError.wrongResponse)
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(nil, NetworkError.wrongStatusCode(code: response.statusCode))
                return
            }
            
            guard let data = data else {
                return
            }
            
            DispatchQueue.main.async {
                completion(data, nil)
            }
        }).resume()
    }
}
