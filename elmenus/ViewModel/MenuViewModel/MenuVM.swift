//
//  MenuVM.swift
//  elmenus
//
//  Created by Bassuni on 6/20/19.
//  Copyright © 2019 Bassuni. All rights reserved.
//
import Foundation
class MenuVM{
    public var delegate : MenuVMDelegate!
    private var categories: [CategoryCodable]! = []
    private var serviceAdapter : NetworkAdapter<MenuEnum>!
    init(_serviceAdapter : NetworkAdapter<MenuEnum>) {
        serviceAdapter = _serviceAdapter
        fetchMenuData()
    }
    func fetchMenuData(){
        // show loading in main ui thread
         DispatchQueueHelper.delay(bySeconds: 0, dispatchLevel: .main) {
            self.delegate?.showLoading()
        }
        serviceAdapter.request(target: .getMenuData, success: { [unowned self] response in
            do{
                let decoder = JSONDecoder()
                // decode the json object
                let getData = try decoder.decode(MenuModelCodable.self,from: response.data)
                DispatchQueueHelper.delay(bySeconds: 0) {
                    self.categories = getData.categories
                    DispatchQueueHelper.delay(bySeconds: 0, dispatchLevel: .main) {
                        // realod data to table view after data fetch
                        self.delegate?.dataBind()
                    }
                }
            }
            catch let err { print("Err", err)}
            }, error: {error  in self.delegate?.showAlert(messgae: error.localizedDescription)}
            , failure: {moyaError in self.delegate?.showAlert(messgae: moyaError.localizedDescription)})
    }
    // when vm was dispose it must be to clear all dependency
    deinit {
        delegate = nil
    }
}
// this extension will be useful when we using tableview
extension MenuVM {
    var numberOfSections: Int {
        return categories.count
    }
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.categories[section].items.count
    }
    func categoryAtIndex(index: Int) -> CategoryVM {
        let category = categories[index]
        return CategoryVM(category)
    }
    // collapse and expand
    func toggle(index: Int) {
        self.categories[index].isExpanded = !(self.categories[index].isExpanded ?? false)
    }
}
struct CategoryVM {
    private let category: CategoryCodable
    init(_ _category: CategoryCodable) {
        category = _category
    }
}
extension CategoryVM {
    var categoryId: Int {
        return category.id
    }
    var categoryName: String {
        return category.name
    }
    var isExpanded: Bool {
        return category.isExpanded ?? false // isExpanded is always nil so we make default value false
    }
    var categoryItems: [CategoryCodable] {
        return category.items
    }
}
