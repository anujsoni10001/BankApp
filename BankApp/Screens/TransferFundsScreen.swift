//
//  TransferFundsScreen.swift
//  BankApp
//
//  Created by Anuj Soni on 17/06/22.
//

import SwiftUI

struct TransferFundsScreen: View {

@Environment(\.presentationMode) var presentationMode
@ObservedObject private var transferFundsVM = TranserFundsViewModel()
    
@State private var showSheet:Bool = false
@State private var isFromAccount:Bool = false
    
   var actionSheetButtons: [Alert.Button] {
       
       var actionButtons = self.transferFundsVM.filteredAccount.map{account in
           Alert.Button.default(Text("\(account.name) (\(account.accountType))")){
               if isFromAccount{
                   self.transferFundsVM.fromAccount = account
               } else {
                   self.transferFundsVM.toAccount = account
               }
           }
       }
       actionButtons.append(.cancel())
       return actionButtons
   }
    
    var body: some View {
        
        ScrollView{
        VStack{
            
        AccountListView(accounts:transferFundsVM.accounts)
        .frame(height:200)
            
        TransferFundsAccountSelectionView(showSheet: $showSheet, isFromAccount: $isFromAccount, transferFundsVM: transferFundsVM)
        
        Spacer()
            
        .onAppear{
        transferFundsVM.populateAccounts()
        }
            
        Text(self.transferFundsVM.errorMessage ?? "")
            
        Button("Submit Transfer"){
            self.transferFundsVM.submitTransfer {
                self.presentationMode.wrappedValue.dismiss()
            }
        }.padding()
            
        .actionSheet(isPresented: $showSheet){
        ActionSheet(title:Text("Transfer Funds"), message: Text("Choose an Account"), buttons:self.actionSheetButtons)
        }
        }
        }
        .navigationTitle("Transfer Funds")
        .embedInNavigationView()
    }
}

struct TransferFundsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransferFundsScreen()
    }
}





