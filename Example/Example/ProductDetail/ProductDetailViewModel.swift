//
//  ProductDetailViewModel.swift
//  Example
//
//  Created by Edgars Simanovskis on 17/4/23.
//

import Combine
import NimbleLoyalty

final class ProductDetailViewModel: ObservableObject {

    @Published var state: State = .idle
    @Published var id: String
    @Published var product: APIProduct?

    init(id: String) {
        self.id = id
    }

    func loadProductDetail() {
        state = .loading
        NimbleLoyalty.shared.getProductDetail(id: id) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(productDetail):
                self.product = productDetail
                self.state = .loaded
            case let .failure(error):
                self.state = .error(error.localizedDescription)
            }
        }
    }
    
    func addToCart() {
        print("add to cart")
    }
}

extension ProductDetailViewModel {

    enum State: Equatable {

        case idle, loaded, loading
        case error(String)
    }
}


