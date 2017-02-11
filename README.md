本项目使用 署名-非商业性使用-禁止演绎 CC BY-NC-ND 协议开源，
[![Creative Commons License](https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png)](https://creativecommons.org/licenses/by-nc-nd/4.0/)  
This work is licensed under a [Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License](https://creativecommons.org/licenses/by-nc-nd/4.0/).

![点此捐助6.60元](https://raw.githubusercontent.com/vokins/yhosts/master/donate/660.png)

[点此捐助19.80元](https://raw.githubusercontent.com/vokins/yhosts/master/donate/198.png)

[点此捐助521.00元](https://raw.githubusercontent.com/vokins/yhosts/master/donate/521.png)

# yhosts
`
主观 简洁 任性
`
   的
hosts文件


### 特色：

```javascript
* 基于站点和APP进行记录，如果影响了任何功能，可以暂时禁用相关域名或者APP数据解决。
```
* AD hosts爱好群：201973909

* ios 使用这个视频去广告PAC：https://vokins.github.io/ad.js/ad.js

### 数据名称及含义:
1. [hosts.txt](https://raw.githubusercontent.com/vokins/yhosts/master/hosts.txt) 是基础数据，其他数据需叠加此数据使用。仅使用此数据，可过滤掉测试链接1 内的广告，无法过滤 测试连接2 内的广告。电脑PC用户务必用这个源，不要用3的源！！！
2. [tvbox.txt](https://raw.githubusercontent.com/vokins/yhosts/master/tvbox.txt) 是附加数据，针对电视平台，更好的过滤一些APP的广告。如果家里面有多个可支持hosts过滤的路由器，可在主路由器部署hosts.txt并将此数据部署到客厅盒子的路由上。
3. [hosts](https://raw.githubusercontent.com/vokins/yhosts/master/hosts)是完整数据，可用于路由器平台（方便iPad等设备无广告浏览）。包含hosts.txt和tvbox.txt，并删除所有注释行，方便路由器添加和更新。
4. [site部分](https://github.com/vokins/yhosts/wiki/%E6%95%B0%E6%8D%AE%E8%AF%A6%E7%BB%86%E8%AF%B4%E6%98%8E)是站点具体数据，点击此链接查看具体站点详情。

### 反馈请看：
* 如果你用了本hosts文件，还是有广告，请你截图说明具体那里有广告？
* 并尽可能多的提供以下信息：
* 1.网页上的广告请帖上具体网址；
* 2.APP广告请告知APP名称以及下载地址和APP具体版本，请务必告知重现广告的具体步骤！
* 3.请告知操作平台：是PC还是安卓或者iOS？
* 4.请告知运营商是联通，电信、移动、长城宽带或是其他？
* 5.请就您遇到的广告截图并进行标注。
* 安卓系统更新完hosts后请注意改对权限，相关软件需要清除数据或者清理缓存并清理掉后台再重新打开APP，部分机器需要开关一次飞行模式或者重启手机。

#### 测试链接1:
* [乐视网-芈月传](http://www.letv.com/ptv/vplay/24371048.html)
* [PPTV聚力-新萧十一郎](http://v.pptv.com/show/4atBviaaMicDqdGibc.html)
* [优酷网-欢乐喜剧人](http://v.youku.com/v_show/id_XMTQ2MjA5MzE5Ng==.html)
* [芒果TV-天天有喜](http://www.mgtv.com/v/2/166072/f/2949223.html)
* [华数TV-大V时代](http://www.wasu.cn/Play/show/id/2037963)
* [暴风影音-天伦](http://www.baofeng.com/play/463/play-796463.html)
* [电影网1905-墓穴迷城](http://www.1905.com/vod/play/969015.shtml)
* [响巢看看-嫂子嫂子](http://vod.kankan.com/v/90/90518.shtml)
* 可以屏蔽掉[Alexa](http://www.alexa.com/topsites/countries/CN)排名前300的网站的绝大部分广告

#### 测试链接2:
* [搜狐视频-DoctorX](http://tv.sohu.com/20140326/n397234225.shtml)
* [腾讯视频-美丽的秘密](http://v.qq.com/cover/5/5fs2bn3beyv0rbo/r00192d3ruz.html)
* [爱奇艺-全城热恋](http://www.iqiyi.com/v_19rrl6p15k.html)

#### 测试APP:
1. 腾讯视频、爱奇艺PPS、PPTV、土豆视频、快看影视、芒果TV、风行视频、万能影视、快手看片、乐视体育、直播吧、央视影音、风云直播、天天直播；
2. 西瓜影音、1905电影网（无广告，但有读秒黑屏）

#### MIUI广告清理:
* MIUI安全中心，MIUI天气，MIUI下载APP请到设置，其他应用管理，里面找到：安全中心服务组件，安全中心，垃圾清理，天气，下载，分别点击清除数据，操作后重新打开即可。
* MIUI桌面，文件夹应用推荐广告请手动关闭。
* MIUI日历，请使用卡片管理。
* MIUI视频，播放器下方仍有广告。
* MIUI搜索，提示框，多点几次刷新后，仍会有应用标注推广字样。

###如何应对运营商插入的广告:
1.运营商告知缴费信息不在下列讨论范围。
* 如果遇到运营商强插广告，或者流量劫持，网页跳转（百度搜索劫持，网页导航劫持，美团，淘宝，京东等闪一下或者刷新一下）。可以使用下面的应对手段：
* 1.使用https协议。
* 2.使用自己的返利链接购买，比如自己申请淘宝联盟，集分宝等，网上有推荐的的商品先加入购物车，再自己从淘宝联盟的购物车里面购买。其他订单可使用返利网等类似网站。
* 3.记录跳转范例的uid或者utm码。可在各网站广告部反馈此代码投诉，会查封其违规收入。
* 4.拨打运营商客服电话进行投诉。直接告知要进行投诉处理.要求客服记录，并承诺回复时限。并告知如果在时限内未能解决的，将进行升级投诉，比如给工信部发邮件等。
* 5.如果以上都未能解决您的问题，需要进行升级投诉。在[工信部网站](http://www.chinatcc.gov.cn:8080/cms/shensus/)填写相应内容即可。
* 一般到第三步你告知客服，如果还未解决进行升级投诉的时候，就应该很快会解决了。
* 如果有问题请补充。我会继续修改。

##### 优秀的Google hosts: [racaljk](https://raw.githubusercontent.com/racaljk/hosts/master/hosts)  [盒子](http://www.360kb.com/kb/7_150.html) [laod](http://laod.cn/hosts/2016-google-hosts.html) 

##### 游戏加速:[lucky☆star](http://bbs.a9vg.com/thread-4549081-1-1.html)

##### 软件后台下载:[zsm2014](http://bbs.kafan.cn/thread-1798022-1-1.html)

##### 恶意网站: [MWSL](http://www.mwsl.org.cn/hosts/hosts)

##### 国外Ping工具: [ca.com](https://asm.ca.com/zh_cn/ping.php) [netsh.org](http://serve.netsh.org/pub/ping.php) [pingdom.com](http://tools.pingdom.com/ping/) [ping.eu](http://ping.eu/ping)

##### 国内Ping工具: [17ce.com](http://www.17ce.com/site/ping) [ipip.net](http://www.ipip.net/ping.php)

##### 运行库: [dos2unix](http://sourceforge.net/projects/dos2unix/) [exe](http://www.bathome.net/thread-36408-1-1.html)

##### 优秀软件推荐: [AkelPad](http://akelpad.sf.net/) QQ群：290230398

##### 特别感谢：ESword https://www.esword.cn/

##### osx hosts管理软件：https://github.com/oldj/SwitchHosts/releases
