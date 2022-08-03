//
//  DetailViewController.swift
//  MyGameKatalog
//
//  Created by Kevin Chilmi Rezhaldo on 13/07/22.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    var game: Games? = nil

    @IBOutlet weak var imageViewGame: UIImageView!
    @IBOutlet weak var labelReleasedDate: UILabel!
    @IBOutlet weak var labelCurrentRating: UILabel!
    @IBOutlet weak var labelTopRating: UILabel!
    @IBOutlet weak var textFieldYourRate: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = game?.name
        navigationItem.largeTitleDisplayMode = .never
        
        textFieldYourRate.delegate = self
        
        if let data = game {
            labelReleasedDate.text = data.released
            labelCurrentRating.text = "\(data.rating)/"
            labelTopRating.text = "\(data.ratingTop)"
            let img = data.backgroundImage
            let url = URL(string: "\(img)")
            imageViewGame.kf.setImage(with: url)
        }
    }
    
    
    @IBAction func buttonEnterTapped(_ sender: Any) {
        labelCurrentRating.text = "\(textFieldYourRate.text!)/"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textFieldYourRate.resignFirstResponder()
    }

}

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}
