//
//  ProductRepository.swift
//  
//
//  Created by Edgars Simanovskis on 17/4/23.
//

final class ProductRepository: ProductRepositoryProtocol {

    private var networkAPI: NetworkAPIProtocol

    init(networkAPI: NetworkAPIProtocol = NetworkAPI()) {
        self.networkAPI = networkAPI
    }

    func getProductList(_ completion: @escaping RequestCompletion<[APIProduct]>) {
        networkAPI.performRequest(.products, completion: completion)
    }

    func getProductDetail(id: String, _ completion: @escaping RequestCompletion<APIProduct>) {
        networkAPI.performRequest(.productDetail(id: id), completion: completion)
    }
}
