//
//  ProjectManager - ViewController.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/11.
//

import UIKit

final class MainViewController: UIViewController {
    enum TodoSection: Hashable {
        case todo
        case doing
        case done
    }
    
    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.backgroundColor = UIColor.systemGray5
        return stackView
    }()
    
    private let todoTableView = ListTableView()
    private let doingTableView = ListTableView()
    private let doneTableView = ListTableView()
    
    private typealias Snapshot = NSDiffableDataSourceSnapshot<TodoSection, TodoModel>
    
    private typealias DataSource = UITableViewDiffableDataSource<TodoSection, TodoModel>
    
    private lazy var todoDataSource: DataSource = configureDataSource(of: todoTableView)
    private lazy var doingDataSource: DataSource = configureDataSource(of: doingTableView)
    private lazy var doneDataSource: DataSource = configureDataSource(of: doneTableView)
    
    // 테스트용 todoModels
    private var todoModels: [TodoModel] = [TodoModel(title: "todo test1",
                                                     body: "todo test1",
                                                     status: .todo),
                                           TodoModel(title: "todo test1",
                                                     body: "todo test1\ntodo test1\ntodo test1\ntodo test1",
                                                     status: .todo),
                                           TodoModel(title: "doing test1",
                                                     body: "doing test1",
                                                     status: .doing),
                                           TodoModel(title: "done test1",
                                                     body: "done test1",
                                                     status: .done),
                                           TodoModel(title: "done test1",
                                                     body: "done test1",
                                                     status: .done)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        configureNavagationBar()
        configureTodoView()
        applyAllSnapshot()
    }
    
    private func configureNavagationBar() {
        self.navigationItem.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(showAddToDoView))
    }
    
    @objc private func showAddToDoView() {}
    
    private func configureTodoView() {
        configureTableView()
        configureLayout()
    }
    
    private func configureTableView() {
        let tableviews = [todoTableView, doingTableView, doneTableView]
        
        tableviews.forEach {
            $0.delegate = self
            $0.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
            $0.register(TodoHeaderView.self, forHeaderFooterViewReuseIdentifier: TodoHeaderView.identifier)
            tableStackView.addArrangedSubview($0)
        }
    }
    
    private func configureLayout() {
        self.view.addSubview(tableStackView)
        
        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureDataSource(of tableView: ListTableView) -> DataSource {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, todo in
            let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier,
                                                     for: indexPath) as? TodoTableViewCell
            
            cell?.configureContent(with: todo)
            return cell
        }
        
        return dataSource
    }
    
    private func applyAllSnapshot() {
        applySnapshot(section: TodoSection.todo,
                      status: TodoModel.TodoStatus.todo,
                      dataSource: todoDataSource)
        applySnapshot(section: TodoSection.doing,
                      status: TodoModel.TodoStatus.doing,
                      dataSource: doingDataSource)
        applySnapshot(section: TodoSection.done,
                      status: TodoModel.TodoStatus.done,
                      dataSource: doneDataSource)
    }
    
    private func applySnapshot(section: TodoSection, status: TodoModel.TodoStatus, dataSource: DataSource) {
        var snapshot = Snapshot()
        snapshot.appendSections([section])
        snapshot.appendItems(todoModels.filter{ $0.status == status })
        dataSource.apply(snapshot)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TodoHeaderView.identifier) as? TodoHeaderView else {
            return UIView()
        }
        
        switch tableView {
        case todoTableView:
            headerView.configureContent(of: TodoModel.TodoStatus.todo)
            headerView.updateCount(todoModels.filter { $0.status == .todo }.count)
        case doingTableView:
            headerView.configureContent(of: TodoModel.TodoStatus.doing)
            headerView.updateCount(todoModels.filter { $0.status == .doing }.count)
        case doneTableView:
            headerView.configureContent(of: TodoModel.TodoStatus.done)
            headerView.updateCount(todoModels.filter { $0.status == .done }.count)
        default:
            break
        }
        
        return headerView
    }
}
