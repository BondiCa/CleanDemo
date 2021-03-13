//
//  NetworkClient.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 12. 3. 2021..
//

import Foundation

final class Network {
	private let queue = OperationQueue()

	let baseURL: URL
	let apiKey = "09bc478f584c74b8a540079f46168ffa"
	init?(with baseURLString: String) {
		guard let url = URL(string: baseURLString) else {
			return nil
		}
		self.baseURL = url
		queue.maxConcurrentOperationCount = 1

	}
}

extension Network {

	enum HttpMethod: String {
		case get
		case post
		case put
		case patch
		case delete

		var description: String {
			switch self {
			case .get:
				return "GET"
			case .post:
				return "POST"
			case .put:
				return "PUT"
			case .patch:
				return "PATCH"
			case .delete:
				return "DELETE"
			}
		}
	}

	private func createURLRequest(method: HttpMethod, path: String, queryParams: [URLQueryItem]?, body: Data?) -> URLRequest {
		var url = baseURL

		url.appendPathComponent(path)

		var params = [URLQueryItem(name: "api_key", value: apiKey)]
		if let queryParams = queryParams {
			params.append(contentsOf: queryParams)
		}
		url.addQueryParameters(params)

		var urlRequest = URLRequest(url: url)

		urlRequest.httpBody = body
		urlRequest.httpMethod = method.description

		return urlRequest
	}

	private func performRequest(urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
		let request = Request(urlRequest: urlRequest, completion: completion)
		queue.addOperation(request)

	}

	private func handleResultData<Model: Decodable>(result: Result<Data, Error>, path: String, completion: @escaping (Result<Model, Error>) -> Void) {
		DispatchQueue.main.async {
			switch result {
			case .success(let data):
				do {
					let model = try JSONDecoder().decode(Model.self, from: data)
					completion(.success(model))
				} catch {
					completion(.failure(error))
				}
			case .failure(let error):
				completion(.failure(error))

			}
		}
	}

}

extension Network {

	func sendRequest<Model: Decodable>(method: HttpMethod, path: String, queryParams: [URLQueryItem]?, body: Data?, completion: @escaping (Result<Model, Error>) -> Void) {
		let request = createURLRequest(method: method, path: path, queryParams: queryParams, body: body)
		performRequest(urlRequest: request) { [weak self] (result: Result<Data, Error>) in
			self?.handleResultData(result: result, path: path, completion: completion)
		}
	}
}

fileprivate extension URL {

	mutating func addQueryParameters(_ parameters: [URLQueryItem]) {
		guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
			fatalError("Unable to create URL components")
		}

		components.queryItems = parameters

		guard let componentsUrl = components.url else {
			fatalError("Cannot get components url")
		}

		self = componentsUrl
	}
}
