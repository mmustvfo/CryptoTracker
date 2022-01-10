//
//  MarketDataModel.swift
//  CtyptoTracker
//
//  Created by Mustafo on 07/06/21.
//

import Foundation

//JSON data:
/*
 
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 7753,
     "upcoming_icos": 0,
     "ongoing_icos": 50,
     "ended_icos": 3375,
     "markets": 621,
     "total_market_cap": {
       "btc": 47450957.42667903,
       "eth": 617694412.1873741,
       "ltc": 9643740588.124392,
       "bch": 2601033824.4329195,
       "bnb": 4326478752.583242,
       "eos": 293463937334.7582,
       "xrp": 1801488401753.6008,
       "xlm": 4444019060102.962,
       "link": 61642275446.40037,
       "dot": 69735777322.27457,
       "yfi": 39595546.37177929,
       "usd": 1721340141879.4045,
       "aed": 6322482341123.04,
       "ars": 163155848275925.66,
       "aud": 2221341255571.398,
       "bdt": 145032140221860.66,
       "bhd": 648862609161.7239,
       "bmd": 1721340141879.4045,
       "brl": 8686915160008.569,
       "cad": 2080127674352.0334,
       "chf": 1548247341232.4365,
       "clp": 1236436324201544,
       "cny": 11010896485559.98,
       "czk": 35946746182867.56,
       "dkk": 10526807440139.527,
       "eur": 1415470048048.4248,
       "gbp": 1216925512063.6306,
       "hkd": 13353795339270.605,
       "huf": 489668888262832.6,
       "idr": 24560081144335330,
       "ils": 5595870240432.917,
       "inr": 125342721830824.11,
       "jpy": 188372276416359.5,
       "krw": 1914472937657400.8,
       "kwd": 517854853643.5674,
       "lkr": 339197853693437.5,
       "mmk": 2819802879064979.5,
       "mxn": 34166396779584.4,
       "myr": 7105692105678.178,
       "ngn": 706179793206023.4,
       "nok": 14243444171498.832,
       "nzd": 2385613909331.3726,
       "php": 81924602042537.22,
       "pkr": 266004938867999.06,
       "pln": 6315853460236.673,
       "rub": 125341103771090.48,
       "sar": 6455450703062.791,
       "sek": 14233515481560.494,
       "sgd": 2278641226214.2793,
       "thb": 53699977083556.42,
       "try": 14845680840237.502,
       "twd": 47728458783960.95,
       "uah": 46688054982107.06,
       "vef": 172357788406.38452,
       "vnd": 39501988606270540,
       "zar": 23219856037908.867,
       "xdr": 1191666566821.6904,
       "xag": 62456813080.12796,
       "xau": 913446359.6897254,
       "bits": 47450957426679.03,
       "sats": 4745095742667903
     },
     "total_volume": {
       "btc": 3257520.7027945183,
       "eth": 42404883.79628649,
       "ltc": 662045326.8353288,
       "bch": 178561655.8917984,
       "bnb": 297013903.8504726,
       "eos": 20146376453.388107,
       "xrp": 123672652414.32404,
       "xlm": 305083076864.5253,
       "link": 4231758415.9242315,
       "dot": 4787379447.586347,
       "yfi": 2718244.66858937,
       "usd": 118170453301.97575,
       "aed": 434040074978.15607,
       "ars": 11200691879865.117,
       "aud": 152495661213.50717,
       "bdt": 9956494557002.953,
       "bhd": 44544588713.086266,
       "bmd": 118170453301.97575,
       "brl": 596359009633.7485,
       "cad": 142801311735.97275,
       "chf": 106287587029.28893,
       "clp": 84881678731083.39,
       "cny": 755900938636.7478,
       "czk": 2467753576305.1567,
       "dkk": 722668098395.5403,
       "eur": 97172390943.38759,
       "gbp": 83542256348.17795,
       "hkd": 916741560921.5331,
       "huf": 33615897919347.637,
       "idr": 1686056027712589,
       "ils": 384157963230.32684,
       "inr": 8604810807862.771,
       "jpy": 12931806301421.742,
       "krw": 131429070509174.2,
       "kwd": 35550871853.17958,
       "lkr": 23286021835432.77,
       "mmk": 193580209009422.97,
       "mxn": 2345532121693.5366,
       "myr": 487807631230.5556,
       "ngn": 48479428467135.4,
       "nok": 977816187153.8586,
       "nzd": 163773022083.47446,
       "php": 5624145469227.567,
       "pkr": 18261308989329.332,
       "pln": 433585000562.4909,
       "rub": 8604699727636.65,
       "sar": 443168387984.3733,
       "sek": 977134579979.2144,
       "sgd": 156429319263.02332,
       "thb": 3686517545184.948,
       "try": 1019159892798.3566,
       "twd": 3276571243930.5166,
       "uah": 3205147249398.0127,
       "vef": 11832407489.126814,
       "vnd": 2711821903389681.5,
       "zar": 1594049221794.39,
       "xdr": 81808223116.42462,
       "xag": 4287676638.6318107,
       "xau": 62708332.74922649,
       "bits": 3257520702794.5186,
       "sats": 325752070279451.8
     },
     "market_cap_percentage": {
       "btc": 39.47021153257378,
       "eth": 18.801119824880427,
       "usdt": 3.6442487898839913,
       "bnb": 3.570241759687294,
       "ada": 3.1864290728375364,
       "doge": 2.8103375613936534,
       "xrp": 2.5613508920374337,
       "dot": 1.4362952768076163,
       "usdc": 1.3412610225879447,
       "uni": 0.7927320358431386
     },
     "market_cap_change_percentage_24h_usd": 0.9816054546600377,
     "updated_at": 1623060070
   }
 }
 
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

// MARK: - MarketDataModel
struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys:String,CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
            return item.value.formattedWithAbbreviations()
        } else  {
            return ""
        }
    }
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd"}) {
            return item.value.formattedWithAbbreviations()
        } else  {
            return ""
        }
    }
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
            return item.value.formattedWithAbbreviations()
        } else  {
            return ""
        }
    }
    
    
}
