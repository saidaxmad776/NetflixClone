//
//  HomeVC.swift
//  NetflixClone
//
//  Created by Test on 05/09/22.
//

import UIKit

class HomeVC: UIViewController {

    private let homeFeedTable: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeFeedTable.frame = view.bounds
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTable)
    }
    
    private func setDelegate() {
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
    }

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello"
        
        return cell
    }
}
