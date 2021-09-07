//
//  HomeViewController.swift
//  PlatziTweets
//
//  Created by Camilo Rozo on 15/08/21.
//

import UIKit
import Simple_Networking
import SVProgressHUD
import NotificationBannerSwift

class HomeViewController: UIViewController {
    
    // MARK: -IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    private let cellId = "TweetTableViewCell"
    private var dataSource = [Post]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getPosts()
    }
    
    private func setupUI() {
        // asginar datasource
        tableView.dataSource = self
        // registro de celdas
        tableView.register(UINib(nibName: cellId, bundle: nil ), forCellReuseIdentifier: cellId)
    }
    
    private func getPosts() {
        // indicar carga al usuario
        SVProgressHUD.show()
        
        // consumir servicio
        SN.get(endpoint: Endpoints.getPosts) { (result: SNResultWithEntity<[Post],ErrorResponse>) in
            //cerramos indicador de carga
            SVProgressHUD.dismiss()
            switch result {
            case .success(response: let aobResponse):
                self.dataSource = aobResponse
                self.tableView.reloadData()
            case .error(error: let error):
                NotificationBanner( subtitle: "Lo sentimos \(error.localizedDescription)", style: .warning).show()
            case .errorResult(entity: let entity):
                NotificationBanner( subtitle: "Lo sentimos \(entity.error)", style: .warning).show()
            }
            
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let cell = cell as? TweetTableViewCell {
            // configurar celda
            cell.setupCellWith(post: dataSource[indexPath.row])
        }
        return cell
    }
}
