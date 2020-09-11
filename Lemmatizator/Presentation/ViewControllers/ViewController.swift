//
//  ViewController.swift
//  Lemmatizator
//
//  Created by g00dm0us3 on 8/17/20.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [Book]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // PersistenceManager.shared.deleteAllitems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        LematizatorManager.lemmatizator(title: "mobydick")
        PersistenceManager.shared.dataLoaded { (books) in
            self.data = books ?? []
            self.tableView.reloadData()
        }
            }
    }

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.bookTitleLabel.text  = data[indexPath.row].title
        cell.maxWordLabel.text = data[indexPath.row].maxWord
        cell.minWordLabel.text = data[indexPath.row].minWord
        cell.medianWordLabel.text = data[indexPath.row].medianWord
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "WordViewController") as! WordViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}





