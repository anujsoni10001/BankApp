//
//  TransferFundsAccountSelectionView.swift
//  BankApp
//
//  Created by Anuj Soni on 21/06/22.
//

import SwiftUI

struct TransferFundsAccountSelectionView:View{
    
    @Binding var showSheet : Bool
    @Binding var isFromAccount: Bool
    @ObservedObject var transferFundsVM:TranserFundsViewModel
    
    var body: some View {
        VStack(spacing:10){
            
            Button("From \(transferFundsVM.fromAccountType)"){
                isFromAccount = true
                showSheet = true
            }
            .padding()
            .frame(maxWidth:.infinity)
            .background(.green)
            .foregroundColor(.white)
            
            Button("To \(transferFundsVM.toAccountType)"){
                isFromAccount = false
                showSheet = true
            }
            .padding()
            .frame(maxWidth:.infinity)
            .background(.green)
            .foregroundColor(.white)
            .opacity(transferFundsVM.fromAccount != nil ? 1.0 : 0.5)
            .disabled(transferFundsVM.fromAccount == nil)
            
            TextField("Amount", text:$transferFundsVM.amount)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
        }.padding()
    }
}
