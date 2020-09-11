//
//  WordViewController.swift
//  Lemmatizator
//
//  Created by Родион Ковалевский on 8/21/20.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import UIKit

class WordViewController: UIViewController {
    
    var data = PersistenceManager.shared.getBooks()
    var words = [Word]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let word = prepareWords() else { return }
        words = word
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func prepareWords() -> [Word]? {
        if let data = data?.first?.word?.allObjects as? [Word] {
            return data
        }
        return nil
    }
    
}

extension WordViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prepareWords()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as! WordTableViewCell
        cell.wordName.text = words[indexPath.row].wordName
        cell.frequency.text = " \(words[indexPath.row].definition ?? "0") times"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DefinitionViewController") as! DefinitionViewController
        vc.word = words[indexPath.row].wordName
        navigationController?.pushViewController(vc, animated: true)
    }
}
