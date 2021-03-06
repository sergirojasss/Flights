//
//  InboundViewController.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import UIKit
import RxSwift

extension InOutCommonViewController {
    private enum Colours {
        static let backGroundColor = UIColor.white
        static let barTintColor = UIColor.customBlue
    }

    private enum Strings {
        static let price = "Total Price"
        static let outboundTitle = "Outbound"
        static let inboundTtitle = "Inbound"
        static let errorTitle = "Error"
        static let errorDescription = "Run for your lifes! it's an Error"
        static let errorOK = "OK"
        static let tryAgain = "Try Again"
        static let emptyString = ""
        static let emptyTitle = "No matching flights"
        static let emptyDescription = "Try another outbound flight"
        static let emptyOutboundFlights = "Unable to download flights"
        static let emptyOutboundDescription = "Please, check your internet connection and try again"
    }
    
}

final class InOutCommonViewController: UIViewController {
    var presenter: OutboundPresenterProtocol?
    var inboundPresenter: InboundPresenterProtocol?
    var viewType: ViewType!

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var dataSource: InboundViewDatasource = {
        let dataSource = InboundViewDatasource(tableView: tableView)
        dataSource.datasource = Constants.shimmerCells
        return dataSource
    }()
    
    private lazy var delegate: InboundViewDelegate = {
        InboundViewDelegate(view: self)
    }()
    
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configureTableView()
        
        presenter?.viewDidload()
        inboundPresenter?.viewDidload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitleNavBar()
        setNavBarItems()
    }
    
    // MARK: - Setup view method
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
    }
    
    func configureTableView() {
        tableView.backgroundColor = Colours.backGroundColor
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.estimatedRowHeight = 220.0
        tableView.rowHeight = UITableView.automaticDimension

        dataSource.registerCells()
    }

    // MARK: - Setup navigationBar methods
    private func setupTitleNavBar() {
        navigationItem.title = viewType == .inbound ? Strings.inboundTtitle : Strings.outboundTitle

        let textAttributes = [NSAttributedString.Key.foregroundColor: Colours.barTintColor]

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Colours.backGroundColor
        appearance.titleTextAttributes = textAttributes
        navigationController?.navigationBar.standardAppearance = appearance
    }

    private func setNavBarItems() {
        if viewType == .outbound {
            let reloadBtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(fetchData))
            reloadBtn.tintColor = Colours.barTintColor

            navigationItem.rightBarButtonItems = [reloadBtn]
        }
    }
    
    @objc private func fetchData() {
        dataSource.datasource = Constants.shimmerCells
        presenter?.viewDidload()
    }

}

extension InOutCommonViewController: OutboundViewProtocol {
    func showEmptyStateAndReload() {
        let alertView = UIAlertController(title: Strings.emptyOutboundFlights, message: Strings.emptyOutboundDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Strings.tryAgain, style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
            self.presenter?.viewDidload()
        })
        alertView.addAction(okAction)
        present(alertView, animated: true, completion: nil)
    }
    
    func goToOutboundFlights(outboundId: Int) {
        presenter?.goToInboundFlights(outboundModelId: outboundId)
    }
}

extension InOutCommonViewController: InboundViewProtocol {
    func showTotalPrice(_ totalPrice: String) {
        let alertView = UIAlertController(title: Strings.price, message: totalPrice, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: Strings.errorOK, style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        })
        alertView.addAction(okAction)
        present(alertView, animated: true, completion: nil)
    }
    

    func reloadFlights(with model: [FlightModel]) {
        dataSource.datasource = model.map{ CellTypes.flightCell(model: FlightCellModel(from: $0)) }
    }
    
    func showError(_ error: ServiceError) {
        let alertView = UIAlertController(title: Strings.errorTitle, message: Strings.errorDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Strings.errorOK, style: .default, handler: { _ in
            //TODO: Retry button
            self.dismiss(animated: true, completion: nil)
        })
        alertView.addAction(okAction)
        present(alertView, animated: true, completion: nil)
    }
    
    func showEmptyState() {
        let alertView = UIAlertController(title: Strings.emptyTitle, message: Strings.emptyDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Strings.errorOK, style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        })
        alertView.addAction(okAction)
        present(alertView, animated: true, completion: nil)
    }

}

private extension InOutCommonViewController {
    // MARK: - Constraints
    func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: guide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
}

private extension InOutCommonViewController {
    enum Constants {
        static let shimmerCells = [CellTypes.shimmer,
                                   CellTypes.shimmer,
                                   CellTypes.shimmer,
                                   CellTypes.shimmer,
                                   CellTypes.shimmer,
                                   CellTypes.shimmer,
                                   CellTypes.shimmer]
    }
}
