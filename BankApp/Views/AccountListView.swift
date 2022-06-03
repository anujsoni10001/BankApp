//
//  AccountListView.swift
//  BankApp
//
//  Created by Anuj Soni on 03/06/22.
//

import SwiftUI

struct AccountListView: View {
    
    let accounts : [AccountViewModel]
    
    var body: some View {
        List(accounts,id: \.accountId){item in
            
            AccountCell(accounts: item)
        }
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        AccountListView(accounts: [AccountViewModel(account:Account(id:UUID(), name:"Isha", accountType:.checking, balance: 5000)),AccountViewModel(account:Account(id:UUID(), name:"Isha", accountType:.checking, balance: 5000))])
    }
}




struct AccountCell: View {
    
    let accounts : AccountViewModel
    
    var body: some View {
        HStack{
            
            VStack(alignment:.leading, spacing: 10){
                Text(accounts.name)
                    .font(.headline)
                
                Text(accounts.accountType)
                    .opacity(0.5)
            }
            
            Spacer()
            
            Text(accounts.balance.formatAsCurrency())
                .foregroundColor(.green)
        }
    }
}

