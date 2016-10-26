/*************************************************
* version=上午 7:26 2016/10/27 星期四            *
* fork=https://github.com/MikeWang000000/ad.js   *
* http://bbs.feng.com/read-htm-tid-10180969.html *
* https://github.com/fulicat/hosts.pac           *
*                                                *
*************************************************/

function FindProxyForURL(url, host){

    /********************************************
    *                                           *
    *            关于 “mode = ” 的说明        *
    *                                           *
    *  0: 不使用代理 (仅屏蔽广告)               *
    *  1: 使用http代理 (请在下方设置服务器和端口)    *
    *  2: 使用pac规则代理 (使用方法请看文件底部注释)  *
    *                                           *
    ********************************************/

    var mode = 0;

    //【以下http代理设置仅在 “mode = 1” 时有效】
    var domain = "127.0.0.1";
    var port = "8080";
    var hosts = [
//=========域名Start=========
//<ad.js_test>
"sc.cdce.cf",
//<youku>
"ad.api.3g.youku.com",
"statis.api.3g.youku.com",
"atm.youku.com",
"stat.youku.com",
//<sohu>
"agn.aty.sohu.com",
"mmg.aty.sohu.com",
//<letv>
"n.mark.letv.com",
"ark.letv.com",
"irs01.com",
//<baofeng>
"xs.houyi.baofeng.net",
//<hunantv>
"da.hunantv.com",
"miaozhen.com",
//<qq>
"lives.l.qq.com",
"vqq.admaster.com.cn",
//<tudou>
"ad.api.3g.tudou.com",
//<pptv>
"de.as.pptv.com",
"pp2.pptv.com",
"stat.pptv.com",
"afp.pplive.com",
//<iqiyi>
"cm.passport.iqiyi.com",
"cupid.iqiyi.com",
"paopao.iqiyi.com",
"ckm.iqiyi.com",
//<google>
"2mdn.net",
"admob.com",
"doubleclick.com",
"doubleclick.net",
"googleadsserving.cn",
"googlecommerce.com",
"googletagmanager.com",
"ads.google.com",
"afd.l.google.com",
"pagead-tpc.l.google.com",
"pagead.google.com",
"pagead.l.google.com",
"partnerad.l.google.com",
//<baidu>
"hm.baidu.com",
"eiv.baidu.com",
"pos.baidu.com",
"cpro.baidu.com",
"cpro.baidustatic.com",
"dup.baidustatic.com",
"cbjs.baidu.com",
//<taobao>
"tanx.com",
"alimama.com",
//<360>
"lianmeng.360.cn",
//<others>
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

/**********************************************
*                                             *
*            使用pac规则代理的方法               *
*                                             *
*  1. 设置“mode = 2”。                         *
*  2. 打开pac文件，将里面的“FindProxyForURL”替换  *
*     为“FindUserProxyForURL“后粘贴在下方即可。  *
*                                             *
**********************************************/
