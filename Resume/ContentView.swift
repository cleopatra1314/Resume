//
//  ContentView.swift
//  Resume
//
//  Created by 黃郁雯 on 2022/11/26.
//

import SwiftUI
import AVFoundation
import AVKit


struct PlayerView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }

    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
    }
}


class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?




    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Load the resource
        let fileUrl = Bundle.main.url(forResource: "introduction_compressed", withExtension: "mp4")!
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)

        // Setup the player
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)

        // Create a new player looper with the queue player and template item
        playerLooper = AVPlayerLooper(player: player, templateItem: item)

        // Start the movie
        player.play()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}



struct ContentView: View {
    let me = Resume.shared
    @State var isShowContactView = false
    //無法直接修改 view 裡的屬性，所以要加 @State -> 表示此變數需要被拉出來另外做狀態管理，所以這個 view 並沒有被改變，他只是被儲存在另一個可以被改變的地方。
    
    var body: some View {
        ScrollView{
            VStack(spacing: 40){

                cardView
                
                VStack(spacing: 16){
                    Text(me.bio)
                        .font(.subheadline)
                        .foregroundColor(Color(red: 82/255, green: 54/255, blue: 40/255))
                    
                    myWebSiteView
                    
//                    //作品集連結第二版本
//                    HStack(spacing: 16){
//                        Button{ UIApplication.shared.open(URL(string: me.myWebsite[1].1)!)} label:{
//                            Text("Fan Page")
//                                .padding(.vertical, 8)
//                                .padding(.horizontal, 16)
//                                .background(RoundedRectangle(cornerRadius: 15).stroke(Color(red: 139/255, green: 101/255, blue: 139/255), lineWidth: 3))
//                                .foregroundColor(Color(red: 82/255, green: 54/255, blue: 40/255))
//                            //.border(Color.purple, width: 3)
//                            //.foregroundColor(Color(red: 139/255, green: 58/255, blue: 58/255, opacity: 1))
//                        }
//
//                        Button{ UIApplication.shared.open(URL(string: me.myWebsite[1].1)!)} label:{
//                            HStack{
//                                Image(systemName: "command.square")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .background(Color(red: 255/255, green: 211/255, blue: 155/255).cornerRadius(8))
//                                    .background(Color(red: 255/255, green: 193/255, blue: 193/255).cornerRadius(8))
//                                    .frame(width: 20)
//                                //藕紅色.foregroundColor(Color(red: 205/255, green: 92/255, blue: 92/255, opacity: 1))
//                                    .foregroundColor(Color(red: 139/255, green: 101/255, blue: 139/255, opacity: 1))
//
//                                Text("Portfolio")
//
//
//                                    .foregroundColor(Color(red: 82/255, green: 54/255, blue: 40/255))
//                                //.border(Color.purple, width: 3)
//                                //.foregroundColor(Color(red: 139/255, green: 58/255, blue: 58/255, opacity: 1))
//                            }.padding(.vertical, 8)
//                                .padding(.horizontal, 16)
//                            .background(RoundedRectangle(cornerRadius: 15).stroke(Color(red: 205/255, green: 92/255, blue: 92/255, opacity: 1), lineWidth: 3))
//                        }
//                    }
                }
//                //第一種 button
//                Button("Contact Me"){
//
//                    }.font(.title3)
//                    .fontWeight(.medium)
//                    .foregroundColor(.white)
//                    .padding(.vertical, 8)
//                    .frame(maxWidth: .infinity)
//                    .background(RoundedRectangle(cornerRadius: 30).foregroundColor(Color(red: 176/255, green: 23/255, blue: 31/255, opacity: 1)))
                
                //第二種 button
                Button { isShowContactView = true } label:{ Text("Contact Me")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 255/255, green: 239/255, blue: 213/255))
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 30).foregroundColor(Color(red: 139/255, green: 58/255, blue: 58/255, opacity: 1)))
                }
                
                
//                //第三種 button
//                Text("Contact Me")
//                    .font(.title3)
//                    .fontWeight(.medium)
//                    .foregroundColor(.white)
//                    .padding(.vertical, 8)
//                    .frame(maxWidth: .infinity)
//                //btn 顏色這行要再精簡
//                    .background(RoundedRectangle(cornerRadius: 30)
//                        .foregroundColor(Color(red: 176/255, green: 23/255, blue: 31/255, opacity: 1)))
//                //.foregroundColor(UIColor(red: 176/255, green: 23/255, blue: 31/255, alpha: 0.5)))
//                    .onTapGesture {}
                
                    Text("Skills")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color(red: 82/255, green: 54/255, blue: 40/255))
                    skillView
                
                    Text("Career Summary")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color(red: 82/255, green: 54/255, blue: 40/255))
                    careerView
                    
                    Text("Education")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color(red: 82/255, green: 54/255, blue: 40/255))
                    educationView
                
                //Group 暫時解決 view 太多的報錯
                Group{
                    Text("Introduction Video")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color(red: 82/255, green: 54/255, blue: 40/255))
                    
                    //嵌入自我介紹影片
                    PlayerView()
                        .aspectRatio(16/9, contentMode: .fill)
                        .frame(width: 320, height: 180)
                        .cornerRadius(4)
                        
                    //.overlay(Color.black.opacity(0.2))
                    //.blur(radius: 1)
                        //.edgesIgnoringSafeArea(.all)
                }
                
//                GeometryReader{ geo in
//                    ZStack {
//                        PlayerView()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: geo.size.width, height: geo.size.height+100)
//                            .overlay(Color.black.opacity(0.2))
//                            //.blur(radius: 1)
//                        .edgesIgnoringSafeArea(.all)
//
//                        VStack{
//                            Text("甲霸抹")
//                                .font(.title)
//                                .foregroundColor(.white)
//                            Spacer()
//                        }
//                    }
//                }
                //影片
            }.padding(24)
                 .lineSpacing(4)
                 .overlay(Color.black.opacity(isShowContactView ? 0.6 : 0))
                 .onTapGesture {isShowContactView = false}
                 .overlay(alignment: .top) {
                     Group{
                         if isShowContactView{
                             ContactView(isShowing: $isShowContactView)
                             .offset(y: UIScreen.main.bounds.maxY * 0.31)
                             .transition(.slide)
                         }
                     }
                     //value 意思？
                     //overlay closure 裏面需要的回傳值是個 view，用 group 假裝
                 }.animation(.spring(), value: isShowContactView)
                 
        }.background(Color(red: 253/255, green: 245/255, blue: 230/255))
            //.background(Color(uiColor: .secondarySystemBackground))
        }
    
    var cardView: some View{
        HStack{
            Image("myProfilePic")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(200)
                .frame(width: 160)
            VStack(spacing: 2){
                Text(me.name)
                    .foregroundColor(Color(red: 82/255, green: 54/255, blue: 40/255))
                    .padding(12)
                    .font(.title2)//.bold()
                Text(me.title)
                    .font(.body)
                    .foregroundColor(Color(red: 82/255, green: 54/255, blue: 40/255))
                //可以直接用label結合
                HStack{
                    Image(systemName: "location.fill")
                    Text(me.location)
                        .font(.body)
                }.foregroundColor(.secondary)
            }
        }
    }
    
    var myWebSiteView: some View{
        HStack(spacing: 20){
            let myWeb = me.myWebsite
            HStack{
                //let url = URL(string: myWeb.1)!
                Image(myWeb[0].0.lowercased())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32)
                
                Text(myWeb[0].0)
                    .underline()
                    .foregroundColor(Color(red: 82/255, green: 54/255, blue: 40/255))
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }.onTapGesture {
                UIApplication.shared.open(URL(string: myWeb[0].1)!)
            }
            
            HStack{
                Image(systemName: "command.square")
                    .resizable()
                    .background(Color(red: 255/255, green: 211/255, blue: 155/255).cornerRadius(8))
                    .background(Color(red: 255/255, green: 193/255, blue: 193/255).cornerRadius(8))
                    .frame(width: 32)
                    //藕紅色.foregroundColor(Color(red: 205/255, green: 92/255, blue: 92/255, opacity: 1))
                    .foregroundColor(Color(red: 139/255, green: 101/255, blue: 139/255, opacity: 1))
                    
                
                Text(myWeb[1].0)
                    .underline()
                    .foregroundColor(Color(red: 82/255, green: 54/255, blue: 40/255))
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }.onTapGesture {
                UIApplication.shared.open(URL(string: myWeb[1].1)!)
            }
//                    ForEach(me.myWebsite, id: \.name){ myWeb in
//                        HStack{
//                            Image(myWeb.0.lowercased())
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 32)
//
//                            let url = URL(string: myWeb.1)!
//                            Text(myWeb.0)
//                                .underline()
//                                .bold()
//                                .foregroundColor(Color(red: 82/255, green: 54/255, blue: 40/255))
//                                .onTapGesture {
//                                    UIApplication.shared.open(url)
//                        }
//                        }
//                    }
        }.frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    var skillView: some View{
        HStack(spacing: 4){
            //                    VStack{
            //                        Image("swiftIcon")
            //                            .resizable()
            //                            .aspectRatio(contentMode: .fit)
            //                            .frame(width: 50)
            //                        Text("Swift")
            //                    }.frame(width: 72)
            //                    VStack{
            //                        Image("figmaIcon")
            //                            .resizable()
            //                            .aspectRatio(contentMode: .fit)
            //                            .frame(width: 50)
            //                            .cornerRadius(16)
            //                        Text("Figma")
            //                    }.frame(width: 84)
            //                    VStack{
            //                        Image("photoshopIcon")
            //                            .resizable()
            //                            .aspectRatio(contentMode: .fit)
            //                            .frame(width: 50)
            //                        Text("Photoshop")
            //                    }.frame(width: 84)
            //                    VStack{
            //                        Image("premiereIcon")
            //                            .resizable()
            //                            .aspectRatio(contentMode: .fit)
            //                            .frame(width: 50)
            //                        Text("Premiere")
            
            //let skill = me.skills.first!
            //要使用 ForEach 迴圈，並用keypath \.0 來存取 id，id 要是 hashable
            ForEach(me.skills, id: \.skillicon) { skill in
                VStack{
                    Image(skill.skillicon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                    Text(skill.skillname)
                        .foregroundColor(Color(red: 82/255, green: 54/255, blue: 40/255))
                        .font(.subheadline)
                }.frame(width: 84)
            }
        }
        
    }
    
    var careerView: some View{
        VStack(spacing: 0){
            ForEach(me.experiences.indices, id: \.self) { index in
                HStack{
                    DotLineShape(dotSize: 10, lineWidth: 2.5, style: index == 0 ? .buttomHalf : index == (me.experiences.count - 1) ? .topHalf : .full)
                        .frame(width: 60)
                        //.foregroundColor(.secondary)
                        .foregroundColor(Color(red: 205/255, green: 155/255, blue: 155/255))
                    
//                                Circle()
//                                    .frame(width: 10)
//                                    .background(.blue)
//                                Rectangle().frame(width: 5)
                    //exp is let? or var?
                    let exp = me.experiences[index]
                    
                    VStack(spacing: 4){
                        Group{
                            Text(exp.title)
                                .bold()
                            Text(exp.company)
                                .font(.subheadline)
                            Text("\(exp.start) - \(exp.end)")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                                .padding(.bottom, 32)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                         .foregroundColor(Color(red: 82/255, green: 54/255, blue: 40/255))
                    }
                }
            }
        }
    }
    
    var educationView: some View{
        VStack(spacing: 8){
            ForEach(me.education, id: \.0){ edu in
                VStack(spacing: 4){
                    Group{
                        Text(edu.0)
                            .bold()
                        Text(edu.1)
                            .font(.subheadline)
                        Text("\(edu.2) - \(edu.3)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.bottom, 24)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 24)
                        .foregroundColor(Color(red: 82/255, green: 54/255, blue: 40/255))
                }
            }
        }
    }
    
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

