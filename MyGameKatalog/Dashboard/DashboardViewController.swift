//
//  ViewController.swift
//  MyGameKatalog
//
//  Created by Kevin Chilmi Rezhaldo on 07/07/22.
//

import UIKit
import Alamofire
import Kingfisher

class DashboardViewController: UIViewController {
    
    private let viewModel = GamesViewModel()
    

    @IBOutlet weak var tableViewGame: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewGame.dataSource = self
        tableViewGame.delegate = self
        tableViewGame.dragInteractionEnabled = true
        tableViewGame.dragDelegate = self
        
        tableViewGame.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GamesCell")
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupBinders()
        viewModel.getData()

    }
    
    private func setupBinders() {
        viewModel.error.bind { [ weak self ] error in
            if let error = error {
                print(error)
            } else {
                self?.tableViewGame.reloadData()

            
            }
        }
    }
    



}


extension DashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameData?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GamesCell", for: indexPath) as? GameTableViewCell {
            
            let data = gameData?.results[indexPath.row]
            let img = data?.backgroundImage
            let url = URL(string: "\(img!)")
            cell.labelTitleGame.text = data?.name
            cell.labelRating.text = "\(data?.rating ?? 0)"
            cell.labelReleaseDate.text = data?.released
            
            cell.imageViewGame.kf.setImage(with: url)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
  
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        gameData?.results.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete Movie", message: "Are you sure to proceed this action?", preferredStyle: .alert)
        
        let submitAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            if editingStyle == .delete {
                gameData?.results.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        alert.addAction(submitAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
}

extension DashboardViewController: UITableViewDelegate {
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moveToDetail", sender: gameData?.results[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToDetail" {
            if let detailVc = segue.destination as? DetailViewController {
                detailVc.game = sender as? Games
            }
        }
    }
    
}


extension DashboardViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = gameData?.results[indexPath.row]
        return [ dragItem ]
    }

}
