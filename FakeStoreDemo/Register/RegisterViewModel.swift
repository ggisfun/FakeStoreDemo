//
//  RegisterViewMode.swift
//  FakeStoreDemo
//
//  Created by Adam Chen on 2025/7/20.
//

import Foundation
import Combine

class RegisterViewModel {
    func registerUser(with requestModel: RegisterRequest) -> AnyPublisher<RegisterResponse, Error> {
        guard let url = URL(string: "https://api.escuelajs.co/api/v1/users/") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(requestModel)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        let resultPublisher = URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: RegisterResponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
        return resultPublisher
    }
}

