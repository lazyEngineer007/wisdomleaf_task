//
//  ViewController.swift
//  WisdomleafTask
//
//  Created by Ajeeth Kumar on 01/06/23.
//

import UIKit
protocol Reload : AnyObject{
    func reloadCell(isReFreshed : Bool)
}

class ViewController: UIViewController {
    var page = 1
    @IBOutlet weak var homeTable: UITableView!
    let homeViewModel = HomeViewModel()
    private let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTable.register(UINib(nibName: TableCell.identifier, bundle: nil), forCellReuseIdentifier: TableCell.identifier)
        homeTable.delegate = self
        homeTable.dataSource = self
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        homeTable.refreshControl = refreshControl
        homeViewModel.delegate = self
        homeViewModel.tableService(isRefreshed: false, page: page)
    }
    
    
    
    @objc private func refreshData() {
        page = 1
        homeViewModel.tableService(isRefreshed: true, page: page)
    }
    
    
}
extension ViewController : Reload{
    func reloadCell(isReFreshed: Bool) {
        DispatchQueue.main.async {
            self.homeTable.reloadData()
            if isReFreshed{
                self.refreshControl.endRefreshing()
            }
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
        cell.titleLbl.text = dict.author
        cell.descriptionLbl.text = dict.url ?? ""
        
        
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
        cell.checkBoxBtn.setImage(dict.isChecked ? UIImage(named: "checkbox") : UIImage(named: "unchecked"), for: .normal)
        cell.checkBoxBtn.tag = indexPath.row
        cell.checkBoxBtn.addTarget(self, action: #selector(checkBoxAction), for: .touchUpInside)
        return cell
    }
    @objc func checkBoxAction(sender : UIButton){
        homeViewModel.homeModelList[sender.tag].isChecked = !homeViewModel.homeModelList[sender.tag].isChecked
        homeTable.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == homeViewModel.homeModelList.count - 5 && homeViewModel.homeModelList.count>5{
             homeViewModel.tableService(page: page + 1)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = homeViewModel.homeModelList[indexPath.row]
        if dict.isChecked{
            showAlertDialog(title: "Dialog", message: dict.url ?? "")
        }else{
            showAlertDialog(title: "Alert!", message: "CheckBox is not checked...")
        }
    }
    func showAlertDialog(title : String, message : String) {
          
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
         
           let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
               //self.dismiss(animated: true)
           }
           
           // Add the action to the alert controller
           alertController.addAction(okAction)
           
           // Present the alert controller
           present(alertController, animated: true, completion: nil)
       }
    
    
    
}

