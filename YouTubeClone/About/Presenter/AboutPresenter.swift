//
//  AboutPresenter.swift
//  YouTubeClone
//
//  Created by ENMANUEL TORRES on 26/01/23.
//

import Foundation

protocol AboutViewProtocol: AnyObject {
    func getChannel(ChannelList : [ChannelModel.Items])
}

@MainActor class AboutPresenter {
    private weak var delegate : AboutViewProtocol?
    private var provider : AboutProviderProtocol
    
    init(delegate : AboutViewProtocol, provider : AboutProviderProtocol = AboutProvider()){
        self.provider = provider
        self.delegate = delegate
        #if DEBUG
        if MockManager.shared.runAppwithMock{
            self.provider = AboutProviderMock()
        }
        #endif
    }
    
    
    func getChannel() async{
        do{

            let aboutChannel = try await provider.getChanell(channelId: Constants.channelId).items
            delegate?.getChannel(ChannelList: aboutChannel)
            
        }catch {
            debugPrint(error.localizedDescription)
        }
    }
}
