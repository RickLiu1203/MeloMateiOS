import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchResults: [Track] = []  // Published property to hold the search results
    @Published var searchText: String = ""      // Published searchText to bind to search input
    @Published var token: String?               // Token fetched from the Flask API
    
    private var cancellables = Set<AnyCancellable>() // To store Combine subscriptions
    
    // Fetch the token from the Flask API
    func fetchToken(completion: @escaping () -> Void) {
        guard let url = URL(string: "http://192.168.12.8:5001/token") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: String.self, decoder: JSONDecoder()) // Assuming the token is returned as a plain string
            .replaceError(with: "")
            .receive(on: DispatchQueue.main)
            .sink { [weak self] fetchedToken in
                self?.token = fetchedToken
                completion()  // Call the completion handler after fetching the token
            }
            .store(in: &cancellables)
    }
    
    // Search for tracks using the fetched token
    func searchForTracks() {
        // Ensure token is available before searching for tracks
        guard let token = token else {
            // If token is not available, fetch it first and then call searchForTracks
            fetchToken { [weak self] in
                self?.searchForTracks()
            }
            return
        }
        
        // Replace this URL with your actual Flask API endpoint for searching tracks
        guard let url = URL(string: "http://192.168.12.8:5001/search?track_name=\(searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&token=\(token)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Track].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] tracks in
                self?.searchResults = tracks
            }
            .store(in: &cancellables)
    }
}
