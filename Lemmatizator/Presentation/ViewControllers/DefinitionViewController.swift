//
//  DefinitionViewController.swift
//  Lemmatizator
//
//  Created by Родион Ковалевский on 8/26/20.
//  Copyright © 2020 g00dm0us3. All rights reserved.
//

import UIKit

class DefinitionViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var networkService:DefinitionServiceProtocol = DefinitionService()
    var data = [String]()
    var word: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activityIndicator.startAnimating()
        loadDescription()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.definitionLabel.text = word
    }
    
    func loadDescription() {
        networkService.fetchSynonyms(word: word ?? "", success: { (descriptionData) in
            guard  let synonyms = descriptionData else {return}
            for element in  synonyms.def.first?.tr.first?.syn ?? [] {
                self.data.append(element.text)
            }
            
            DispatchQueue.main.async {
                self.descriptionLabel.text = self.data.joined(separator: ",")
                self.activityIndicator.stopAnimating()
            }
            
        }) { (error) in
        }
    }
}
