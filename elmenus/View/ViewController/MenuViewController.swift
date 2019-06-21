//
//  ViewController.swift
//  elmenus
//
//  Created by Bassuni on 6/20/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//

import UIKit
import SVProgressHUD
class MenuVC: UIViewController {
    @IBOutlet var menuTableViewProp: UITableView!
    var menuVM : MenuVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        desginAndConfigVC()
    }
    func desginAndConfigVC(){
        menuTableViewProp.delegate = self
        menuTableViewProp.dataSource = self
        menuVM = MenuVM(_serviceAdapter: NetworkAdapter<MenuEnum>())
        menuVM.delegate = self
        menuTableViewProp.tableFooterView = UIView() // ui of table
    }
}
// tableview implementation
extension MenuVC: UITableViewDelegate , UITableViewDataSource
{
    // create ui of section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        let categoryName = menuVM.categoryAtIndex(index: section).categoryName
        button.setTitle(categoryName, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        return button
    }
    @objc func handleExpandClose(button: UIButton) {
        let section = button.tag
        // we'll try to close the section first by deleting the rows
        var indexPaths = [IndexPath]()
        for row in menuVM.categoryAtIndex(index: section).categoryItems.indices {
            // collect all rows per section
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let isExpanded = menuVM.categoryAtIndex(index: section).isExpanded
        menuVM.toggle(index: section) // user enable to Expanded or collapse the section
        if isExpanded {
            menuTableViewProp.deleteRows(at: indexPaths, with: .fade)
        } else {
            menuTableViewProp.insertRows(at: indexPaths, with: .fade)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return menuVM.numberOfSections
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if !menuVM.categoryAtIndex(index: section).isExpanded {
                return 0
            }
            return menuVM.categoryAtIndex(index: section).categoryItems.count
        }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuItemTableViewCell
        let item = menuVM.categoryAtIndex(index: indexPath.section).categoryItems[indexPath.row]
        cell.bindCell(item.name, item.itemDescription)
        return cell
    }
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }

}
// implementation MenuVMDelegate
extension MenuVC: MenuVMDelegate
{
    func showLoading() {
        SVProgressHUD.show(withStatus: "")
    }
    func hideLoading() {
        SVProgressHUD.dismiss()
    }
    func showAlert(messgae: String) {
        hideLoading()
        alert(title: "validation",message: messgae)
    }
    func dataBind() {
        hideLoading()
        menuTableViewProp.reloadData()
    }
}
