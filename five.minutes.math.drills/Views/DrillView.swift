//
//  DrillView.swift
//  five.minutes.math.drills
//
//  Created by Quantmis on 23/11/2023.
//

import SwiftUI

struct DrillView: View {
    private var backgroundImage = "drill2"
    private var title = "Arithmetic Drill"
    private var best = "YOUR BEST RESULT: 30/30 in 02:34"
    private var info = "Drill info"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer().frame(height: 20)
                
                ZStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(title)
                            .font(.largeTitle)
                            .bold()
                        
                        Text(best)
                            .font(.caption)
                            .fontWeight(.semibold)
                        
                        HStack {
                            Text(info)
                                .font(.caption)
                        }
                    }
                    .padding(20)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    DrillView()
}
