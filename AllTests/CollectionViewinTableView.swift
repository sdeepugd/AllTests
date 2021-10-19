//
//  CollectionViewTest.swift
//  TestContentHugging
//
//  Created by Deepak Srinivasan on 05/10/21.
//

import UIKit
class CollectionViewTest : UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        setupCollectionConstraints()
        isAccessibilityElement = false
    }
    
    let collectionView: UICollectionView = {
        let layout = CustomFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        return cv
    }()
    
    func setupCollectionConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.isAccessibilityElement = false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override class func accessibilityElementCount() -> Int {
        10
    }
    
    override func accessibilityElement(at index: Int) -> Any? {
        return collectionView.cellForItem(at:IndexPath(item: index, section: 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.accessibilityLabel = "cell"
        cell.isAccessibilityElement = true
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}

class CollectionViewInTableViewTest : UIViewController
{
    
    override func viewDidLoad() {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: "collcell")
        tableView.rowHeight = 200
        tableView.estimatedRowHeight = 64.0
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CollectionViewInTableViewTest: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
}

extension CollectionViewInTableViewTest: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collcell", for: indexPath) as! CollectionTableViewCell
        cell.config()
        return cell
    }
    
}


class CollectionTableViewCell : UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config()
    {
        
        let wrapperView = UIView()
        addSubview(wrapperView)
        
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrapperView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            wrapperView.topAnchor.constraint(equalTo: self.topAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        let collectionViewController = CollectionViewTest()
        let collectionView = collectionViewController.view!

        wrapperView.accessibilityElements = [collectionView]
        wrapperView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor)
        ])
    }
    
}


class CustomFlowLayout:UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.scrollDirection = .horizontal
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
}
