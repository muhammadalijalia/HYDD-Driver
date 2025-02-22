//
//  JobListingPresenter.swift
//  HYDD-driver
//
//  Created Syed Kashan on 26/01/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//
//  Template generated by Syed Kashan
//

import UIKit

class JobListingPresenter: JobListingPresenterProtocol, JobListingInteractorOutputProtocol {
    weak private var view: JobListingViewProtocol?
    var interactor: JobListingInteractorInputProtocol?
    private let router: JobListingWireframeProtocol
    
    var missionData: [CarSummaryModel]?

    init(interface: JobListingViewProtocol, interactor: JobListingInteractorInputProtocol?, router: JobListingWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func selectedJob(index: IndexPath) {
        guard let data = self.missionData?[index.row] else {return}
        router.showAcceptScreen(data: data)
    }
    
    func getNewMissions() {
        view?.showLoader()
        interactor?.getNewMissions()
    }
    
    func successFound(data: [CarSummaryModel]) {
        view?.hideLoader()
        missionData = []
        missionData = data
        view?.showNoData(message: "")
        view?.reloadData()
    }
    
    func failureFound(message: String) {
        view?.hideLoader()
        view?.showNoData(message: message)
        missionData = []
        view?.reloadData()
    }
}
