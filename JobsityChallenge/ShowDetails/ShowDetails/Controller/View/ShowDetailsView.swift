//
//  ShowDetailsView.swift
//  ShowDetails
//
//  Created by Paulo Ricardo de Araujo Vieira on 07/06/23.
//

import Core
import UIKit

protocol ShowDetailsViewDelegate: AnyObject {
    func showDetailsView(didSelectSeason seasonId: Int)
}

final class ShowDetailsView: UIView {

    weak var delegate: ShowDetailsViewDelegate?
    private var showSeasons = [Int]()
    private var episodes = [ShowEpisodesModel.ViewObject]()
    private var selectedSeason: Int = 0

    lazy var scrollView: UIScrollView = { view in
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }(UIScrollView())

    lazy var imageView: UIImageView = { view in
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }(UIImageView())

    lazy var airedLabel: UILabel = { label in
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }(UILabel())

    lazy var genresLabel: UILabel = { label in
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }(UILabel())

    lazy var summaryLabel: UILabel = { label in
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }(UILabel())

    lazy var selectSeasonButton: UIButton = { button in
        button.setTitle("Season 1", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(nil, action: #selector(selectSeasonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }(UIButton())

    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tintColor = .white
        pickerView.backgroundColor = .darkGray
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()

    lazy var toolBar: UIToolbar = { bar in
        bar.barStyle = .black
        bar.tintColor = .white
        bar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePickerView))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPickerView))
        bar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        bar.isUserInteractionEnabled = true
        return bar
    }(UIToolbar())

    lazy var dummyTextField: UITextField = { field in
        field.inputView = pickerView
        field.inputAccessoryView = toolBar
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }(UITextField())

    lazy var episodesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(SingleEpisodesCollectionViewCell.self, forCellWithReuseIdentifier: "single episode cell")
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)

        backgroundColor = .black
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configView(with image: UIImage?) {
        imageView.image = image
    }

    func configView(with details: ShowDetails.ViewObject) {
        airedLabel.text = details.daysAired
        genresLabel.text = details.genres
        summaryLabel.text = details.summary
    }

    func configEpisodesCollection(with showSeasons: [Int]) {
        self.showSeasons = showSeasons
        episodesCollection.reloadData()
        pickerView.reloadAllComponents()
    }

    func configEpisodesOfASeason(season: Int, episodes: [ShowEpisodesModel.ViewObject]) {
        self.episodes = episodes
        episodesCollection.reloadData()
    }

    func reloadEpisode(episode: Int) {
        episodesCollection.reloadItems(at: [.init(item: episode-1, section: 0)])
    }

    @objc func selectSeasonAction() {
        dummyTextField.becomeFirstResponder()
    }

    @objc func donePickerView() {
        dummyTextField.resignFirstResponder()
        delegate?.showDetailsView(didSelectSeason: showSeasons[selectedSeason])
        selectSeasonButton.setTitle("Season \(selectedSeason+1)", for: .normal)
    }

    @objc func cancelPickerView() {
        dummyTextField.resignFirstResponder()
    }
}

extension ShowDetailsView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        episodes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "single episode cell", for: indexPath) as! SingleEpisodesCollectionViewCell
        cell.config(with: episodes[indexPath.item].image.image)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 250, height: 140)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension ShowDetailsView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        showSeasons.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "Season \(row+1)"
    }
}

extension ShowDetailsView: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSeason = row
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        .init(string: "Season \(row+1)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}

extension ShowDetailsView: ViewCoding {
    func setupViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(airedLabel)
        scrollView.addSubview(genresLabel)
        scrollView.addSubview(summaryLabel)
        scrollView.addSubview(selectSeasonButton)
//        selectSeasonButton.addSubview(buttonIcon)
        scrollView.addSubview(episodesCollection)
//        addSubview(pickerView)
        addSubview(dummyTextField)
    }

    func setupViewContraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 159),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            airedLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            airedLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            airedLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -5),

            genresLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            genresLabel.topAnchor.constraint(equalTo: airedLabel.bottomAnchor, constant: 8),
            genresLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -5),

            summaryLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            summaryLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            selectSeasonButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25),
            selectSeasonButton.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 80),
            selectSeasonButton.widthAnchor.constraint(equalToConstant: 110),
            selectSeasonButton.heightAnchor.constraint(equalToConstant: 26),

            episodesCollection.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            episodesCollection.topAnchor.constraint(equalTo: selectSeasonButton.bottomAnchor, constant: 14),
            episodesCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            episodesCollection.heightAnchor.constraint(equalToConstant: 150),
            episodesCollection.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),

//            pickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            pickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            pickerView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            pickerView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}
