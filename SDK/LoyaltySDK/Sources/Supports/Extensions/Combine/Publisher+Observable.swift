//
//  Publisher+Observable.swift
//  LoyaltySDK
//
//  Created by David Bui on 20/03/2023.
//

import Combine

extension Publisher {

    func asObservable() -> Observable<Output> {
        mapError { $0 }
            .eraseToAnyPublisher()
    }
}
