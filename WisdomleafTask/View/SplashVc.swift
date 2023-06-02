//
//  SplashVc.swift
//  WisdomleafTask
//
//  Created by Ajeeth Kumar on 02/06/23.
//

import UIKit

class SplashVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            let story = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            self.navigationController?.pushViewController(story, animated: false)
        }
    }
    


}
