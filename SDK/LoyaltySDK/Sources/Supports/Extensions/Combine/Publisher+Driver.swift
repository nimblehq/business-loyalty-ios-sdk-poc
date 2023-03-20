//
//  Publisher+Driver.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Combine

extension Publisher {

    func asDriver() -> Driver<Output> {
        self.catch { _ in Empty() }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
