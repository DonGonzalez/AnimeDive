//
//  Service.swift
//  AnimeDive
//
//  Created by Robert B on 17/07/2022.
//

import Foundation
import UIKit

class Service {
    enum HTTPStatusCode: Int, Error {
        case OK = 200
        case Created = 201
        case No_Content = 204
        case Bad_Request = 400
        case Unauthorized = 401
        case Not_Found = 404
        case Not_Acceptable = 406
        case Server_Error = 500
    }
    
    enum ErrorFetch: Error {
    case invalidURL
    case unknown
    }
    func getDatas(completion: @escaping (Result<Service.Data, Error>) -> Void) throws {
       
        guard  let url = URL(string: "https://kitsu.io/api/edge/anime?") else {
            throw ErrorFetch.invalidURL
        }
        
      let task =  URLSession.shared.dataTask(with: url) {Data, Response , Error in
         
          var statusCode: Int
          
          if let response = Response as? HTTPURLResponse  {
              
              statusCode = response.statusCode
      
              if statusCode == HTTPStatusCode.OK.rawValue {
                  print(HTTPStatusCode.OK)
              
                 if Data != nil {
                          do { // if data from url isn't empty, complite code
                              let dataAPI = try JSONDecoder().decode(Service.Data.self, from: Data!)
                              print("Dane wczytane")
                             // print(dataAPI.data)
                              print(Response as Any)
                              print(Error as Any)
                              completion(.success(dataAPI))
                          }
                          catch {
                              completion(.failure(error))
                              print("Error data...\(error)")
                          }
                       } else {
                           completion(.failure(ErrorFetch.unknown))
                       }
              }
              
             else if statusCode == HTTPStatusCode.Created.rawValue {
                 print(HTTPStatusCode.Created)
                  }
              else if statusCode == HTTPStatusCode.No_Content.rawValue {
                  print(HTTPStatusCode.No_Content)
                   }
              else if statusCode == HTTPStatusCode.No_Content.rawValue {
                  print(HTTPStatusCode.No_Content)
                   }
              else if statusCode == HTTPStatusCode.Bad_Request.rawValue {
                       print(HTTPStatusCode.Bad_Request)
                        }
              else if statusCode == HTTPStatusCode.Unauthorized.rawValue {
                  print(HTTPStatusCode.Unauthorized)
                   }
              else if statusCode == HTTPStatusCode.Not_Found.rawValue {
                  print(HTTPStatusCode.Not_Found)
                   }
              else if statusCode == HTTPStatusCode.Not_Acceptable.rawValue {
                  print(HTTPStatusCode.Not_Acceptable)
                   }
         else if (500...599).contains(statusCode) {
                 print(HTTPStatusCode.Server_Error)
                  }
          }
         
      }
        task.resume()
    }
 
    
    struct Data: Decodable {
        var data: [AnimeData]
    }
        struct Response: Decodable {
            var statusCode: Int
        }

        enum ResponseCodingKeys: String, CodingKey {
            case statusCode = "Status Code"
        }
        
//  enum CodingKeys: String, CodingKey{
//
//     case attributes = "attributes"
//   case links = "links"
//  }
        
    
    struct AnimeData: Decodable {
        let id: String
        let type: String
    //  let links: LinksData
        let attributes: AttributesData
    }
  //  struct LinksData: Decodable {
  //     let self: String
  //
  //
  //  }
   
    struct AttributesData: Decodable {
        let createdAt: String
        let updatedAt: String
        let slug: String
        let description: String
        let canonicalTitle: String
        let posterImage: PosterImageData
    }
    struct PosterImageData: Codable {
        let tiny: String
        let large: String
        let small: String
        let medium: String
        let original: String
    }
    
}



// Data structure
/*
 {"data":
 [{"id":"1",
 "type":"anime",
 "links":{"self":"https://kitsu.io/api/edge/anime/1"},
 "attributes":{"createdAt":"2013-02-20T16:00:13.609Z",
 "updatedAt":"2022-06-25T19:45:55.179Z",
 "slug":"cowboy-bebop",
 "synopsis":"In the year 2071, humanity has colonized several of the planets and moons of the solar system leaving the now uninhabitable surface of planet Earth behind. The Inter Solar System Police attempts to keep peace in the galaxy, aided in part by outlaw bounty hunters, referred to as \"Cowboys\". The ragtag team aboard the spaceship Bebop are two such individuals.\nMellow and carefree Spike Spiegel is balanced by his boisterous, pragmatic partner Jet Black as the pair makes a living chasing bounties and collecting rewards. Thrown off course by the addition of new members that they meet in their travelsâEin, a genetically engineered, highly intelligent Welsh Corgi; femme fatale Faye Valentine, an enigmatic trickster with memory loss; and the strange computer whiz kid Edward Wongâthe crew embarks on thrilling adventures that unravel each member's dark and mysterious past little by little. \nWell-balanced with high density action and light-hearted comedy, Cowboy Bebop is a space Western classic and an homage to the smooth and improvised music it is named after.\n\n(Source: MAL Rewrite)",
 "description":"In the year 2071, humanity has colonized several of the planets and moons of the solar system leaving the now uninhabitable surface of planet Earth behind. The Inter Solar System Police attempts to keep peace in the galaxy, aided in part by outlaw bounty hunters, referred to as \"Cowboys\". The ragtag team aboard the spaceship Bebop are two such individuals.\nMellow and carefree Spike Spiegel is balanced by his boisterous, pragmatic partner Jet Black as the pair makes a living chasing bounties and collecting rewards. Thrown off course by the addition of new members that they meet in their travelsâEin, a genetically engineered, highly intelligent Welsh Corgi; femme fatale Faye Valentine, an enigmatic trickster with memory loss; and the strange computer whiz kid Edward Wongâthe crew embarks on thrilling adventures that unravel each member's dark and mysterious past little by little. \nWell-balanced with high density action and light-hearted comedy, Cowboy Bebop is a space Western classic and an homage to the smooth and improvised music it is named after.\n\n(Source: MAL Rewrite)",
 "coverImageTopOffset":400,
 "titles":{
 "en":"Cowboy Bebop",
 "en_jp":"Cowboy Bebop",
 "ja_jp":"ăŤăŚăăźă¤ăăăă"},
 "canonicalTitle":"Cowboy Bebop",
 "abbreviatedTitles":["COWBOY BEBOP"],
 "averageRating":"82.07",
 "ratingFrequencies":{"2":"4409","3":"61","4":"431","5":"36","6":"200","7":"40","8":"4115","9":"53","10":"859","11":"76","12":"2515","13":"160","14":"8729","15":"432","16":"9041","17":"900","18":"11076","19":"826","20":"36843"},
 "userCount":121662,
 "favoritesCount":4580,
 "startDate":"1998-04-03",
 "endDate":"1999-04-24",
 "nextRelease":null,
 "popularityRank":31,
 "ratingRank":106,
 "ageRating":"R",
 "ageRatingGuide":"17+ (violence & profanity)",
 "subtype":"TV",
 "status":"finished",
 "tba":null,
 "posterImage":
 {"tiny":"https://media.kitsu.io/anime/poster_images/1/tiny.jpg",
 "large":"https://media.kitsu.io/anime/poster_images/1/large.jpg",
 "small":"https://media.kitsu.io/anime/poster_images/1/small.jpg",
 "medium":"https://media.kitsu.io/anime/poster_images/1/medium.jpg",
 "original":"https://media.kitsu.io/anime/poster_images/1/original.jpg",
 "meta":{"dimensions":{"tiny":{"width":110,"height":156},
 "large":{"width":550,"height":780},
 "small":{"width":284,"height":402},
 "medium":{"width":390,"height":554}}}},
 "coverImage":{"tiny":"https://media.kitsu.io/anime/1/cover_image/tiny-1f92cfe65c1b31d8b47e36f025d32b35.jpeg",
 "large":"https://media.kitsu.io/anime/1/cover_image/large-88da0208ac7fdd1a978de8b539008bd8.jpeg",
 "small":"https://media.kitsu.io/anime/1/cover_image/small-33ff2ab0f599bc15ed73856ecd13fe71.jpeg",
 "original":"https://media.kitsu.io/anime/1/cover_image/fb57e5f25616633a41f0f5f1ded938ee.jpeg",
 "meta":
 {"dimensions":
 {"tiny":{"width":840,"height":200},
 "large":{"width":3360,"height":800},
 "small":{"width":1680,"height":400}}}},
 "episodeCount":26,
 "episodeLength":25,
 "totalLength":626,
 "youtubeVideoId":"qig4KOK2R2g",
 "showType":"TV",
 "nsfw":false},
 "relationships":{"genres":
 {"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/genres",
 "related":"https://kitsu.io/api/edge/anime/1/genres"}},
 "categories":{"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/categories",
 "related":"https://kitsu.io/api/edge/anime/1/categories"}},
 "castings":{"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/castings",
 "related":"https://kitsu.io/api/edge/anime/1/castings"}},
 "installments":{"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/installments",
 "related":"https://kitsu.io/api/edge/anime/1/installments"}},
 "mappings":{"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/mappings",
 "related":"https://kitsu.io/api/edge/anime/1/mappings"}},
 "reviews":{"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/reviews",
 "related":"https://kitsu.io/api/edge/anime/1/reviews"}},
 "mediaRelationships":{"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/media-relationships",
 "related":"https://kitsu.io/api/edge/anime/1/media-relationships"}},
 "characters":{"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/characters",
 "related":"https://kitsu.io/api/edge/anime/1/characters"}},
 "staff":{"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/staff",
 "related":"https://kitsu.io/api/edge/anime/1/staff"}},
 "productions":{"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/productions",
 "related":"https://kitsu.io/api/edge/anime/1/productions"}},
 "quotes":{"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/quotes",
 "related":"https://kitsu.io/api/edge/anime/1/quotes"}},
 "episodes":{"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/episodes",
 "related":"https://kitsu.io/api/edge/anime/1/episodes"}},
 "streamingLinks":{"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/streaming-links",
 "related":"https://kitsu.io/api/edge/anime/1/streaming-links"}},
 "animeProductions":{"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/anime-productions",
 "related":"https://kitsu.io/api/edge/anime/1/anime-productions"}},
 "animeCharacters":{"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/anime-characters",
 "related":"https://kitsu.io/api/edge/anime/1/anime-characters"}},
 "animeStaff":{"links":{"self":"https://kitsu.io/api/edge/anime/1/relationships/anime-staff",
 "related":"https://kitsu.io/api/edge/anime/1/anime-staff"}}}}

*/
