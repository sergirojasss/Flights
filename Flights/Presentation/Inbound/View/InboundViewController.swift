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

    private enum Images {
        static let searchImage = UIImage(systemName: "magnifyingglass")
        static let sortImageDown = UIImage(systemName: "chevron.down.circle")
        static let sortImageUp = UIImage(systemName: "chevron.up.circle")
    }

    private enum Strings {
        static let title = "OutboundFlights"
        static let errorTitle = "Error"
        static let errorDescription = "Ha ocurrido un error"
        static let errorOK = "Ok"
        static let emptyString = ""
    }
}

enum InboundViewControllerListElements {
    case shimmer
    case flightCell(model: FlightCellModel)
    case emptyCell(title: String)
}

final class InboundViewController: UIViewController {
    var presenter: InboundPresenterProtocol!
    var viewType: ViewType!
    var selectedOutBoundId: Int?

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var dataSource: InboundViewDatasource = {
        InboundViewDatasource(datasource: presenter.outbound,
                              tableView: tableView)
    }()
    
    private lazy var delegate: InboundViewDelegate = {
        InboundViewDelegate(view: self)
    }()
    
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configureTableView()
        
        presenter.viewDidload()
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
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.alwaysBounceVertical = false

        dataSource.registerCells()
    }

    // MARK: - Setup navigationBar methods

    func setupTitleNavBar() {
        navigationItem.title = Strings.title

        let textAttributes = [NSAttributedString.Key.foregroundColor: Colours.barTintColor]

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Colours.backGroundColor
        appearance.titleTextAttributes = textAttributes
        navigationController?.navigationBar.standardAppearance = appearance
    }

    
}

extension InboundViewController: InboundViewProtocol {
    func goToInboundFlights(outboundId: Int) {
        presenter.goToInboundFlights(outboundId: outboundId)
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
    
    func reloadFlights() {
        dataSource.datasource = presenter.outbound
        tableView.reloadData()
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
