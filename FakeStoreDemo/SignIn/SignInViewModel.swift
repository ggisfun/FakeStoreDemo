//
//  SignInViewModel.swift
//  FakeStoreDemo
//
//  Created by Adam Chen on 2025/7/20.
//

import Foundation
import Combine

class SignInViewModel {
    func login(with requestModel: SignInRequest) -> AnyPublisher<SignInResponse, Error> {
        return APIService.post(
            urlString: APIEndpoint.login,
            body: requestModel
        )
    }
}
