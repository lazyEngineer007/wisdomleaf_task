//
//  ViewController.swift
//  WisdomleafTask
//
//  Created by Ajeeth Kumar on 01/06/23.
//

import UIKit
protocol Reload : AnyObject{
    func reloadCell()
}

class ViewController: UIViewController {
    var page = 1
    @IBOutlet weak var homeTable: UITableView!
    let homeViewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTable.register(UINib(nibName: TableCell.identifier, bundle: nil), forCellReuseIdentifier: TableCell.identifier)
        homeTable.delegate = self
        homeTable.dataSource = self
        
        homeViewModel.delegate = self
        homeViewModel.tableService(isRefreshed: false, page: page)
       
    }


}
extension ViewController : Reload{
    func reloadCell() {
        DispatchQueue.main.async {
            self.homeTable.reloadData()
        }
        
    }
}
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.homeModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as! TableCell
        let dict = homeViewModel.homeModelList[indexPath.row]
      //  cell.cellImage.image = UIImage(named: "placeholder")
        cell.titleLbl.text = dict.author
        cell.descriptionLbl.text = "sample"
        
        
        let aspectRatio = dict.height! / dict.width!

        // Calculate the height based on a desired width
        let desiredWidth: CGFloat = cell.cellImage.bounds.width
        let height = desiredWidth * aspectRatio
        cell.imageHeight.constant = height
        
        //Download Image
        
        let urlString = dict.download_url ?? ""
            let placeholderImage = UIImage(named: "placeholder")
            downloadImage(from: urlString, placeholderImage: placeholderImage) { (image) in
                cell.cellImage.image = image
            }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == homeViewModel.homeModelList.count - 5 && homeViewModel.homeModelList.count>5{
            homeViewModel.tableService(page: page + 1)
        }
    }
    
    
}

