//
//  Request.swift
//  MoviesApp
//
//  Created by Amila Fejzic on 13. 3. 2021..
//

import Foundation

final class Request: Operation {

	let urlRequest: URLRequest
	var task: URLSessionDataTask?
	var session: URLSession = URLSession(configuration: .default)

	var completion: ((Result<Data, Error>) -> Void)?

	init(urlRequest: URLRequest, timeout: TimeInterval = 30, completion: @escaping (Result<Data, Error>) -> Void) {
		self.urlRequest = urlRequest
		self.completion = completion

		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest = timeout
		configuration.timeoutIntervalForResource = timeout
		session = URLSession(configuration: configuration)
	}

	// MARK: Operation methods

	private enum State: String {
		case ready = "isReady"
		case executing = "isExecuting"
		case finished = "isFinished"
	}

	private var state = State.ready {
		willSet {
			willChangeValue(forKey: newValue.rawValue)
			willChangeValue(forKey: state.rawValue)
		}
		didSet {
			didChangeValue(forKey: oldValue.rawValue)
			didChangeValue(forKey: state.rawValue)
		}
	}

	override public var isReady: Bool {
		return super.isReady && state == .ready
	}

	override public var isExecuting: Bool {
		return state == .executing
	}

	override public var isFinished: Bool {
		return state == .finished
	}

	override public func start() {
		guard !isCancelled else {
			return
		}
		if !isExecuting {
			state = .executing
		}

		main()
	}

	private func finish() {
		if isExecuting {
			state = .finished
		}
	}

	override public func cancel() {
		task?.cancel()
		super.cancel()

		finish()
	}

	override public func main() {
		performRequest { [weak self] (result: (Result<Data, Error>)) in
			guard let self = self else {
				return
			}
			self.finish()
			if !self.isCancelled {
				self.completion?(result)
			}
		}
	}

	// MARK: Private
	private func performRequest(completion: @escaping (Result<Data, Error>) -> Void) {
		task = session.dataTask(with: urlRequest) { data, response, error in
			if let error = error {
				completion(.failure(error))
			}
			guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
				completion(.failure(NetworkError.invalidResponse))
				return
			}
			guard let data = data else {
				completion(.success(Data()))
				return
			}
			completion(.success(data))
		}
		task?.resume()
	}
}
