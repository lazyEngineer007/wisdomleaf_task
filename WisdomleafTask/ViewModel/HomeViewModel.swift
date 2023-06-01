//
//  HomeViewModel.swift
//  WisdomleafTask
//
//  Created by Ajeeth Kumar on 01/06/23.
//

import Foundation
import UIKit
class HomeViewModel{
    var homeModelList : [HomeModel] = []
    weak var delegate : Reload?
    func tableService(isRefreshed : Bool = false, page : Int = 1){
        ApiCall.shared.get(from: URL(string: "https://picsum.photos/v2/list?page=\(page)&limit=20")!) { [self] result in
            do{
                switch result {
                case .success(let data):
                    let values = try JSONDecoder().decode([HomeModel].self, from: data)
                    homeModelList = isRefreshed ? [] : homeModelList
                    homeModelList += values
                    delegate?.reloadCell()
                case .failure(let error):
                    print(error)
                }
            }catch{
                print(error)
            }
        }
    }
}
