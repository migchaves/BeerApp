//
//  HomeViewController.swift
//  BeerApp
//
//  Created by Miguel on 15/02/2022.
//

import UIKit

class HomeViewController: BaseController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    private lazy var viewModel = HomeViewModel()
    
    // MARK: - View life cycle

    override func initElements() {
        
        self.title = "Beers List"
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        self.showLoader()
        
        self.viewModel.dataLoaded = { [weak self] items in
            
            self?.hideLoader()
            
            guard let self = self else {
                return
            }
            
            guard let wrapped = items, wrapped.count > 0 else {
                self.tableView.isHidden = true
                return
            }
            
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
        
        self.viewModel.getData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOrRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.beerCell, for: indexPath) as? BeerCell else {
            return UITableViewCell()
        }
        
        guard let beer = self.viewModel.getBeer(index: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.beerName.text = beer.name
        cell.beerData.text = beer.description
        cell.beerImage.imageFromServerURL(beer.image_url ?? "", placeHolder: nil)
        
        return cell
    }
}
