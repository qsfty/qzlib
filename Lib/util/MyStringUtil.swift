//
// Created by 李和 on 2021/8/5.
//

import Foundation
import CommonCrypto

extension String {

    public func slice(begin: Int, end: Int) -> String {
        var str = self
        var _end = end
        let beginIndex = str.index(str.startIndex, offsetBy: begin)
        if(end < 0){
            _end = str.count + end
        }
        if(_end > str.count){
            _end = str.count
        }
        let endIndex = str.index(str.startIndex, offsetBy: _end)
        if(begin > _end){
            return ""
        }
        return String(str[beginIndex..<endIndex])
    }

    public func slice(begin: Int, len: Int) -> String {
        self.slice(begin: begin, end: begin + len)
    }

    public func slice(begin: Int) -> String {
        self.slice(begin: begin, end: self.count)
    }

    public func toInt() -> Int {
        guard let x = Int(self) else {
            return -1
        }
        return x
    }

    public func toDouble() -> Double {
        guard let x = Double(self) else {
            return -1
        }
        return x
    }

    public func rand(_ len: Int) -> String {
        var str="abcdefghijklmnopqrstuvwxyz1234567890"
        var finalStr = ""
        for index in 1...len {
            let i = randomNum(0, str.count)
            finalStr += str.slice(begin: i,end: i+1)
        }
        return finalStr
    }

    public func oneLine() -> String {
        self.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
    }


//    public func sha1() -> String{
//        let data = Data(self.utf8)
//        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
//        data.withUnsafeBytes {
//            _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
//        }
//        let hexBytes = digest.map { String(format: "%02hhx", $0) }
//        return hexBytes.joined()
//    }

    public func md5() -> String{
        if let strData = self.data(using: String.Encoding.utf8) {
            var digest = [UInt8](repeating: 0, count:Int(CC_MD5_DIGEST_LENGTH))
            strData.withUnsafeBytes {
                CC_MD5($0.baseAddress, UInt32(strData.count), &digest)
            }
            let hexBytes = digest.map { String(format: "%02hhx", $0) }
            return hexBytes.joined()
        }
        return ""
    }




}





let firstNames = "赵,钱,孙,李,周,吴,郑,王,冯,陈,褚,卫,蒋,沈,韩,杨,朱,秦,尤,许,何,吕,施,张,孔,曹,严,华,金,魏,陶,姜,戚,谢,邹,喻,柏,水,窦,章,云,苏,潘,葛,奚,范,彭,郎,鲁,韦,昌,马,苗,凤,花,方,俞,任,袁,柳,酆,鲍,史,唐,费,廉,岑,薛,雷,贺,倪,汤,滕,殷,罗,毕,郝,邬,安,常,乐,于,时,傅,皮,卞,齐,康,伍,余,元,卜,顾,孟,平,黄,和,穆,萧,尹,姚,邵,湛,汪,祁,毛,禹,狄,米,贝,明,臧,计,伏,成,戴,谈,宋,茅,庞,熊,纪,舒,屈,项,祝,董,梁,杜,阮,蓝,闵,席,季,麻,强,贾,路,娄,危,江,童,颜,郭,梅,盛,林,刁,钟,徐,邱,骆,高,夏,蔡,田,樊,胡,凌,霍,虞,万,支,柯,昝,管,卢,莫,经,房,裘,缪,干,解,应,宗,丁,宣,贲,邓,郁,单,杭,洪,包,诸,左,石,崔,吉,钮,龚,程,嵇,邢,滑,裴,陆,荣,翁,荀,羊,於,惠,甄,麴,家,封,芮,羿,储,靳,汲,邴,糜,松,井,段,富,巫,乌,焦,巴,弓,牧,隗,山,谷,车,侯,宓,蓬,全,郗,班,仰,秋,仲,伊,宫,宁,仇,栾,暴,甘,钭,厉,戎,祖,武,符,刘,景,詹,束,龙,叶,幸,司,韶,郜,黎,蓟,薄,印,宿,白,怀,蒲,邰,从,鄂,索,咸,籍,赖,卓,蔺,屠,蒙,池,乔,阴,欎,胥,能,苍,双,闻,莘,党,翟,谭,贡,劳,逄,姬,申,扶,堵,冉,宰,郦,雍,舄,璩,桑,桂,濮,牛,寿,通,边,扈,燕,冀,郏,浦,尚,农,温,别,庄,晏,柴,瞿,阎,充,慕,连,茹,习,宦,艾,鱼,容,向,古,易,慎,戈,廖,庾,终,暨,居,衡,步,都,耿,满,弘,匡,国,文,寇,广,禄,阙,东,殴,殳,沃,利,蔚,越,夔,隆,师,巩,厍,聂,晁,勾,敖,融,冷,訾,辛,阚,那,简,饶,空,曾,毋,沙,乜,养,鞠,须,丰,巢,关,蒯,相,查,後,荆,红,游,竺,权,逯,盖,益,桓,公,司马,上官,欧阳,夏侯,诸葛,东方,皇甫,尉迟,澹台,濮阳,淳于,单于,申屠,公孙,仲孙,轩辕,令狐,钟离,宇文,长孙,慕容,司徒,仉,督,晋,楚,闫,法,汝,鄢,涂,钦,归,海,岳,帅,缑,亢,况,后,有,琴,商,牟,佘,佴,伯,赏,南宫,墨,哈,谯,笪,年,爱,阳,佟,言,福,百,家,姓,终".split(separator: ",")
let secondNames = "丽颖,启菁,娉婷,婷,娉,梓发,冠英,辉煌,萍,新萍,莉颖,小萍,沛雯,丽,抒萍,书萍,昭欣,坊,舒萍,坊颖,嘉城,淑萍,姝萍,慕雪,双秆,斌,琳,炯泽,林,玲,林颖,昀泽,建刚,鹏,菁,徊,琳颖,丹,今颖,娜,金颖,金泽,世斌,丽茵,思禅,世安,勇,思霖,洪义,钰,亚倩,亚潞,英顺,世敏,磊,珍,炎,秀英,宏涛,建华,世海,友彬,世民,昭,金玲,青,密,广文,姝静,政,学慧,旭东,政斌,卓俊,菊英,俊卓,婧妍,豫卓,卓豫,国庆,铮辉,建东,杰,宇珊,鑫宇,彤运,光耀,靖霜,素,精东,景,善福,锋,钢,福娃,彦彬,毅,松林,延霞,湘,晓菁,浩然,馨,琦,常彬,傲霜,荣成,彦霏,世杰,振华,涛,嘉迎,婉,飞,鑫华,娟娟,正娟,妍,哲华,雅丹,亚丹,谓林,家莲,华英,利坚,昊洋,娅瑜,泽轩,玥,平,奥,璐,潇月,企骉,润洲,英健,忠清,国峰,羿膊,欣,彦霖,国华,峰,君茹,沅芯,娉钰,文军,兆晨,禧旺,洁凝,道平,宗睿,梦宇,青龙,火滚,雅晴,雅清,悦凯,鹦,泽郡,光,梦雨,孟雨,奇骏,红梅,天赐,健英,嘉诚,辰旭,存委,英伟,存伟,存维,森森,多帏,存帏,佳冉,清然,抒綝,品军,俊桦,昌,寅然,泽然,子涵,德林,良,汉阳,莉,高玮,洪岩,虹,侠,泽楷,骏,曲萍,会,佳,佳燕,佳恩,文宏,沿秉,汶柄,小龙,晗翀,东,树林,蕊圻,娟,爱芬,海洋,洪波,星河,堇圻,素芬,晗畅,天阳,钊凝,晗曦,蓉,思霏,圣欣,俊辉,思欣,晗松,梦冰,宜轩,舜,光敏,松岭,英法,锁云,君,一蓓,超,晓艳,明璋,雷蕾,奕桥,婷婷,映雪,君华,玮庭,育煊,芊雨,彦君,新宇,佳颖,雪瑶,海嫣,海妍,梦璐,海艳,松岂,禹彤,晓敏,海滟,晓华,治,诗薇,万忠,梓杭,海谚,祖碧,梓珩,文鑫,心悦,海研,雨瞳,铭,宜霖,子杭,柏林,昊颖,松研,心露,菲,子娟,雨彤,梓牧,思涵,建,海焰,箭,宇涵,枚璇,宇彤,剑,明烜,健,海琰,思琪,润辉,晗译,攀,金玉,函聪,忻纯,妍儒,伟书,淑燕,艾悦,晗凯,佳敏,子林,晗恺,相锋,佳怡,晗楷,艾学,卓璇,敏,晗杰,正瀚,海荣,浩冉,泽霖,如军,蕙彤,光辉,茹君,雨倩,昊昱,一帆,如君,丝语,立,京霖,焕荣,雅丽,伟英,静涵,佳艺,封赋,巧丽,莲丽,淑洪,莲莉,欣妍,雨涵,晔,洁莹,小秀,冬莉,竹芸,跃莉,棓林,冰洁,旭莉,晗浩,新莉,娇枝,佳松,辉,晗豪,盈赋,欣洋,洁盈,果,金霏,利,芸轩,进珍,果果,大鹏,金霖,志林,香伶,京霏,佳星,晗笛,琪麟,彦丽,晗帝,鑫,方琳,芸菲,京瀚,紫淳,晗俊,燕,忠梅,凡雅,云菲,京翰,婷月,芸飞,韵飞,廷芬,韵菲,肇琪,永菊,吟霜,伟倩,锁京,曼霖,酝菲,欣遥,欣欣,彩虹,韵斐,明洁,昀遥,景璇,亘宇,冰琦,薇婷,韵蜚,想,南,岁峰,欣毅,韵翡,宜航,慧帅,云翡,蕴翡,钲苹,香霆,亮,福训,林永,利鹏,玉珍,艾桦,静波,丽鹏,玉华,卜少,翔,泽林,彩云,宗翰,江霞,择霖,析岩,帅帅,蔓莉,良豪,金辉,明,析研,勋,俊峰,卓超,欣懋,洋,松灵,澜,盛霖,惠敏,文豪,松领,岚,晋荣,岚澜,紫茗,澜岚,岚岚,欣语,振国,昕岚,永平,慧,裕,肃,慧聪,石英,芷涵,凌洁,昱岚,承祖,世达,香霖,岚昱,婧绫,维华,仕达,诗蕴,威,永刚,浩,晓京,利利,亦睛,景玉,岚雅,雅岚,翌柠,娅,奕涵,利芬,志兰,海江,佳泉,强,良芬,黧岚,黧,诗逸,坐,怡然,晓菲,亦心,长庚,美珍,宁娟,楚涵,宇春,双,毅雄,钦烨,昌富,芯涵,德梅,春兰,宛玉,天月,会英,宏进,禹墨,育佳,存邦,晗荣,兰旖,兰一,兰二,芳萍,兰三,永春,清芸,茂字,兰四,义峰,兰五,晗融,庶峰,皓辰,烨钦,晗溶,瑗,泽辰,万元,姝含,志东,昭轩,白,义锋,志刚,若凡,烨鑫,晓燕,兰七,柯欣,首辰,树梅,昱晨,华照,柯泓,咏恩,松润,钦烁,心淦,颐,鑫语,烁钦,建民,长生,卓妍,荣刚,少平,新玲,依航,望,圆圆,兰九,兰十,兴林,俊辰,前进,佳文,冬梅,怡,云飞,佳雯,松洋,佳欣,兴宇,洪来,文萱,响,盈莹,桢熙,佳红,沪娟,柯庆,昕芮,仪,华娟,佳玥".split(separator: ",")


public func randName() -> String {
    let r = randomNum(firstNames.count)
    let p = randomNum(secondNames.count)
    return "\(firstNames[r])\(secondNames[p])"
}

let CHINESE_MATCH: String = "(^[\\u4e00-\\u9fa5]$)"
public func isChinese(_ str: String) -> Bool {
    let predicate = NSPredicate(format: "SELF matches %@", CHINESE_MATCH)
    return predicate.evaluate(with: str)
}
let NUMBER_MATCH: String = "(^[0-9]$)"
public func isNumber(_ str: String) -> Bool {
    let predicate = NSPredicate(format: "SELF matches %@", NUMBER_MATCH)
    return predicate.evaluate(with: str)
}

let WORD_MATCH: String = "(^[a-wA-Z]$)"
public func isWord(_ str: String) -> Bool {
    let predicate = NSPredicate(format: "SELF matches %@", WORD_MATCH)
    return predicate.evaluate(with: str)
}

public func isBlank(_ str: String) -> Bool {
    str == "" || str == " " || str == "\n" || str == "\\c"
}


public func getCharacterType(_ c: Character, strict: Bool = false, specialWord: String = "") -> Int {
    if(strict){
        return getStrictWordType(String(c))
    }
    return getWordType(String(c), specialWord: specialWord)
}

public func getStrictWordType(_ str: String) -> Int {
    if isBlank(str) {
        return 0
    }
    if isWord(str)  {
        return 1
    }
    if isNumber(str) {
        return 2
    }
    if isChinese(str) {
        return 3
    }
    return 4
}


public func getWordType(_ str: String, specialWord: String) -> Int {
    if isBlank(str) {
        return 0
    }
    if isWord(str) || isNumber(str) || isChinese(str) || specialWord.contains(str)  {
        return 1
    }
    return 4
}



extension String {
    public func urlEncode() -> String {
        let customAllowedSet = NSCharacterSet(charactersIn:"!*'();:@&=+$,/?%#[]").inverted
        return self.addingPercentEncoding(withAllowedCharacters: customAllowedSet)!
    }

    public func urlEncode2() -> String {
        let customAllowedSet = NSCharacterSet(charactersIn:"!*'\"();:@&=+$,/?%#[]{}").inverted
        return self.addingPercentEncoding(withAllowedCharacters: customAllowedSet)!
    }

    public func urlQueryEncode() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}

