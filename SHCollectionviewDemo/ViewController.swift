//
//  ViewController.swift
//  SHCollectionviewDemo
//
//  Created by shiheng on 21/7/2020.
//  Copyright © 2020 shiheng. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    private let dataArray: [String] = ["Animation","Bookshelf"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: --- UITableViewDataSource
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "com.sh.tableviewcell", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }

    //MARK: --- UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc:SHCollectionViewAnimationController = SHCollectionViewAnimationController.init()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc:SHBookshelfViewController = SHBookshelfViewController.init()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("暂无")
        }
    }
    
}

