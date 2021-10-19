//
//  MainTVC.swift
//  AllTests
//
//  Created by Deepak Srinivasan on 14/10/21.
//

import UIKit

class MainTableViewController :UIViewController
{
    
    let viewControllersDataSource: [ViewControllerData]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewControllersDataSource = ViewControllerDataSource.vcs
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.frame = view.bounds
        print(view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
    }
}

extension MainTableViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewContollerData = viewControllersDataSource[indexPath.row]
        let vc = viewContollerData.viewController
        let navStack = self.navigationController
        navStack?.pushViewController(vc, animated: true)
    }
}

extension MainTableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewControllersDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let viewContollerData = viewControllersDataSource[indexPath.row]
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = viewContollerData.displayname
        cell.contentConfiguration = contentConfig
        return cell
    }
    
}
