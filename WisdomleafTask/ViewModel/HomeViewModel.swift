//
//  HomeViewModel.swift
//  WisdomleafTask
//
//  Created by Ajeeth Kumar on 01/06/23.
//

import Foundation
class HomeViewModel{
    
    func tableService(){
        ApiCall.shared.get(from: URL(string: "adjk")!) { result in
            switch result {
            case .success(let data): print("Any")
            case .failure(let error):
                print(error)
            }
        }
    }
}
