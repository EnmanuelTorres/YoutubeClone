//
//  HomeViewControllerTests.swift
//  YouTubeCloneTests
//
//  Created by ENMANUEL TORRES on 3/02/23.
//

import XCTest
@testable import YouTubeClone

final class HomeViewControllerTests: XCTestCase {
    
    var sut : HomeViewController!
    var provider : HomeProviderProtocol!
    var waiting : TimeInterval = 0.2

    @MainActor override func setUpWithError() throws {
        PresentMockManager.shared.vc = nil
       provider = HomeProviderMock()
       sut = HomeViewController()
       sut.presenter = HomePresenter(delegate: sut, provider: provider)
       sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        PresentMockManager.shared.vc = nil
        provider = nil
    }

    func testHeaderInfoTableView_ShouldContain_ChannelInfo() throws{
        //Arrange
        let tableView = try XCTUnwrap(sut.tableViewHome, "you should create this IBOutlet")
        
        let expLoadingData = expectation(description: "loading")
        DispatchQueue.main.asyncAfter(deadline: .now()+waiting){
            expLoadingData.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        guard let header = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? ChannelCell else {
            XCTFail("The first position shoud be the ChannelCell")
            return
        }
        let expectedTitle = "Victor Roldan Dev"
        let expectedSubscriberButton = "SUBSCRIBED"
       
        
        //Act
        
        
        //Assert
        XCTAssertEqual(expectedTitle, header.channelTitle.text)
        XCTAssertEqual(expectedSubscriberButton, header.subscribeLabel.text)
        
    }
    
    func testVideoSection_ValidateItsContent() throws {
        //Arrange
        let tableView = try XCTUnwrap(sut.tableViewHome, "you should create this IBOutlet")
        
        let expLoadingData = expectation(description: "loading")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            expLoadingData.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        guard let videoCell = tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as? VideoCell else {
            XCTFail("The first position shoud be the VideoCell")
            return
        }
        
        let videoName = try XCTUnwrap(videoCell.videoName, "you should create this IBOutlet")
        
        XCTAssertNotNil(videoName.text)
        XCTAssertNotNil(videoCell.videoImage)
        XCTAssertNotNil(videoCell.channelName.text)
        XCTAssertNotNil(videoCell.viewsCountLabel.text)
        
        
        
    }
    
    func testVideoSection_ValidateIfThreeDotsButton_HasAction() throws{
        //Arrange
        let tableView = try XCTUnwrap(sut.tableViewHome, "you should create this IBOutlet")
        
        let expLoadingData = expectation(description: "loading")
        DispatchQueue.main.asyncAfter(deadline: .now()+waiting){
            expLoadingData.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        guard let videoCell = tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as? VideoCell else {
            XCTFail("The first position shoud be the VideoCell")
            return
        }
        
        let dotsButton = try XCTUnwrap(videoCell.dotsButton)
        let dotsAction = try XCTUnwrap(dotsButton.actions(forTarget: videoCell, forControlEvent: .touchUpInside))
        
        XCTAssertEqual(dotsAction.count, 1)
 }
 
    func testVideoSection_OpenButtonSheet() throws{
        //Arrange
        let tableView = try XCTUnwrap(sut.tableViewHome, "you should create this IBOutlet")
        
        let expLoadingData = expectation(description: "loading")
        DispatchQueue.main.asyncAfter(deadline: .now()+waiting){
            expLoadingData.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        guard let videoCell = tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as? VideoCell else {
            XCTFail("The first position shoud be the VideoCell")
            return
        }
        
        let dotsButton = try XCTUnwrap(videoCell.dotsButton)
        dotsButton.sendActions(for: .touchUpInside)
        
        //Asertion
        XCTAssertTrue(PresentMockManager.shared.vc.isKind(of: BottomSheetViewController.self))
 }
    
}

class NavigationControllerMock : UINavigationController {
    var pushedVC: UIViewController!
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushedVC = viewController
    }
}

fileprivate class PresentMockManager {
    static var shared = PresentMockManager()
    init(){}
    var vc : UIViewController!
}
extension HomeViewController{
    override open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil){
        super.present(viewControllerToPresent, animated: flag)
        PresentMockManager.shared.vc = viewControllerToPresent
    }
}
