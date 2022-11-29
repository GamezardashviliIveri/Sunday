import Foundation

enum DataTransferError: Error {
    case noResponse
    case parsingJSON
    case networkFailure(NetworkError)
}

final class DataEndpoint<T: Any>: Endpoint { }

protocol DataTransfer {
    @discardableResult
    func request<T: Decodable>(with endpoint: DataEndpoint<T>, completion: @escaping (Result<T, Error>) -> Void) -> Cancellable?
    @discardableResult
    func request(with endpoint: DataEndpoint<Data>, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
    @discardableResult
    func request<T: Decodable>(with endpoint: DataEndpoint<T>, respondOnQueue: DispatchQueue, completion: @escaping (Result<T, Error>) -> Void) -> Cancellable?
    @discardableResult
    func request(with endpoint: DataEndpoint<Data>, respondOnQueue: DispatchQueue, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}

class DefaultDataTransferService {
    
    private let networkService: NetworkService
    
    init(with networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension DefaultDataTransferService: DataTransfer {
    
    func request<T>(with endpoint: DataEndpoint<T>, completion: @escaping (Result<T, Error>) -> Void) -> Cancellable? where T : Decodable {
        return request(with: endpoint, respondOnQueue: .main, completion: completion)
    }
    
    func request(with endpoint: DataEndpoint<Data>, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        return request(with: endpoint, respondOnQueue: .main, completion: completion)
    }
    
    func request<T: Decodable>(with endpoint: DataEndpoint<T>, respondOnQueue: DispatchQueue, completion: @escaping (Result<T, Error>) -> Void) -> Cancellable? {
        
        let task = self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let responseData):
                guard let responseData = responseData else {
                    respondOnQueue.async { completion(Result.failure(DataTransferError.noResponse)) }
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: responseData)
                    respondOnQueue.async { completion(.success(result)) }
                }
                catch {
                    respondOnQueue.async { completion(Result.failure(DataTransferError.parsingJSON)) }
                }
            case .failure(let error):
                respondOnQueue.async { completion(Result.failure(DataTransferError.networkFailure(error))) }
            }
        }
        
        return task
    }
    
    func request(with endpoint: DataEndpoint<Data>, respondOnQueue: DispatchQueue, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
        let task = self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let responseData):
                guard let responseData = responseData
                    else {
                        respondOnQueue.async { completion(Result.failure(DataTransferError.noResponse)) }
                        return
                }
                respondOnQueue.async { completion(Result.success(responseData)) }
            case .failure(let error):
                respondOnQueue.async { completion(Result.failure(DataTransferError.networkFailure(error))) }
            }
        }
        
        return task
    }
}
