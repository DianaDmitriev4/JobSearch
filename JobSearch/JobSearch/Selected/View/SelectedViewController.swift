//
//  SelectedViewController.swift
//  JobSearch
//
//  Created by User on 13.03.2024.
//

import UIKit

final class SelectedViewController: UIViewController {
    // MARK: - Properties
    private var viewModel: SelectedViewModelProtocol
    
    // MARK: - GUI variables
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.text = "Избранное"
        
        return label
    }()
    
    private lazy var countVacanciesLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.textColor = .grey3
        label.text = "\(viewModel.selectedVacancy.count) вакансий"
        
        return label
    }()
    
    private lazy var vacanciesCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewFlowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Initialization
    init(viewModel: SelectedViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setViewModel() {
        viewModel.getVacancy()
        viewModel.reloadCollection = { [weak self] in
            self?.vacanciesCollectionView.reloadData()
        }
    }
    
    private func handleButtonTapped(for vacancy: Vacancy) {
        viewModel.buttonTapped(vacancy: vacancy, isSelected: viewModel.isSelected(vacancy))
    }
    
    private func setupUI() {
        setViewModel()
        view.addSubviews(views: [titleLabel, countVacanciesLabel, vacanciesCollectionView])
        vacanciesCollectionView.register(VacanciesCell.self, forCellWithReuseIdentifier: "VacanciesCellFromSelected")
        makeConstraint()
    }
    
    private func makeConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(16)
        }
        
        countVacanciesLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
        
        vacanciesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(countVacanciesLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension SelectedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.selectedVacancy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VacanciesCellFromSelected", for: indexPath)
                as? VacanciesCell else { return UICollectionViewCell() }
        
        let vacancy = viewModel.selectedVacancy[indexPath.row]
        viewModel.vacancyClosure = { [weak self] in
            self?.handleButtonTapped(for: vacancy)
        }
        
        cell.set(vacancy, isSelected: viewModel.isSelected(vacancy))
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SelectedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vacancy = viewModel.selectedVacancy[indexPath.row]
        navigationController?.pushViewController(VacancyViewController(viewModel: VacancyViewModel(vacancy)), animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SelectedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 240)
    }
}
