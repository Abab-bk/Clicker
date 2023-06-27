# warnings-disable
extends RefCounted

var True = true
var False = false
var None = null


var data = \
{
20001:{ "id":20001,  "name":'炼金天赋',  "desc":'盐、硫、汞获得的金币和点击获得的金币是原来的 2 倍。',  "cost":[1, 3],  "effect":['click[10001][bonus][efficiency][2.0]', 'add[10001][bonus][efficiency][2.0]'],  "unlock":'own[10001]1',  "img":'Talent.png', },
20002:{ "id":20002,  "name":'黄金灵感',  "desc":'盐、硫、汞获得的金币和点击获得的金币是原来的 2 倍。',  "cost":[5, 3],  "effect":['click[10001][bonus][efficiency][2.0]', 'add[10001][bonus][efficiency][2.0]'],  "unlock":'own[10001]5',  "img":'Golden_Inspiration.png', },
20003:{ "id":20003,  "name":'天人合一',  "desc":'盐、硫、汞获得的金币和点击获得的金币是原来的 2 倍。',  "cost":[5, 4],  "effect":['click[10001][bonus][efficiency][2.0]', 'add[10001][bonus][efficiency][2.0]'],  "unlock":'own[10001]25',  "img":'Unity.png', },
20004:{ "id":20004,  "name":'终极之盐',  "desc":'盐、硫、汞获得的金币是原来的 2 倍。',  "cost":[1, 3],  "effect":['add[10001][bonus][efficiency][2.0]'],  "unlock":'own[10001]200',  "img":'Ultimate_Salt.png', },
20005:{ "id":20005,  "name":'终极之汞',  "desc":'盐、硫、汞获得的金币是原来的 2 倍。',  "cost":[5, 3],  "effect":['add[10001][bonus][efficiency][2.0]'],  "unlock":'own[10001]250',  "img":'Ultimate_Salt.png', },
20006:{ "id":20006,  "name":'终极之硫',  "desc":'盐、硫、汞获得的金币是原来的 2 倍。',  "cost":[5, 4],  "effect":['add[10001][bonus][efficiency][2.0]'],  "unlock":'own[10001]300',  "img":'Ultimate_Salt.png', },
20007:{ "id":20007,  "name":'神话之盐',  "desc":'盐、硫、汞获得的金币是原来的 2 倍。',  "cost":[5, 6],  "effect":['add[10001][bonus][efficiency][2.0]'],  "unlock":'own[10001]350',  "img":'Salt_of_Myth.png', },
20008:{ "id":20008,  "name":'神话之汞',  "desc":'盐、硫、汞获得的金币是原来的 2 倍。',  "cost":[5, 8],  "effect":['add[10001][bonus][efficiency][2.0]'],  "unlock":'own[10001]400',  "img":'Salt_of_Myth.png', },
20009:{ "id":20009,  "name":'神话之硫',  "desc":'盐、硫、汞获得的金币是原来的 2 倍。',  "cost":[5, 9],  "effect":['add[10001][bonus][efficiency][2.0]'],  "unlock":'own[10001]450',  "img":'Salt_of_Myth.png', },
20010:{ "id":20010,  "name":'铁匠大师',  "desc":'每个铁匠获得的金币是原来的 2 倍。',  "cost":[1.1, 4],  "effect":['add[10002][bonus][efficiency][2.0]'],  "unlock":'own[10001]500',  "img":'Master_Blacksmith.png', },
20011:{ "id":20011,  "name":'钻石铁匠',  "desc":'每个铁匠获得的金币是原来的 2 倍。',  "cost":[5.5, 4],  "effect":['add[10002][bonus][efficiency][2.0]'],  "unlock":'own[10001]550',  "img":'Diamond_Blacksmi.png', },
20012:{ "id":20012,  "name":'铁匠贤者',  "desc":'每个铁匠获得的金币是原来的 2 倍。',  "cost":[5.5, 5],  "effect":['add[10002][bonus][efficiency][2.0]'],  "unlock":'own[10001]600',  "img":'Master_Blacksmith.png', },
20013:{ "id":20013,  "name":'铁匠教父',  "desc":'每个铁匠获得的金币是原来的 2 倍。',  "cost":[5.5, 7],  "effect":['add[10002][bonus][efficiency][2.0]'],  "unlock":'own[10001]600',  "img":'Godfather_of_Blacksmithing.png', },
20014:{ "id":20014,  "name":'天国铁匠',  "desc":'每个铁匠获得的金币是原来的 2 倍。',  "cost":[5.5, 9],  "effect":['add[10002][bonus][efficiency][2.0]'],  "unlock":'own[10001]600',  "img":'Godfather_of_Blacksmithing.png', },
20015:{ "id":20015,  "name":'暗物质铁匠',  "desc":'每个铁匠获得的金币是原来的 2 倍。',  "cost":[5.5, 11],  "effect":['add[10002][bonus][efficiency][2.0]'],  "unlock":'own[10001]600',  "img":'Master_Blacksmith.png', },
20016:{ "id":20016,  "name":'黄金之子',  "desc":'每个炼金术士获得的金币是原来的 2 倍。',  "cost":[2, 8],  "effect":['add[10003][bonus][efficiency][2.0]'],  "unlock":'own[10001]600',  "img":'Son_of_Gold.png', },
20017:{ "id":20017,  "name":'白金圣手',  "desc":'每个炼金术士获得的金币是原来的 2 倍。',  "cost":[1, 9],  "effect":['add[10003][bonus][efficiency][2.0]'],  "unlock":'own[10001]600',  "img":'Son_of_Gold.png', },
20018:{ "id":20018,  "name":'炼金教父',  "desc":'每个炼金术士获得的金币是原来的 2 倍。',  "cost":[1, 10],  "effect":['add[10003][bonus][efficiency][2.0]'],  "unlock":'own[10001]600',  "img":'GodfatherAlchemy.png', },
20019:{ "id":20019,  "name":'奇迹贤者',  "desc":'每个炼金术士获得的金币是原来的 2 倍。',  "cost":[1, 12],  "effect":['add[10003][bonus][efficiency][2.0]'],  "unlock":'own[10001]600',  "img":'GodfatherAlchemy.png', },
20020:{ "id":20020,  "name":'天国侍者',  "desc":'每个炼金术士获得的金币是原来的 2 倍。',  "cost":[1, 14],  "effect":['add[10003][bonus][efficiency][2.0]'],  "unlock":'own[10001]600',  "img":'Cosmic_Tutor.png', },
20021:{ "id":20021,  "name":'宇宙导师',  "desc":'每个炼金术士获得的金币是原来的 2 倍。',  "cost":[1, 16],  "effect":['add[10003][bonus][efficiency][2.0]'],  "unlock":'own[10001]600',  "img":'Cosmic_Tutor.png', },
20022:{ "id":20022,  "name":'炙热硫磺',  "desc":'每个炼金锅获得的金币是原来的 2 倍。',  "cost":[1.2, 5],  "effect":['add[10004][bonus][efficiency][2.0]'],  "unlock":'own[10001]600',  "img":'Pot.png', },
20023:{ "id":20023,  "name":'沙漠之釜',  "desc":'每个炼金锅获得的金币是原来的 2 倍。',  "cost":[6, 5],  "effect":['add[10004][bonus][efficiency][2.0]'],  "unlock":'own[10001]602',  "img":'Pot.png', },
20024:{ "id":20024,  "name":'爆裂熔岩',  "desc":'每个炼金锅获得的金币是原来的 2 倍。',  "cost":[6, 6],  "effect":['add[10004][bonus][efficiency][2.0]'],  "unlock":'own[10001]603',  "img":'Pot.png', },
20025:{ "id":20025,  "name":'黄金之子',  "desc":'每个炼金锅获得的金币是原来的 2 倍。',  "cost":[6, 8],  "effect":['add[10004][bonus][efficiency][2.0]'],  "unlock":'own[10001]604',  "img":'Pot.png', },
20026:{ "id":20026,  "name":'暗物质锅',  "desc":'每个炼金锅获得的金币是原来的 2 倍。',  "cost":[6, 10],  "effect":['add[10004][bonus][efficiency][2.0]'],  "unlock":'own[10001]605',  "img":'Pot.png', },
20027:{ "id":20027,  "name":'宇宙魔锅',  "desc":'每个炼金锅获得的金币是原来的 2 倍。',  "cost":[6, 12],  "effect":['add[10004][bonus][efficiency][2.0]'],  "unlock":'own[10001]606',  "img":'Pot.png', },

}

