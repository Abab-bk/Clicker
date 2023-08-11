# warnings-disable
extends RefCounted

var True = true
var False = false
var None = null


var data = \
{
60001:{ "id":60001,  "name":'黄金梦想',  "bonus":'click[10001][bonus][efficiency][1.1]',  "desc":'点击获得金币+0.1倍',  "img":'', },
60002:{ "id":60002,  "name":'精酿小麦酒',  "bonus":'add[10002][bonus][efficiency][1.1]',  "desc":'铁匠很喜欢喝。每个铁匠获得的金币 +0.1 倍。',  "img":'', },
60003:{ "id":60003,  "name":'科学世界',  "bonus":'reduce[10002][coins][efficiency][800000]',  "desc":'炼金术士认为这本书和他的价值观不符，工作效率降低。-800000金币。',  "img":'', },
60004:{ "id":60004,  "name":'地中海的气候',  "bonus":'add[10003][bonus][efficiency][1.1]',  "desc":'炼金术士认为有时候也要享受一下。炼金术士获得金币 +0.1 倍。',  "img":'', },
60005:{ "id":60005,  "name":'第二个酒吧',  "bonus":'add[10004][bonus][efficiency][1.1]',  "desc":'炼金石磨听音乐的时候，身体会颤抖。炼金石磨获得金币 +0.1倍。',  "img":'', },
60006:{ "id":60006,  "name":'PhoneProject2',  "bonus":'add[10005][bonus][efficiency][1.1]',  "desc":'炼成阵听音乐的时候，身体会颤抖。炼成阵获得金币 +0.1倍。',  "img":'', },
60007:{ "id":60007,  "name":'Rudy',  "bonus":'add[10006][bonus][efficiency][1.1]',  "desc":'红宝石找到了它异父异母的兄弟。Puts "Hey"。红宝石获得金币 +0.1 倍。',  "img":'', },
60008:{ "id":60008,  "name":'神秘药剂',  "bonus":'coins[10002][bonus][efficiency][900000]',  "desc":'“抛开剂量谈毒性就是耍流氓” 金币 +900000。',  "img":'', },
60009:{ "id":60009,  "name":'神秘药剂',  "bonus":'reduce[10002][coins][efficiency][900000]',  "desc":'“抛开剂量谈毒性就是耍流氓” 金币 -900000。',  "img":'', },
60010:{ "id":60010,  "name":'化学家',  "bonus":'coins[10002][bonus][efficiency][7777777]',  "desc":'炼金术士认为化学家拙略的模仿他们。+7777777金币。',  "img":'', },
60011:{ "id":60011,  "name":'六神水',  "bonus":'add[10008][bonus][efficiency][1.1]',  "desc":'炼金术士往里面加入了六种材料，取名六神。王水获得金币 +0.1 倍。',  "img":'', },
60012:{ "id":60012,  "name":'天堂制造',  "bonus":'add[10018][bonus][efficiency][1.1]',  "desc":'炼金术士偶然结识一位神父，神父教他制作这瓶药剂。天国阶梯获得金币 +0.1 倍。',  "img":'', },
60013:{ "id":60013,  "name":'幸运鸡蛋派',  "bonus":'nothing[10018][bonus][efficiency][1.1]',  "desc":'战斗中，吃一口可以获得某些加成，但是战斗系统还没做好。',  "img":'', },
60014:{ "id":60014,  "name":'独角兽泪水',  "bonus":'click[30][time][efficiency][5]',  "desc":'尝起来类似酸酸乳。每秒点击金币变为 5 倍，持续30秒。',  "img":'', },
60015:{ "id":60015,  "name":'龙蛋清酒',  "bonus":'click[20][time][efficiency][6]',  "desc":'喝下去感觉可以挑战整个世界。每秒点击变为 6 倍，持续 20 秒。',  "img":'', },
60016:{ "id":60016,  "name":'猫头鹰眼泪酒',  "bonus":'add[10009][bonus][efficiency][1.1]',  "desc":'喝下去会对老鼠产生渴望。长生露获得金币 +0.1倍。',  "img":'', },
60017:{ "id":60017,  "name":'彩虹舌头蜥蜴',  "bonus":'add[100010][bonus][efficiency][1.1]',  "desc":'传说这种蜥蜴拥有点石成金的能力，不过实测只有点石成泡泡的实力。五芒星获得金币 +0.1倍。',  "img":'', },
60018:{ "id":60018,  "name":'Wabby Wabbo',  "bonus":'click[77][time][efficiency][7]',  "desc":'are you good MyRiXYa! 每秒点击变为 7 倍，持续 77 秒。',  "img":'', },
60019:{ "id":60019,  "name":'幸运太阳荷包',  "bonus":'add[10011][bonus][efficiency][1.1]',  "desc":'戴上它，永远不会走霉运。太阳获得金币 +0.1 倍。',  "img":'', },
60020:{ "id":60020,  "name":'双吐司月亮戒指',  "bonus":'add[10012][bonus][efficiency][1.1]',  "desc":'戴上它，永远不会烤熟吐司。月亮获得金币 +0.1 倍。',  "img":'', },
60021:{ "id":60021,  "name":'象牙塔',  "bonus":'add[10013][bonus][efficiency][1.1]',  "desc":'象牙塔，是指象牙做的塔。黄金之塔获得金币 +0.1 倍。',  "img":'', },
60022:{ "id":60022,  "name":'魔术师',  "bonus":'add[10014][bonus][efficiency][1.1]',  "desc":'炼金术士最新的爱好。卡巴拉之术获得金币 +0.1 倍。',  "img":'', },
60023:{ "id":60023,  "name":'星星',  "bonus":'add[10015][bonus][efficiency][1.1]',  "desc":'我也想送一颗星星给你。星锑获得金币 +0.1 倍。',  "img":'', },
60024:{ "id":60024,  "name":'餐杯',  "bonus":'add[10016][bonus][efficiency][1.1]',  "desc":'耶稣使用过的餐杯。圣杯获得金币 +0.1 倍。',  "img":'', },
60025:{ "id":60025,  "name":'哲人石',  "bonus":'add[10017][bonus][efficiency][1.1]',  "desc":'雕刻成了苏格拉底的模样。贤者之石获得金币 +0.1 倍。',  "img":'', },
60026:{ "id":60026,  "name":'新星漂移',  "bonus":'add[10019][bonus][efficiency][1.1]',  "desc":'星星也可以移动。暗物质星系获得金币 +0.1 倍。',  "img":'', },
60027:{ "id":60027,  "name":'幻想世界',  "bonus":'add[10020][bonus][efficiency][1.1]',  "desc":'另一个世界。平行宇宙获得金币 +0.1 倍。',  "img":'', },
60028:{ "id":60028,  "name":'遐思',  "bonus":'add[10001][bonus][efficiency][1.1]',  "desc":'盐、硫、汞获得金币 +0.1 倍。',  "img":'', },
60029:{ "id":60029,  "name":'逃脱大师',  "bonus":'click[50][time][efficiency][50]',  "desc":'据说他之前也是炼金术士。每秒点击变为50倍，持续50秒。',  "img":'', },

}

