//
//  PhotosViewController.swift
//  TemplateApp
//
//  Created by Muhammad Usman on 07/02/2021.
//  
//

import UIKit
import Combine

class PhotosViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    // MARK: Properties

    private var viewModel: PhotosViewModel!
    private var cancellable: [AnyCancellable] = []
    private lazy var dataSource = makeDataSource()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = PhotosViewModel(useCase: PhotosUseCase())
        viewModel.requestPhotos()
        configureUI()
        bindViewModel()
    }
    
    private func configureUI(){
        tableView.dataSource = dataSource
    }
    
    private func bindViewModel() {
        viewModel.$isLoading.sink { isLoading in
            print("\(isLoading)")
        }.store(in: &cancellable)
        
        viewModel.stateDidUpdate.sink(receiveValue: { [weak self] state in
            guard let `self` = self else{return}
            self.render(state)
        }).store(in: &cancellable)
    }
    
    private func render(_ state: PhotosViewModelState) {
        switch state {
        case .error(let errorMessage):
            update(with: [], animate: true)
        case .show(let products):
            update(with: products, animate: true)
        }
    }
    
}

extension PhotosViewController{
    enum Section: CaseIterable {
        case photos
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Section, PhotoRowViewModel> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, productRowViewModel in
                let cell: PhotoListingTableViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.configure(with: productRowViewModel)
                return cell
            })
    }
    
    private func update(with products: [PhotoRowViewModel], animate: Bool = true) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, PhotoRowViewModel>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(products, toSection: .photos)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}
