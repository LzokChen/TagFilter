//
//  FilterResultUICollectionViewController.swift
//  TagFilter
//
//  Created by Xiaojian Chen on 9/27/20.
//

import UIKit

class FilterResultViewController: UICollectionViewController {
    
    var resultItem = [Item]()
    
    var selectedItem : Item?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(FilterResultCollectionViewCell.nib(), forCellWithReuseIdentifier: FilterResultCollectionViewCell.identifier)
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return resultItem.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterResultCollectionViewCell.identifier, for: indexPath) as! FilterResultCollectionViewCell
        
        // Configure the cell
        cell.configure(with: resultItem[indexPath.row].name)
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedItem = resultItem[indexPath.row]
        print("you select \(selectedItem!.name)")
        collectionView.deselectItem(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "showItemDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItemDetail" {
            let destinationVC = segue.destination as! ItemDetailViewController
            destinationVC.selectedItem = selectedItem
        }
    }
    
    
}
