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
        menuTableViewProp.tableFooterView = UIView()
    }
}
extension MenuVC: UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if menuVM.CategoryAtIndex(index: section).isOpen == true {
            return menuVM.CategoryAtIndex(index: section).categoryItems.count + 1
        }
        else{
             return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuVM.categories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") else {return UITableViewCell()}
        if indexPath.row == 0{
            cell.textLabel?.text = menuVM.CategoryAtIndex(index: indexPath.section).categoryName
        }
        else {
  cell.textLabel?.text = menuVM.CategoryAtIndex(index: indexPath.section).categoryItems[indexPath.row - 1].name
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuVM.toggle(index:indexPath.section)
        let sections = IndexSet.init(integer: indexPath.section)
        tableView.reloadSections(sections, with: .top)
    }
}
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
