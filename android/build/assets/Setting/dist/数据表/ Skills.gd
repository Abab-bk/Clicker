# warnings-disable
extends RefCounted

var True = true
var False = false
var None = null


var data = \
{
20001:{ "id":20001,  "name":'终极之盐',  "desc":'每个工人获得的金币倍数*2',  "cost":[1, 3],  "effect":'add[10001][bonus][efficiency][2.0]',  "unlock":'own[10001]1',  "img":'Zeus.jpg', },
20002:{ "id":20002,  "name":'终极之汞',  "desc":'每个工人获得的金币倍数*2',  "cost":[5, 3],  "effect":'add[10001][bonus][efficiency][2.0]',  "unlock":'own[10001]5',  "img":'Hades.jpg', },
20003:{ "id":20003,  "name":'终极之硫',  "desc":'每个工人获得的金币倍数*2',  "cost":[5, 4],  "effect":'add[10001][bonus][efficiency][2.0]',  "unlock":'own[10001]25',  "img":'Hades.jpg', },
20004:{ "id":20004,  "name":'神话之盐',  "desc":'每个工人获得的金币倍数*2',  "cost":[5, 6],  "effect":'add[10001][bonus][efficiency][2.0]',  "unlock":'own[10001]50',  "img":'Hades.jpg', },
20005:{ "id":20005,  "name":'神话之汞',  "desc":'每个工人获得的金币倍数*2',  "cost":[5, 8],  "effect":'add[10001][bonus][efficiency][2.0]',  "unlock":'own[10001]100',  "img":'Hades.jpg', },
20006:{ "id":20006,  "name":'神话之硫',  "desc":'每个工人获得的金币倍数*2',  "cost":[5, 10],  "effect":'add[10001][bonus][efficiency][2.0]',  "unlock":'own[10001]150',  "img":'Hades.jpg', },
20007:{ "id":20007,  "name":'终极铁匠',  "desc":'每个工人获得的金币倍数*2',  "cost":[5, 13],  "effect":'add[10001][bonus][efficiency][2.0]',  "unlock":'own[10001]200',  "img":'Hades.jpg', },
20008:{ "id":20008,  "name":'终极铁匠',  "desc":'每个工人获得的金币倍数*2',  "cost":[5, 15],  "effect":'add[10001][bonus][efficiency][2.0]',  "unlock":'own[10001]250',  "img":'Hades.jpg', },
20009:{ "id":20009,  "name":'终极铁匠',  "desc":'每个工人获得的金币倍数*2',  "cost":[5, 18],  "effect":'add[10001][bonus][efficiency][2.0]',  "unlock":'own[10001]300',  "img":'Hades.jpg', },
20010:{ "id":20010,  "name":'终极铁匠',  "desc":'每个工人获得的金币倍数*2',  "cost":[5, 21],  "effect":'add[10001][bonus][efficiency][2.0]',  "unlock":'own[10001]350',  "img":'Hades.jpg', },
20011:{ "id":20011,  "name":'终极铁匠',  "desc":'每个工人获得的金币倍数*2',  "cost":[5, 24],  "effect":'add[10001][bonus][efficiency][2.0]',  "unlock":'own[10001]400',  "img":'Hades.jpg', },
20012:{ "id":20012,  "name":'终极铁匠',  "desc":'每个工人获得的金币倍数*2',  "cost":[5, 30],  "effect":'add[10001][bonus][efficiency][2.0]',  "unlock":'own[10001]450',  "img":'Hades.jpg', },
20013:{ "id":20013,  "name":'黄金之子',  "desc":'每个工人获得的金币倍数*2',  "cost":[5, 33],  "effect":'add[10001][bonus][efficiency][2.0]',  "unlock":'own[10001]500',  "img":'Hades.jpg', },
20014:{ "id":20014,  "name":'黄金之子',  "desc":'每个工人获得的金币倍数*2',  "cost":[5, 36],  "effect":'add[10001][bonus][efficiency][2.0]',  "unlock":'own[10001]550',  "img":'Hades.jpg', },
20015:{ "id":20015,  "name":'黄金之子',  "desc":'每个工人获得的金币倍数*2',  "cost":[5, 42],  "effect":'add[10001][bonus][efficiency][2.0]',  "unlock":'own[10001]600',  "img":'Hades.jpg', },
20016:{ "id":20016,  "name":'黄金之子',  "desc":'',  "cost":[1, 4],  "effect":'',  "unlock":'',  "img":'Hades.jpg', },
20017:{ "id":20017,  "name":'黄金之子',  "desc":'',  "cost":[5, 4],  "effect":'',  "unlock":'',  "img":'Hades.jpg', },
20018:{ "id":20018,  "name":'黄金之子',  "desc":'',  "cost":[5, 5],  "effect":'',  "unlock":'',  "img":'Hades.jpg', },
20019:{ "id":20019,  "name":'邪恶工厂主',  "desc":'',  "cost":[5, 7],  "effect":'',  "unlock":'',  "img":'Hades.jpg', },
20020:{ "id":20020,  "name":'邪恶工厂主',  "desc":'',  "cost":[5, 9],  "effect":'',  "unlock":'',  "img":'Hades.jpg', },
20021:{ "id":20021,  "name":'邪恶工厂主',  "desc":'',  "cost":[5, 11],  "effect":'',  "unlock":'',  "img":'Hades.jpg', },
20022:{ "id":20022,  "name":'邪恶工厂主',  "desc":'',  "cost":[5, 14],  "effect":'',  "unlock":'',  "img":'Hades.jpg', },
20023:{ "id":20023,  "name":'邪恶工厂主',  "desc":'',  "cost":[5, 17],  "effect":'',  "unlock":'',  "img":'Hades.jpg', },
20024:{ "id":20024,  "name":'邪恶工厂主',  "desc":'',  "cost":[5, 20],  "effect":'',  "unlock":'',  "img":'Hades.jpg', },
20025:{ "id":20025,  "name":'邪恶工厂主',  "desc":'',  "cost":[5, 23],  "effect":'',  "unlock":'',  "img":'Hades.jpg', },
20026:{ "id":20026,  "name":'邪恶工厂主',  "desc":'',  "cost":[5, 27],  "effect":'',  "unlock":'',  "img":'Hades.jpg', },
20027:{ "id":20027,  "name":'邪恶工厂主',  "desc":'',  "cost":[5, 29],  "effect":'',  "unlock":'',  "img":'Hades.jpg', },
20028:{ "id":20028,  "name":'邪恶工厂主',  "desc":'',  "cost":[5, 32],  "effect":'',  "unlock":'',  "img":'Hades.jpg', },
20029:{ "id":20029,  "name":'邪恶工厂主',  "desc":'',  "cost":[5, 35],  "effect":'',  "unlock":'',  "img":'Hades.jpg', },
20030:{ "id":20030,  "name":'邪恶工厂主',  "desc":'',  "cost":[5, 38],  "effect":'',  "unlock":'',  "img":'Hades.jpg', },

}

