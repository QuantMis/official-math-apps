//
//  ShopView.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 21/12/2023.
//

import SwiftUI
import CoreData

struct ShopView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var navigationStateManager: NavigationStateManager
    @FetchRequest(fetchRequest: Wallet.all()) private var wallets

    @State private var selectedIndex: Int = 0
    @State private var unlockConfirmation = false
    
    @FetchRequest var stuffs: FetchedResults<Stuffs>
    init(category: String) {
        _stuffs = FetchRequest(fetchRequest: Stuffs.byCategory(category: category))
    }
    
    var body: some View {
        
        VStack {
            HStack(alignment: .center) {
                HStack(alignment: .center) {
                    Image("coin")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("\(wallets.first?.coins ?? 0)").font(.largeTitle).foregroundColor(.secondary).bold()
                    
                }
                Spacer()
            }
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 10) {
                    ForEach(0..<stuffs.count) { i in
                        Button {
                            unlockConfirmation = true
                            selectedIndex = i
                        } label: {
                            VStack {
                                if (stuffs[i].unlocked) {
                                    HStack {
                                        Spacer()
                                        Image(stuffs[i].image ?? "").resizable().frame(width: 150, height: 150)
                                        Spacer()
                                    }
                                } else {
                                    ZStack {
                                        Image(stuffs[i].image ?? "").resizable().frame(width: 150, height: 150).opacity(0.2)
                                        HStack {
                                            Spacer()
                                            Image("coin")
                                                .resizable()
                                                .frame(width: 20, height: 20)
                                            Text("\(stuffs[i].price)").bold()
                                            Spacer()
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding(.all, 10)
                            .background(.gray.opacity(0.1))
                            .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .alert(isPresented: $unlockConfirmation) {
                            Alert(
                                title: Text(stuffs[selectedIndex].name ?? ""),
                                message: Text("Purchase this sticker with \(stuffs[selectedIndex].price) coins"),
                                primaryButton: .default(Text("Yes")) {
                                    let coins = wallets.first?.coins ?? 0
                                    if (coins >= stuffs[selectedIndex].price) {
                                        viewContext.perform {
                                            stuffs[selectedIndex].unlocked = true
                                            wallets.first?.coins -= stuffs[selectedIndex].price
                                            do {
                                                try viewContext.save()
                                            } catch {
                                            }
                                        }
                                    } else {
                                    }
                                },
                                secondaryButton: .cancel(Text("No"))
                            )
                        }
                        
                    }
                }
                
            }
        }
        
        
    }
}

#Preview {
    ShopView(category: "1")
}
