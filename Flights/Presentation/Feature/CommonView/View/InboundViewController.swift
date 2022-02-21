//
//  InboundViewController.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 19/2/22.
//

import UIKit
import RxSwift

extension InboundViewController {
    private enum Colours {
        static let backGroundColor = UIColor.white
        static let navBarTintColor = UIColor.red
        static let bayStyleColor = UIColor.black
        static let barTintColor = UIColor.red
    }

    private enum Strings {
        static let price = "Total Price"
        static let outboundTitle = "Outbound"
        static let inboundTtitle = "Inbound"
        static let errorTitle = "Error"
        static let errorDescription = "Ha ocurrido un error"
        static let errorOK = "Ok"
        static let emptyString = ""
    }
    
}

final class InboundViewController: UIViewController {
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
        dataSource.datasource = [CellTypes.shimmer,
                                 CellTypes.shimmer,
                                 CellTypes.shimmer,
                                 CellTypes.shimmer,
                                 CellTypes.shimmer]
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
        tableView.estimatedRowHeight = 500.0

        dataSource.registerCells()
    }

    // MARK: - Setup navigationBar methods

    func setupTitleNavBar() {
        navigationItem.title = viewType == .inbound ? Strings.inboundTtitle : Strings.outboundTitle

        let textAttributes = [NSAttributedString.Key.foregroundColor: Colours.barTintColor]

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Colours.backGroundColor
        appearance.titleTextAttributes = textAttributes
        navigationController?.navigationBar.standardAppearance = appearance
    }

    
}

extension InboundViewController: OutboundViewProtocol {
    func goToOutboundFlights(outboundId: Int) {
        presenter?.goToInboundFlights(outboundModelId: outboundId)
    }
}

extension InboundViewController: InboundViewProtocol {
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
}

extension InboundViewController {
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
