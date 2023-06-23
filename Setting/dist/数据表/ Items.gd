# warnings-disable
extends RefCounted

var True = true
var False = false
var None = null


var data = \
{
10001:{ "id":10001,  "name":'盐、硫、汞',  "desc":'“有盐，才有味！”',  "cost":[15, 0],  "bonus":[1, -1],  "img":'Spell.png', },
10002:{ "id":10002,  "name":'铁匠',  "desc":'铸造专家...炼金也要打铁吗？',  "cost":[1, 2],  "bonus":[1, 0],  "img":'Head1.png', },
10003:{ "id":10003,  "name":'炼金术士',  "desc":'半路出家的化学家，梦想是用微笑换取黄金。',  "cost":[11, 2],  "bonus":[8, 0],  "img":'Head2.png', },
10004:{ "id":10004,  "name":'炼金锅',  "desc":'相比炼金，炖菜的时间显然更多。',  "cost":[12, 3],  "bonus":[47, 0],  "img":'Pentagram.png', },
10005:{ "id":10005,  "name":'炼金石磨',  "desc":'黄金粉末，还是咖啡？',  "cost":[13, 4],  "bonus":[26, 1],  "img":'StoneMill.png', },
10006:{ "id":10006,  "name":'炼成阵',  "desc":'古老而神秘的阵法，请勿践踏。',  "cost":[14, 5],  "bonus":[14, 2],  "img":'Formation.png', },
10007:{ "id":10007,  "name":'红宝石',  "desc":'火之高兴！可以送给心爱的人。',  "cost":[2, 7],  "bonus":[78, 2],  "img":'Rudy.png', },
10008:{ "id":10008,  "name":'王水',  "desc":'炼金术士曾把它装进水枪，融化了水枪。',  "cost":[33, 8],  "bonus":[44, 3],  "img":'KingWater.png', },
10009:{ "id":10009,  "name":'长生露',  "desc":'显然，炼金术士很高兴。',  "cost":[51, 9],  "bonus":[26, 4],  "img":'Dew.png', },
10010:{ "id":10010,  "name":'五芒星',  "desc":'千万不要画错…容易引起灾祸…',  "cost":[75, 10],  "bonus":[16, 6],  "img":'Pentagram.png', },
10011:{ "id":10011,  "name":'太阳',  "desc":'炙热之阳！',  "cost":[1, 12],  "bonus":[1, 7],  "img":'Sun.png', },
10012:{ "id":10012,  "name":'月亮',  "desc":'哀霜之月。',  "cost":[14, 13],  "bonus":[65, 6],  "img":'Moon.png', },
10013:{ "id":10013,  "name":'黄金之塔',  "desc":'很显然，炼金术士的黄金梦实现了…',  "cost":[17, 15],  "bonus":[43, 8],  "img":'Tower.png', },
10014:{ "id":10014,  "name":'卡巴拉之术',  "desc":'卡巴拉之术是宇宙的符号化表现。',  "cost":[21, 16],  "bonus":[29, 9],  "img":'King.png', },
10015:{ "id":10015,  "name":'星锑',  "desc":'外太空的神秘矿石，被炼金术士召唤到这里。',  "cost":[26, 17],  "bonus":[21, 10],  "img":'Crystal.png', },
10016:{ "id":10016,  "name":'圣杯',  "desc":'喝下圣水，永葆青春。',  "cost":[31, 18],  "bonus":[15, 11],  "img":'Holy.png', },
10017:{ "id":10017,  "name":'贤者之石',  "desc":'大奇迹！炼金术的终极目标。',  "cost":[71, 20],  "bonus":[11, 12],  "img":'Stone.png', },
10018:{ "id":10018,  "name":'天国阶梯',  "desc":'贤者之石不是终结，神秘的阶梯之后还有更为广阔的世界。',  "cost":[12, 22],  "bonus":[83, 11],  "img":'HeavenWay.png', },
10019:{ "id":10019,  "name":'暗物质星系',  "desc":'神秘莫测的星系。',  "cost":[19, 24],  "bonus":[64, 13],  "img":'Dark.png', },
10020:{ "id":10020,  "name":'平行宇宙',  "desc":'在天国阶梯背后，神秘星系背后，隐藏着另一个宇宙。',  "cost":[54, 27],  "bonus":[51, 14],  "img":'Antimatter.png', },

}

