# warnings-disable
extends RefCounted

var True = true
var False = false
var None = null


var data = \
{
20001:{ "id":20001,  "name":'炼金天赋',  "desc":'盐、硫、汞获得的金币和点击获得的金币是原来的 2 倍。',  "cost":[1, 3],  "effect":['click[10001][bonus][efficiency][2.0]', 'add[10001][bonus][efficiency][2.0]'],  "last":'',  "img":'Talent.png', },
20002:{ "id":20002,  "name":'黄金灵感',  "desc":'盐、硫、汞获得的金币和点击获得的金币是原来的 2 倍。',  "cost":[5, 3],  "effect":['click[10001][bonus][efficiency][2.0]', 'add[10001][bonus][efficiency][2.0]'],  "last":'20001.0',  "img":'Golden_Inspiration.png', },
20003:{ "id":20003,  "name":'天人合一',  "desc":'盐、硫、汞获得的金币和点击获得的金币是原来的 2 倍。',  "cost":[5, 4],  "effect":['click[10001][bonus][efficiency][2.0]', 'add[10001][bonus][efficiency][2.0]'],  "last":'20002.0',  "img":'Unity.png', },
20004:{ "id":20004,  "name":'终极之盐',  "desc":'盐、硫、汞获得的金币是原来的 2 倍。',  "cost":[1, 3],  "effect":['add[10001][bonus][efficiency][2.0]'],  "last":'',  "img":'Ultimate_Salt.png', },
20005:{ "id":20005,  "name":'终极之汞',  "desc":'盐、硫、汞获得的金币是原来的 2 倍。',  "cost":[5, 3],  "effect":['add[10001][bonus][efficiency][2.0]'],  "last":'20004.0',  "img":'Ultimate_Salt.png', },
20006:{ "id":20006,  "name":'终极之硫',  "desc":'盐、硫、汞获得的金币是原来的 2 倍。',  "cost":[5, 4],  "effect":['add[10001][bonus][efficiency][2.0]'],  "last":'20005.0',  "img":'Ultimate_Salt.png', },
20007:{ "id":20007,  "name":'神话之盐',  "desc":'盐、硫、汞获得的金币是原来的 2 倍。',  "cost":[5, 6],  "effect":['add[10001][bonus][efficiency][2.0]'],  "last":'20006.0',  "img":'Salt_of_Myth.png', },
20008:{ "id":20008,  "name":'神话之汞',  "desc":'盐、硫、汞获得的金币是原来的 2 倍。',  "cost":[5, 8],  "effect":['add[10001][bonus][efficiency][2.0]'],  "last":'20007.0',  "img":'Salt_of_Myth.png', },
20009:{ "id":20009,  "name":'神话之硫',  "desc":'盐、硫、汞获得的金币是原来的 2 倍。',  "cost":[5, 9],  "effect":['add[10001][bonus][efficiency][2.0]'],  "last":'20008.0',  "img":'Salt_of_Myth.png', },
20010:{ "id":20010,  "name":'铁匠大师',  "desc":'每个铁匠获得的金币是原来的 2 倍。',  "cost":[1.1, 4],  "effect":['add[10002][bonus][efficiency][2.0]'],  "last":'',  "img":'Master_Blacksmith.png', },
20011:{ "id":20011,  "name":'钻石铁匠',  "desc":'每个铁匠获得的金币是原来的 2 倍。',  "cost":[5.5, 4],  "effect":['add[10002][bonus][efficiency][2.0]'],  "last":'20010.0',  "img":'Diamond_Blacksmi.png', },
20012:{ "id":20012,  "name":'铁匠贤者',  "desc":'每个铁匠获得的金币是原来的 2 倍。',  "cost":[5.5, 5],  "effect":['add[10002][bonus][efficiency][2.0]'],  "last":'20011.0',  "img":'Master_Blacksmith.png', },
20013:{ "id":20013,  "name":'铁匠教父',  "desc":'每个铁匠获得的金币是原来的 2 倍。',  "cost":[5.5, 7],  "effect":['add[10002][bonus][efficiency][2.0]'],  "last":'20012.0',  "img":'Godfather_of_Blacksmithing.png', },
20014:{ "id":20014,  "name":'天国铁匠',  "desc":'每个铁匠获得的金币是原来的 2 倍。',  "cost":[5.5, 9],  "effect":['add[10002][bonus][efficiency][2.0]'],  "last":'20013.0',  "img":'Godfather_of_Blacksmithing.png', },
20015:{ "id":20015,  "name":'暗物质铁匠',  "desc":'每个铁匠获得的金币是原来的 2 倍。',  "cost":[5.5, 11],  "effect":['add[10002][bonus][efficiency][2.0]'],  "last":'20014.0',  "img":'Master_Blacksmith.png', },
20016:{ "id":20016,  "name":'黄金之子',  "desc":'每个炼金术士获得的金币是原来的 2 倍。',  "cost":[2, 8],  "effect":['add[10003][bonus][efficiency][2.0]'],  "last":'',  "img":'Son_of_Gold.png', },
20017:{ "id":20017,  "name":'白金圣手',  "desc":'每个炼金术士获得的金币是原来的 2 倍。',  "cost":[1, 9],  "effect":['add[10003][bonus][efficiency][2.0]'],  "last":'20016.0',  "img":'Son_of_Gold.png', },
20018:{ "id":20018,  "name":'炼金教父',  "desc":'每个炼金术士获得的金币是原来的 2 倍。',  "cost":[1, 10],  "effect":['add[10003][bonus][efficiency][2.0]'],  "last":'20017.0',  "img":'GodfatherAlchemy.png', },
20019:{ "id":20019,  "name":'奇迹贤者',  "desc":'每个炼金术士获得的金币是原来的 2 倍。',  "cost":[1, 12],  "effect":['add[10003][bonus][efficiency][2.0]'],  "last":'20018.0',  "img":'GodfatherAlchemy.png', },
20020:{ "id":20020,  "name":'天国侍者',  "desc":'每个炼金术士获得的金币是原来的 2 倍。',  "cost":[1, 14],  "effect":['add[10003][bonus][efficiency][2.0]'],  "last":'20019.0',  "img":'Cosmic_Tutor.png', },
20021:{ "id":20021,  "name":'宇宙导师',  "desc":'每个炼金术士获得的金币是原来的 2 倍。',  "cost":[1, 16],  "effect":['add[10003][bonus][efficiency][2.0]'],  "last":'20020.0',  "img":'Cosmic_Tutor.png', },
20022:{ "id":20022,  "name":'炙热硫磺',  "desc":'每个炼金锅获得的金币是原来的 2 倍。',  "cost":[1.2, 5],  "effect":['add[10004][bonus][efficiency][2.0]'],  "last":'',  "img":'Pot.png', },
20023:{ "id":20023,  "name":'沙漠之釜',  "desc":'每个炼金锅获得的金币是原来的 2 倍。',  "cost":[6, 5],  "effect":['add[10004][bonus][efficiency][2.0]'],  "last":'20022.0',  "img":'Pot.png', },
20024:{ "id":20024,  "name":'爆裂熔岩',  "desc":'每个炼金锅获得的金币是原来的 2 倍。',  "cost":[6, 6],  "effect":['add[10004][bonus][efficiency][2.0]'],  "last":'20023.0',  "img":'Pot.png', },
20025:{ "id":20025,  "name":'黄金之子',  "desc":'每个炼金锅获得的金币是原来的 2 倍。',  "cost":[6, 8],  "effect":['add[10004][bonus][efficiency][2.0]'],  "last":'20024.0',  "img":'Pot.png', },
20026:{ "id":20026,  "name":'暗物质锅',  "desc":'每个炼金锅获得的金币是原来的 2 倍。',  "cost":[6, 10],  "effect":['add[10004][bonus][efficiency][2.0]'],  "last":'20025.0',  "img":'Pot.png', },
20027:{ "id":20027,  "name":'宇宙魔锅',  "desc":'每个炼金锅获得的金币是原来的 2 倍。',  "cost":[6, 12],  "effect":['add[10004][bonus][efficiency][2.0]'],  "last":'20026.0',  "img":'Pot.png', },
20028:{ "id":20028,  "name":'钢铁之心',  "desc":'每个炼金石磨获得的金币是原来的 2 倍。',  "cost":[1.3, 6],  "effect":['add[10005][bonus][efficiency][2.0]'],  "last":'',  "img":'StoneMill.png', },
20029:{ "id":20029,  "name":'荆棘之心',  "desc":'每个炼金石磨获得的金币是原来的 2 倍。',  "cost":[6.5, 6],  "effect":['add[10005][bonus][efficiency][2.0]'],  "last":'20027.0',  "img":'StoneMill.png', },
20030:{ "id":20030,  "name":'原子之心',  "desc":'每个炼金石磨获得的金币是原来的 2 倍。',  "cost":[6.5, 7],  "effect":['add[10005][bonus][efficiency][2.0]'],  "last":'20028.0',  "img":'StoneMill.png', },
20031:{ "id":20031,  "name":'星辰之心',  "desc":'每个炼金石磨获得的金币是原来的 2 倍。',  "cost":[6.5, 9],  "effect":['add[10005][bonus][efficiency][2.0]'],  "last":'20029.0',  "img":'StoneMill.png', },
20032:{ "id":20032,  "name":'转基因石磨',  "desc":'每个炼金石磨获得的金币是原来的 2 倍。',  "cost":[6.5, 11],  "effect":['add[10005][bonus][efficiency][2.0]'],  "last":'20030.0',  "img":'StoneMill.png', },
20033:{ "id":20033,  "name":'宇宙粉碎机',  "desc":'每个炼金石磨获得的金币是原来的 2 倍。',  "cost":[6.5, 13],  "effect":['add[10005][bonus][efficiency][2.0]'],  "last":'20031.0',  "img":'StoneMill.png', },
20034:{ "id":20034,  "name":'红黑树堆栈',  "desc":'每个炼成阵获得的金币是原来的 2 倍。',  "cost":[1.4, 7],  "effect":['add[10006][bonus][efficiency][2.0]'],  "last":'',  "img":'Formation.png', },
20035:{ "id":20035,  "name":'罗素茶壶',  "desc":'每个炼成阵获得的金币是原来的 2 倍。',  "cost":[7, 7],  "effect":['add[10006][bonus][efficiency][2.0]'],  "last":'20034.0',  "img":'Formation.png', },
20036:{ "id":20036,  "name":'犹昧感',  "desc":'每个炼成阵获得的金币是原来的 2 倍。',  "cost":[7, 8],  "effect":['add[10006][bonus][efficiency][2.0]'],  "last":'20035.0',  "img":'Formation.png', },
20037:{ "id":20037,  "name":'不定拓扑',  "desc":'每个炼成阵获得的金币是原来的 2 倍。',  "cost":[7, 10],  "effect":['add[10006][bonus][efficiency][2.0]'],  "last":'20036.0',  "img":'Formation.png', },
20038:{ "id":20038,  "name":'相位同调',  "desc":'每个炼成阵获得的金币是原来的 2 倍。',  "cost":[7, 12],  "effect":['add[10006][bonus][efficiency][2.0]'],  "last":'20037.0',  "img":'Formation.png', },
20039:{ "id":20039,  "name":'相位空间',  "desc":'每个炼成阵获得的金币是原来的 2 倍。',  "cost":[7, 14],  "effect":['add[10006][bonus][efficiency][2.0]'],  "last":'20038.0',  "img":'Formation.png', },
20040:{ "id":20040,  "name":'拉格朗日',  "desc":'每个红宝石获得的金币是原来的 2 倍。',  "cost":[2, 8],  "effect":['add[10007][bonus][efficiency][2.0]'],  "last":'',  "img":'Rudy.png', },
20041:{ "id":20041,  "name":'语义饱和',  "desc":'每个红宝石获得的金币是原来的 2 倍。',  "cost":[1, 9],  "effect":['add[10007][bonus][efficiency][2.0]'],  "last":'20040.0',  "img":'Rudy.png', },
20042:{ "id":20042,  "name":'泊松括号',  "desc":'每个红宝石获得的金币是原来的 2 倍。',  "cost":[1, 10],  "effect":['add[10007][bonus][efficiency][2.0]'],  "last":'20041.0',  "img":'Rudy.png', },
20043:{ "id":20043,  "name":'离散链',  "desc":'每个红宝石获得的金币是原来的 2 倍。',  "cost":[1, 12],  "effect":['add[10007][bonus][efficiency][2.0]'],  "last":'20042.0',  "img":'Rudy.png', },
20044:{ "id":20044,  "name":'仿射联络',  "desc":'每个红宝石获得的金币是原来的 2 倍。',  "cost":[1, 14],  "effect":['add[10007][bonus][efficiency][2.0]'],  "last":'20043.0',  "img":'Rudy.png', },
20045:{ "id":20045,  "name":'你的眼睛',  "desc":'你的眼睛，澄澈如水晶。',  "cost":[1, 16],  "effect":['add[10007][bonus][efficiency][2.0]'],  "last":'20044.0',  "img":'Rudy.png', },
20046:{ "id":20046,  "name":'光荣孤立',  "desc":'每个王水获得的金币是原来的 2 倍。',  "cost":[3.3, 9],  "effect":['add[10008][bonus][efficiency][2.0]'],  "last":'',  "img":'KingWater.png', },
20047:{ "id":20047,  "name":'挠率张量',  "desc":'每个王水获得的金币是原来的 2 倍。',  "cost":[1.6, 10],  "effect":['add[10008][bonus][efficiency][2.0]'],  "last":'20046.0',  "img":'KingWater.png', },
20048:{ "id":20048,  "name":'爱丁顿光度',  "desc":'每个王水获得的金币是原来的 2 倍。',  "cost":[1.6, 11],  "effect":['add[10008][bonus][efficiency][2.0]'],  "last":'20047.0',  "img":'KingWater.png', },
20049:{ "id":20049,  "name":'布里渊区',  "desc":'每个王水获得的金币是原来的 2 倍。',  "cost":[1.6, 16],  "effect":['add[10008][bonus][efficiency][2.0]'],  "last":'20048.0',  "img":'KingWater.png', },
20050:{ "id":20050,  "name":'远足算子',  "desc":'每个王水获得的金币是原来的 2 倍。',  "cost":[1.6, 18],  "effect":['add[10008][bonus][efficiency][2.0]'],  "last":'20049.0',  "img":'KingWater.png', },
20051:{ "id":20051,  "name":'本场连续',  "desc":'每个王水获得的金币是原来的 2 倍。',  "cost":[1.6, 22],  "effect":['add[10008][bonus][efficiency][2.0]'],  "last":'20050.0',  "img":'KingWater.png', },
20052:{ "id":20052,  "name":'冬眠合剂',  "desc":'每个长生露获得的金币是原来的 2 倍。',  "cost":[5.1, 10],  "effect":['add[10009][bonus][efficiency][2.0]'],  "last":'',  "img":'Dew.png', },
20053:{ "id":20053,  "name":'生态位',  "desc":'每个长生露获得的金币是原来的 2 倍。',  "cost":[2.5, 11],  "effect":['add[10009][bonus][efficiency][2.0]'],  "last":'20052.0',  "img":'Dew.png', },
20054:{ "id":20054,  "name":'假想观众',  "desc":'每个长生露获得的金币是原来的 2 倍。',  "cost":[2.5, 14],  "effect":['add[10009][bonus][efficiency][2.0]'],  "last":'20053.0',  "img":'Dew.png', },
20055:{ "id":20055,  "name":'个人神话',  "desc":'每个长生露获得的金币是原来的 2 倍。',  "cost":[2.5, 16],  "effect":['add[10009][bonus][efficiency][2.0]'],  "last":'20054.0',  "img":'Dew.png', },
20056:{ "id":20056,  "name":'角度追逐',  "desc":'每个长生露获得的金币是原来的 2 倍。',  "cost":[2.5, 18],  "effect":['add[10009][bonus][efficiency][2.0]'],  "last":'20055.0',  "img":'Dew.png', },
20057:{ "id":20057,  "name":'等同索赔',  "desc":'每个长生露获得的金币是原来的 2 倍。',  "cost":[2.5, 21],  "effect":['add[10009][bonus][efficiency][2.0]'],  "last":'20056.0',  "img":'Dew.png', },
20058:{ "id":20058,  "name":'退化案例',  "desc":'每个五芒星获得的金币是原来的 2 倍。',  "cost":[7.5, 11],  "effect":['add[10010][bonus][efficiency][2.0]'],  "last":'',  "img":'Pentagram.png', },
20059:{ "id":20059,  "name":'假面舞会',  "desc":'每个五芒星获得的金币是原来的 2 倍。',  "cost":[3.7, 12],  "effect":['add[10010][bonus][efficiency][2.0]'],  "last":'20058.0',  "img":'Pentagram.png', },
20060:{ "id":20060,  "name":'霍曼转移',  "desc":'每个五芒星获得的金币是原来的 2 倍。',  "cost":[3.7, 13],  "effect":['add[10010][bonus][efficiency][2.0]'],  "last":'20059.0',  "img":'Pentagram.png', },
20061:{ "id":20061,  "name":'自伴算符',  "desc":'每个五芒星获得的金币是原来的 2 倍。',  "cost":[3.7, 15],  "effect":['add[10010][bonus][efficiency][2.0]'],  "last":'20060.0',  "img":'Pentagram.png', },
20062:{ "id":20062,  "name":'格式塔主义',  "desc":'每个五芒星获得的金币是原来的 2 倍。',  "cost":[3.7, 17],  "effect":['add[10010][bonus][efficiency][2.0]'],  "last":'20061.0',  "img":'Pentagram.png', },
20063:{ "id":20063,  "name":'单身复叶',  "desc":'每个五芒星获得的金币是原来的 2 倍。',  "cost":[3.7, 20],  "effect":['add[10010][bonus][efficiency][2.0]'],  "last":'20062.0',  "img":'Pentagram.png', },
20064:{ "id":20064,  "name":'沉默的螺旋',  "desc":'每个太阳获得的金币是原来的 2 倍。',  "cost":[1, 13],  "effect":['add[10011][bonus][efficiency][2.0]'],  "last":'',  "img":'Sun.png', },
20065:{ "id":20065,  "name":'下降行动',  "desc":'每个太阳获得的金币是原来的 2 倍。',  "cost":[5, 13],  "effect":['add[10011][bonus][efficiency][2.0]'],  "last":'20064.0',  "img":'Sun.png', },
20066:{ "id":20066,  "name":'基尼系数',  "desc":'每个太阳获得的金币是原来的 2 倍。',  "cost":[5, 14],  "effect":['add[10011][bonus][efficiency][2.0]'],  "last":'20065.0',  "img":'Sun.png', },
20067:{ "id":20067,  "name":'芒阿粒子',  "desc":'每个太阳获得的金币是原来的 2 倍。',  "cost":[5, 16],  "effect":['add[10011][bonus][efficiency][2.0]'],  "last":'20066.0',  "img":'Sun.png', },
20068:{ "id":20068,  "name":'波动率微笑',  "desc":'每个太阳获得的金币是原来的 2 倍。',  "cost":[5, 18],  "effect":['add[10011][bonus][efficiency][2.0]'],  "last":'20067.0',  "img":'Sun.png', },
20069:{ "id":20069,  "name":'波动率皱眉',  "desc":'每个太阳获得的金币是原来的 2 倍。',  "cost":[5, 19],  "effect":['add[10011][bonus][efficiency][2.0]'],  "last":'20068.0',  "img":'Sun.png', },
20070:{ "id":20070,  "name":'无知之幕',  "desc":'每个月亮获得的金币是原来的 2 倍。',  "cost":[1.4, 14],  "effect":['add[10012][bonus][efficiency][2.0]'],  "last":'',  "img":'Moon.png', },
20071:{ "id":20071,  "name":'卷积神经',  "desc":'每个月亮获得的金币是原来的 2 倍。',  "cost":[7, 15],  "effect":['add[10012][bonus][efficiency][2.0]'],  "last":'20070.0',  "img":'Moon.png', },
20072:{ "id":20072,  "name":'外泌体',  "desc":'每个月亮获得的金币是原来的 2 倍。',  "cost":[7, 17],  "effect":['add[10012][bonus][efficiency][2.0]'],  "last":'20071.0',  "img":'Moon.png', },
20073:{ "id":20073,  "name":'亚临界萃取',  "desc":'每个月亮获得的金币是原来的 2 倍。',  "cost":[7, 19],  "effect":['add[10012][bonus][efficiency][2.0]'],  "last":'20072.0',  "img":'Moon.png', },
20074:{ "id":20074,  "name":'时分多址',  "desc":'每个月亮获得的金币是原来的 2 倍。',  "cost":[7, 21],  "effect":['add[10012][bonus][efficiency][2.0]'],  "last":'20073.0',  "img":'Moon.png', },
20075:{ "id":20075,  "name":'三驾马车',  "desc":'每个月亮获得的金币是原来的 2 倍。',  "cost":[7, 24],  "effect":['add[10012][bonus][efficiency][2.0]'],  "last":'20074.0',  "img":'Moon.png', },

}

