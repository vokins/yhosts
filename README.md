# yhosts
克制 准确 
优雅 简洁
   的
hosts文件

# 特色：
* 基于站点和APP进行记录，如果影响了任何功能，可以暂时禁用相关域名或者APP数据解决。
* 可以屏蔽掉[Alexa](http://www.alexa.com/topsites/countries/CN)排名前300的网站的绝大部分广告

# 特别感谢：
* ESword bt-soso.com 提供国内http镜像（同步更新）
* Windows平台：http://code.taobao.org/svn/yhosts/pc.txt
* Android平台：http://code.taobao.org/svn/yhosts/hosts.txt
* 路由器平台：http://code.taobao.org/svn/yhosts/hosts

# 各种数据文件的名称及含义:
1. [pc.txt] (https://raw.githubusercontent.com/vokins/yhosts/master/pc.txt) 针对桌面平台。为基础数据，其他平台数据需配合此数据使用。
2. [mobile.txt](https://raw.githubusercontent.com/vokins/yhosts/master/mobile.txt) 针对移动平台
3. [tvbox.txt](https://raw.githubusercontent.com/vokins/yhosts/master/tvbox.txt) 针对电视平台
4. [hosts.txt](https://raw.githubusercontent.com/vokins/yhosts/master/hosts.txt) 针对手机平台（iOS，Android）。已经合并了1.2两项数据，并使用unix换行符，方便手机用户添加。
5. [hosts](https://raw.githubusercontent.com/vokins/yhosts/master/hosts) 针对路由器平台。包含tvbox.txt但为了整体兼容性并未包含mobile.txt，并删除所有注释行，方便路由器添加和更新。

# 测试链接1:
[墓穴迷城 电影网1905](http://www.1905.com/vod/play/969015.shtml)
[芈月传 乐视网](http://www.letv.com/ptv/vplay/24371048.html)
[嫂子嫂子 响巢看看](http://vod.kankan.com/v/90/90518.shtml)
[新萧十一郎 PPTV聚力](http://v.pptv.com/show/4atBviaaMicDqdGibc.html)
[欢乐喜剧人 优酷网](http://v.youku.com/v_show/id_XMTQ2MjA5MzE5Ng==.html)
[天天有喜 芒果TV](http://www.mgtv.com/v/2/166072/f/2949223.html)
[大V时代 华数TV](http://www.wasu.cn/Play/show/id/2037963)
[天伦 暴风影音](http://www.baofeng.com/play/463/play-796463.html)

# 测试链接2:
[DoctorX 搜狐视频](http://tv.sohu.com/20140326/n397234225.shtml)
[美丽的秘密 腾讯视频](http://v.qq.com/cover/5/5fs2bn3beyv0rbo/r00192d3ruz.html)
[全城热恋 爱奇艺](http://www.iqiyi.com/v_19rrl6p15k.html)

# 测试APP:
1. 腾讯视频、爱奇艺PPS、PPTV、土豆视频、快看影视、芒果TV、风行视频、万能影视、快手看片、乐视体育、直播吧、央视影音、风云直播、天天直播；
2. 西瓜影音、1905电影网（无广告，但有读秒黑屏）

#MIUI:
MIUI安全中心请到设置，其他应用管理，里面找到：安全中心服务组件，安全中心，垃圾清理，分别点击清除数据，操作后重新打开即可。
MIUI天气，下载，应用hosts数据后无需操作。
MIUI桌面，文件夹应用推荐广告请手动关闭。
MIUI日历，请使用卡片管理。
MIUI视频，播放器下方仍有广告。
MIUI搜索，提示框，多点几次刷新后，仍会有应用标注推广字样。

#如何应对运营商插入的广告:
1.运营商告知缴费信息不在下列讨论范围。
2.如果遇到运营商强插广告，或者流量劫持，网页跳转（百度搜索劫持，网页导航劫持，美团，淘宝，京东等闪一下或者刷新一下）。可以使用下面的应对手段：
2-1.使用https协议。
2-2.使用自己的返利链接购买，比如自己申请淘宝联盟，集分宝等，网上有推荐的的商品先加入购物车，再自己从淘宝联盟的购物车里面购买。其他订单可使用返利网等类似网站。
2-2.记录跳转范例的uid或者utm码。可在各网站广告部反馈此代码投诉，会查封其违规收入。
2-3.拨打运营商客服电话进行投诉。直接告知要进行投诉处理.要求客服记录，并承诺回复时限。并告知如果在时限内未能解决的，将进行升级投诉，比如给工信部发邮件等。
3.如果以上都未能解决您的问题，需要进行升级投诉。在工信部网站填写相应内容即可。http://www.chinatcc.gov.cn:8080/cms/shensus/
4.一般到第三步你告知客服，如果还未解决进行升级投诉的时候，一般就很快解决了。
5.如果有问题请补充。我会继续修改。

# 优秀的Google hosts:
1. [racaljk] (https://raw.githubusercontent.com/racaljk/hosts/master/hosts)
2. [盒子] (http://www.360kb.com/kb/2_122.html) [facebook] (http://www.360kb.com/kb/2_139.html)
3. [laod] (http://laod.cn/hosts/2016-google-hosts.html)
4. [乱炖] (http://levi.yii.so/hosts)
5. [txthinking] (https://raw.githubusercontent.com/txthinking/google-hosts/master/hosts)

# 游戏加速:
1. [lucky☆star] (http://bbs.a9vg.com/thread-4549081-1-1.html)

# 软件后台下载:
1. [zsm2014] (http://bbs.kafan.cn/thread-1798022-1-1.html)

# 路由器hosts:
[dd-wrt](http://code.taobao.org/svn/dd-wrt/hosts)
[gargoyle](http://code.taobao.org/svn/gargoyle/hosts)

# 恶意网站:
[MWSL](http://www.mwsl.org.cn/hosts/hosts)

# 国外Ping工具:
[ca.com](https://asm.ca.com/zh_cn/ping.php)
[netsh.org](http://serve.netsh.org/pub/ping.php)
[pingdom.com](http://tools.pingdom.com/ping/)
[ping.eu](http://ping.eu/ping)

# 国内Ping工具:
[17ce.com](http://www.17ce.com/site/ping)
[ipip.net](http://www.ipip.net/ping.php)

# 运行库:
[dos2unix] (http://sourceforge.net/projects/dos2unix/)
[exe] (http://www.bathome.net/thread-36408-1-1.html)

# 优秀软件推荐:
[AkelPad] (http://akelpad.sf.net/)
