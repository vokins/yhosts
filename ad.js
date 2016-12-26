/*
     
*/

function FindProxyForURL(url, host){

    /****************************************************
    *							*
    *            关于 “mode = ” 的说明			*
    *							*
    *  0: 不使用代理 (仅屏蔽广告)				*
    *  1: 使用http代理 (请在下方设置服务器和端口)		*
    *  2: 使用pac规则代理 (使用方法请看文件底部注释)	*
    *							*
    ****************************************************/

    var mode = 0;

    //【以下http代理设置仅在 “mode = 1” 时有效】
    var domain = "127.0.0.1";
    var port = "8080";

    var hosts = [
//=========域名Start=========
//<ad.js_test>
"sc.cdce.cf",
//<360>
"lianmeng.360.cn",
//<ali-cdn>
"asearch.alicdn.com",
"atanx.alicdn.com",
"atanx2.alicdn.com",
"strip.taobaocdn.com",
//<ali-mama>
"alimama.cn",
"cnzz.com",
"mmstat.com",
"tanx.com",
//<baidu>
"baidustatic.com",
"bzclk.baidu.com",
"cbjs.baidu.com",
"cpro.baidu.com",
"eclick.baidu.com",
"eiv.baidu.com",
"entry.baidu.com",
"hm.baidu.com",
"nsclick.baidu.com",
"pos.baidu.com",
"share.baidu.com",
//<google>
"2mdn.net",
"doubleclick.net",
"googleadsserving.cn",
"googletagmanager.com",
"googlesyndication.com",
"googleadservices.com",
"googletagservices.com",
//<jd>
"x.jd.com",
//<qq>
"ta.qq.com",
"tajs.qq.com",
//<sohu>
"images.sohu.com",
"inte.sogou.com",
"brand.sogou.com",
//<v>
"admaster.com.cn",
"biddingx.com",
"criteo.net",
"gridsum.com",
"gridsumdissector.cn",
"gridsumdissector.com",
"ipinyou.com",
"irs01.com",
"kejet.net",
"miaozhen.com",
"reachmax.cn",
"revsci.net",
"scorecardresearch.com",
"wrating.com",
//<v-baofeng>
"logger.baofeng.com",
"houyi.baofeng.net",
//<v-hunantv>
"da.hunantv.com",
"log.hunantv.com",
//<v-kankan>
"biz5.sandai.net",
"float.sandai.net",
"logic.cpm.cm.sandai.net",
"biz5.kankan.com",
"cm.kankan.com",
"float.kankan.com",
"kkpgv.kankan.com",
"kkpgv2.kankan.com",
"kkpgv2.xunlei.com",
"material.ssp.xunlei.com",     
//<v-iqiyi>
"cupid.ptqy.gitv.tv",
"msg.71.am",
"cupid.iqiyi.com",
"cupid.qiyi.com",
"msg.iqiyi.com",
//<v-letv>
"api.mob.app.letv.com", 
"ark.letv.com",
"fz.letv.com",
"g3.letv.com",
"msg.m.letv.com",
//<v-pptv>
"asimgs.pplive.cn",
"ads.aplus.pptv.com",
"ads.aplusapi.pptv.com",
"de.as.pptv.com",
"imagecache.g.pptv.com",
"static.g.pptv.com",
"tj.g.pptv.com",
"asimgs.cp61.ott.cibntv.net",
"de.as.cp61.ott.cibntv.net",   
//<v-qq>
"aiseet.atianqi.com",
"l.qq.com",
//<v-sohu>
"aty.sohu.com",
"stat.v-56.com",
//<v-youku>
"atm.cp31.ott.cibntv.net",
"ad.api.3g.tudou.com",
"ad.api.3g.youku.com",
"ad.api.mobile.youku.com",
"atm.youku.com",
"b.smartvideo.youku.com",
"dev-push.m.youku.com",
"dl.g.youku.com",
"gamex.mobile.youku.com",
"guanggaoad.youku.com",
"hudong.pl.youku.com",
"lstat.youku.com",
"mobilemsg.youku.com",
"passport-log.youku.com",
"push.m.youku.com",
"wan.youku.com",
"yes.youku.com",
"e.stat.ykimg.com",
"p-log.ykimg.com",
"themis.ykimg.com",
//<m-itunes-radio>
"iadctest.qwapi.com",
//<m-qingting.fm>
"ad.qingting.fm",
"admgr.qingting.fm",
"dload.qd.qingting.fm",
"logger.qingting.fm",
"s.qd.qingting.fm",
"s.qd.qingtingfm.com",
//<m-ximalaya>
"ad.test.ximalaya.com",
"ad.ximalaya.com",
"adse.test.ximalaya.com",
"adse.ximalaya.com",
"adweb.test.ximalaya.com",
"adweb.ximalaya.com",
//<others>
"keydot.net",
"b.cdnny.com"
//=========域名End=========
//【在分界线上面可以追加域名，两边加上双引号，使用逗号分隔。】
    ]
    var ips = [
//=========IP地址Start=========
//<iqiyi>
"101.227.14.80",
"101.227.14.81",
"101.227.14.82",
"101.227.14.83",
"101.227.14.84",
"101.227.14.85",
"101.227.14.86"
//=========IP地址End=========
//【在分界线上面可以追加IP地址，两边加上双引号，使用逗号分隔。】
    ]
    var rules = [
//【iOS 9.3.2 以上的系统由于系统限制，无法享受URL规则功能。】
//=========URL规则Start=========
"*pg.dmclock.com:8011/ec54.html*",
"*cc/js/ads/*",
"*config.mobile.kukuplay.com:8080/MobileConfig*"
//=========URL规则End=========
//【在分界线上面可以追加URL规则，两边加上双引号，使用逗号分隔。】
    ]

    dnsResolve("sc.cdce.cf");
    var IS_AD = "PROXY example.com:443";
    switch (mode){
      case 0:
          IS_NOT_AD = "DIRECT";
          break;
      case 1:
          IS_NOT_AD = "PROXY " + domain + ":" + port;
          break;
      case 2:
          IS_NOT_AD = FindUserProxyForURL(url, host);
          break;
    }
    for (var n = 0; n < hosts.length; n++){
        if (dnsDomainIs(host, hosts[n])){
            return IS_AD;
        }
    }
    for (var n = 0; n < ips.length; n++){
        if (isInNet(host, ips[n], "225.225.225.225")){
            return IS_AD;
        }
    }
    for (var n = 0; n < rules.length; n++){
        if (shExpMatch(url, rules[n])){
            return IS_AD;
        }
    }
    return IS_NOT_AD;
}

/************************************************
*						*
*            使用pac规则代理的方法		*
*						*
*  1. 设置“mode = 2”。				*
*  2. 打开pac文件，将里面的“FindProxyForURL”	*
*     替换为“FindUserProxyForURL“后  		*
*     粘贴在下方即可。				*
************************************************/
