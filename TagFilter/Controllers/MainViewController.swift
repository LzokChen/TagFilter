//
//  ViewController.swift
//  TagFilter
//
//  Created by Xiaojian Chen on 9/23/20.
//

import UIKit

var filterBrain = FilterBrain()

class MainViewController: UIViewController {
    
    @IBOutlet weak var filterTagsTableView: UITableView!
    @IBOutlet weak var okButton: UIButton!
    
    var filterTags = [Dictionary<String, [String]>.Element]()
    var selectedTags = [String: [String]]()
    var filterResult = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //filterBrain.showItems()
        filterBrain.itemClassificationByTags()
        
        filterTags = Array(filterBrain.filterTags).sorted(by: { (arg0, arg1) -> Bool in
            return arg0.key < arg1.key
        })
        
        filterTagsTableView.register(FilterTagsCell.nib(), forCellReuseIdentifier: FilterTagsCell.identifier)
        
        filterTagsTableView.dataSource = self
        okButton.layer.cornerRadius = okButton.frame.size.height / 5
        
        for category in filterBrain.filterTags.keys{
            selectedTags[category] = []
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if !selectedTags.isEmpty{
            filterResult = Array(filterBrain.filterByTags(with: selectedTags))
            self.performSegue(withIdentifier: "showFilterResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFilterResult" {
            let destinationVC = segue.destination as! FilterResultViewController
            destinationVC.resultItem = filterResult.sorted(by: { (arg0, arg1) -> Bool in
                return arg0.name < arg0.name
            })
        }
    }
}

//MARK: - UITableView DataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterBrain.filterTags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterTagsCell.identifier, for: indexPath) as! FilterTagsCell
        cell.delegate = self
        
        let category = filterTags[indexPath.row]
        cell.configure(with: category)
        return cell
    }
}
//MARK: - FilterTagsCellDelegate
extension MainViewController: FilterTagsCellDelegate{
    func didSelectTag(category: String, tag: String) {
        selectedTags[category]?.append(tag)
    }
    
    func didUnselectTag(category: String, tag: String) {
        if let tagToUnselectIndex = selectedTags[category]?.firstIndex(of: tag){
            selectedTags[category]!.remove(at: tagToUnselectIndex)
        }
    }
}
