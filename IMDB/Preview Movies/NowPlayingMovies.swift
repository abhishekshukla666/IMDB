//
//  NowPlayingMovies.swift
//  IMDB
//
//  Created by Abhishek Shukla on 06/05/25.
//

import Foundation

extension Movie {
    
    static var sampleData_Multiples: [Movie] {
        [
            .init(backdropPath: OptionalDataType.stringValue("/fTrQsdMS2MUw00RnzH0r3JWHhts.jpg"),
                  id: 1197306,
                  originalTitle: OptionalDataType.stringValue("A Working Man"),
                  overview: OptionalDataType.stringValue("Levon Cade left behind a decorated military career in the black ops to live a simple life working construction. But when his boss's daughter, who is like family to him, is taken by human traffickers, his search to bring her home uncovers a world of corruption far greater than he ever could have imagined."),
                  posterPath: OptionalDataType.stringValue("/6FRFIogh3zFnVWn7Z6zcYnIbRcX.jpg"),
                  releaseDate: OptionalDataType.stringValue("2025-03-26"),
                  title: OptionalDataType.stringValue("A Working Man"),
                  voteAverage: OptionalDataType.double(5.5),
                  voteCount: OptionalDataType.double(434)),
            
                .init(
                    backdropPath: OptionalDataType.stringValue("/ybBIIzDL1B9yH8OVFav81JTZmoN.jpg"),
                    id: 1233069,
                    originalTitle: OptionalDataType.stringValue("Exterritorial"),
                    overview: OptionalDataType.stringValue("When her son vanishes inside a US consulate, ex-special forces soldier Sara does everything in her power to find him — and uncovers a dark conspiracy."),
                    posterPath: OptionalDataType.stringValue("/qWTfHG8KdXwr0bqypYbNZLenh0J.jpg"),
                    releaseDate: OptionalDataType.stringValue("2025-04-29"),
                    title: OptionalDataType.stringValue("Exterritorial"),
                    voteAverage: OptionalDataType.double(5.5),
                    voteCount: OptionalDataType.double(434)),
            
                .init(
                    backdropPath: OptionalDataType.stringValue("/44YfHklKam8COMUxDZop2Lnp0CS.jpg"),
                    id: 668489,
            originalTitle: OptionalDataType.stringValue("Havoc"),
                    overview: OptionalDataType.stringValue("When a drug heist swerves lethally out of control, a jaded cop fights his way through a corrupt city's criminal underworld to save a politician's son."),
                    posterPath: OptionalDataType.stringValue("/r46leE6PSzLR3pnVzaxx5Q30yUF.jpg"),
                    releaseDate: OptionalDataType.stringValue("2025-04-24"),
                    title: OptionalDataType.stringValue("Havoc"),
        voteAverage: OptionalDataType.double(5.5),
        voteCount: OptionalDataType.double(434)),
            
                .init(
                    backdropPath: OptionalDataType.stringValue("/1AWjIUgbZYaKbwUH5qoJaKCcRkf.jpg"),
                    id: 1471014,
                    originalTitle: OptionalDataType.stringValue("Van Gogh by Vincent"),
                    overview: OptionalDataType.stringValue("In a career that lasted only ten years, Vincent Van Gogh painted one subject more than any other: himself. This is the story of Vincent told using eight of his most iconic self-portraits."),
                    posterPath: OptionalDataType.stringValue("/z73X4WKZghBh5fri31o8P6vBEB2.jpg"),
                    releaseDate: OptionalDataType.stringValue("2025-03-26"),
                    title: OptionalDataType.stringValue("Van Gogh by Vincent"),
                    voteAverage: OptionalDataType.double(5.5),
                    voteCount: OptionalDataType.double(434)),
            
                .init(
                    backdropPath: OptionalDataType.stringValue("/rthMuZfFv4fqEU4JVbgSW9wQ8rs.jpg"),
                    id: 986056,
                    originalTitle: OptionalDataType.stringValue("Thunderbolts*"),
                    overview: OptionalDataType.stringValue("After finding themselves ensnared in a death trap, seven disillusioned castoffs must embark on a dangerous mission that will force them to confront the darkest corners of their pasts."),
                    posterPath: OptionalDataType.stringValue("/vnfgoohSwKNOcRfJOPULXTvX0cu.jpg"),
                    releaseDate: OptionalDataType.stringValue("2025-04-30"),
                    title: OptionalDataType.stringValue("Thunderbolts*"),
                    voteAverage: OptionalDataType.double(5.5),
                    voteCount: OptionalDataType.double(434)),
            
                .init(
                    backdropPath: OptionalDataType.stringValue("/2Nti3gYAX513wvhp8IiLL6ZDyOm.jpg"),
                    id: 950387,
                    originalTitle: OptionalDataType.stringValue("A Minecraft Movie"),
                    overview: OptionalDataType.stringValue("Four misfits find themselves struggling with ordinary problems when they are suddenly pulled through a mysterious portal into the Overworld: a bizarre, cubic wonderland that thrives on imagination. To get back home, they'll have to master this world while embarking on a magical quest with an unexpected, expert crafter, Steve."),
                    posterPath: OptionalDataType.stringValue("/iPPTGh2OXuIv6d7cwuoPkw8govp.jpg"),
                    releaseDate: OptionalDataType.stringValue("2025-03-31"),
                    title: OptionalDataType.stringValue("A Minecraft Movie"),
                   voteAverage: OptionalDataType.double(5.5),
                    voteCount: OptionalDataType.double(434)),
            
                .init(
                    backdropPath: OptionalDataType.stringValue("/kFXtAwJYbRTqiyQpE9kDc8qEP3X.jpg"),
                    id: 1225915,
                    originalTitle: OptionalDataType.stringValue("ज्वेल थीफ: द हीस्ट बिगिन्स"),
                    overview: OptionalDataType.stringValue("In this high-octane battle of wits and wills, ingenious con artist Rehan devises a diamond heist while trying to outsmart Rajan, his sadistic adversary."),
                    posterPath: OptionalDataType.stringValue("/eujLbO0kf1eqWC8XpHUJdtAVW2J.jpg"),
                    releaseDate: OptionalDataType.stringValue("2025-04-25"),
                    title: OptionalDataType.stringValue("Jewel Thief: The Heist Begins"),
                   voteAverage: OptionalDataType.double(5.5),
                    voteCount: OptionalDataType.double(434)),
            
                .init(
                    backdropPath: OptionalDataType.stringValue("/op3qmNhvwEvyT7UFyPbIfQmKriB.jpg"),
                    id: 324544,
                    originalTitle: OptionalDataType.stringValue("In the Lost Lands"),
                    overview: OptionalDataType.stringValue("A queen sends the powerful and feared sorceress Gray Alys to the ghostly wilderness of the Lost Lands in search of a magical power, where she and her guide, the drifter Boyce, must outwit and outfight both man and demon."),
                    posterPath: OptionalDataType.stringValue("/dDlfjR7gllmr8HTeN6rfrYhTdwX.jpg"),
                    releaseDate: OptionalDataType.stringValue("2025-02-27"),
                    title: OptionalDataType.stringValue("In the Lost Lands"),
                   voteAverage: OptionalDataType.double(5.5),
                    voteCount: OptionalDataType.double(434)),
        ]
        
    }
    
    static var sampleData_Single: Movie {
        
        Movie(backdropPath: OptionalDataType.stringValue("/fTrQsdMS2MUw00RnzH0r3JWHhts.jpg"),
              id: 1197306,
              originalTitle: OptionalDataType.stringValue("A Working Man"),
              overview: OptionalDataType.stringValue("Levon Cade left behind a decorated military career in the black ops to live a simple life working construction. But when his boss's daughter, who is like family to him, is taken by human traffickers, his search to bring her home uncovers a world of corruption far greater than he ever could have imagined."),
              posterPath: OptionalDataType.stringValue("/6FRFIogh3zFnVWn7Z6zcYnIbRcX.jpg"),
              releaseDate: OptionalDataType.stringValue("2025-03-26"),
              title: OptionalDataType.stringValue("A Working Man"),
              voteAverage: OptionalDataType.double(5.5),
              voteCount: OptionalDataType.double(434))
        
    }
}
