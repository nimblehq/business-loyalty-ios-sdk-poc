//
//  ContentViewModel.swift
//  Example
//
//  Created by David Bui on 22/03/2023.
//

import Combine
import NimbleLoyalty

final class ContentViewModel: ObservableObject {

    @Published var state: State = .idle

    init() {
        NimbleLoyalty.shared.setClientId("MRC6bwFASOm0sJYPYwVEt2KD51bkAtdgS7ltqeDYUf4")
        state = NimbleLoyalty.shared.isAuthenticated() ? .authenticated : .unauthenticated
    }

    func signIn() {
        DispatchQueue.main.async {
            NimbleLoyalty.shared.authenticate { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.state = .authenticated
                case .failure(let failure):
                    self.state = .error(failure.localizedDescription)
                }
            }
        }
    }
}

extension ContentViewModel {

    enum State: Equatable {

        case idle, unauthenticated, authenticated
        case error(String)
    }
}

