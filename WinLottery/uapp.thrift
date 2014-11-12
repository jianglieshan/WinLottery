/**
 * The first thing to know about are types. The available types in Thrift are:
 *
 *  bool        Boolean, one byte
 *  byte        Signed byte
 *  i16         Signed 16-bit integer
 *  i32         Signed 32-bit integer
 *  i64         Signed 64-bit integer
 *  double      64-bit floating point value
 *  string      String
 *  binary      Blob (byte array)
 *  map<t1,t2>  Map from one type to another
 *  list<t1>    Ordered list of one type
 *  set<t1>     Set of unique elements of one type
 *
 */
namespace cpp biz.uapp.ThriftUapp
namespace java biz.uapp.ThriftUapp
namespace php biz.uapp.ThriftUapp
//接口返回结果
struct Result{
	1: i32 ret, //结果码，200成功,400-499失败，500异常
	2: string msg //说明
}
//用户信息
struct UserBean{
	1: i32 id, //用户id
	2: string name, //用户名称
	3: double allMoney, //全部资金
	4: double availableMoney, //可用资金
	5: double blockedMoney, //冻结资金
	6: i32 loginTimes, //登录次数
	7: double todayCost, //今日消费，元
	8: double todayWin, //今日中奖，元
	9: i32 score, //我的积分
	10: i32 msgNum, //我的消息数目
	11: string key //登录之后返回的验证key
}
//登录结果
struct LoginRespBean{
	1: Result result, //接口请求结果
	2: optional UserBean userBean //登录返回的用户信息
}
//验证码
struct VerifyCodeRespBean{
	1: Result result, //接口请求结果
	2: optional string imgData //验证码图片数据（base64编码的byte图片数据）
}
//新闻对象
struct NewsBean{
	1: i32 id, //新闻Id
	2: string title, //新闻标题
	3: string content, //新闻内容
	4: string url, //地址，可能为空
	5: string pic //图片地址
}

//新闻列表
struct NewsListRespBean{
	1: Result result, //接口请求结果
	2: i32 total, //总数
	3: list<NewsBean> newsList //新闻列表
}

//首页数据
struct HomeRespBean{
	1: Result result, //接口请求结果
	2: list<NewsBean> scrollNewsList, //滚动信息
	3: list<string> winsList, //中奖列表
	4: list<NewsBean> newsList //新闻列表
}

//投注明细
struct BuyBean{
	1:i32 id, //序号
	2:string expect, //彩票期号
	3:string protype, //方案类型
	4:string lotterytype, //彩票类型
	5:string lotteryid, //方案编号
	6:double mainpaymoney, //发起人购买金额
	7:double allmoney, //总金额
	8:i32 anumber, //总份数
	9:double onemoney, //每份的钱数
	10:string username, //发起人
	11:i32 hnumber, //已认购的份数
	12:double schedule, //进度
	13:string prostate, //彩票开彩状态
	14:string codes, //方案内容
	15:i32 isbaodi, //是否保底
	16:i32 baodinum, //保底份数
	17:string object, //招股对象
	18:string addtime, //添加时间
	19:i32 isreturn, //是否撤单，1撤单
	20:string wininfo, //获奖信息
	21:double wincost, //获奖金额
	22:string beishu, //倍数
	23:string mystate, //是否满员，1满员
	24:i32 allperson, //参与人数
	25:string lottery_id,//出票号
	26:string winlevels, //战绩
	27:i32 isshow, //是否开放，0开放
	28:i32 ishm, //合买代购类型，1合买
	29:string isjz, //大乐透追加号码,0否
	30:i32 isthew, //是否清保
	31:i32 tcSelect, //我要提成
	32:string caseInfo //方案说明
}

//投注明细列表
struct BuyListRespBean{
	1: Result result, //接口请求结果
	2: i32 total, //总数
	3: list<BuyBean> buyList //新闻列表
}

//开奖号码记录
struct RecordWinCode{
	1:string issue, //期号
	2:string datetime, //日期
	3:string code //开奖号码
}
//开奖号码记录列表
struct RecordWinCodeListResp{
	1: Result result, //接口请求结果
	2: i32 total, //总数
	3: list<RecordWinCode> recordList //记录列表
}

/**
 * Ahh, now onto the cool part, defining a service. Services just need a name
 * and can optionally inherit from another service using the extends keyword.
 */
service UappService {

  /**
   * A method definition looks like C code. It has a return type, arguments,
   * and optionally a list of exceptions that it may throw. Note that argument
   * lists and exception lists are specified using the exact same syntax as
   * field lists in struct or exception definitions.
   */
   
	//登录接口。loginName：登录用户名；pwd：登录密码，密文（md5(明文)）；verifyCode：登录验证码；deviceId：登录设备id；loginType：登录类型，0为Android客户端
	LoginRespBean login(1:string loginName,2:string pwd,3:string timestamp,4:string verifyCode,5:string deviceId,6:i32 loginType),
	
	//退出登录，删除鉴权的key
	Result logout(1:string key),
	
	//获取验证码接口。deviceId:设备号
	VerifyCodeRespBean getVerifyCode(1:string deviceId),
	
	//查询首页滚动新闻（含有图片的新闻），limit:查询个数
	NewsListRespBean getScrollNewsList(1:i32 limit),
	
	//分页查询新闻，page:页码，1开始；rows:每页数目，默认20
	NewsListRespBean getNewsList(1:i32 page, 2:i32 rows),
	
	//获取首页信息。deviceId:设备号
	HomeRespBean getHome(1:string deviceId),
	
	//获取用户信息.key:鉴权key
	LoginRespBean getUserInfo(1:string key),
	
	//获取投注明细列表.key:鉴权key;type:已中奖，空字符串查询全部
	BuyListRespBean getBuyList(1:string key,2:string type,3:i32 page, 4:i32 rows),
	
	//购买彩票。key:鉴权key，codes号码，jsonParams:[type：类型，双色球，大乐透，福彩3D，时时彩,beishu:倍数]
	Result doBuy(1:string key,2:string codes,3:string jsonParams),
	
	//获取最近的中奖记录.name:用户名称;rows:返回记录条数
	BuyListRespBean getWinBuyList(1:string name,2:i32 rows),
	
	//根据记录id查询购买该条记录的开奖信息
	RecordWinCodeListResp getWinCodesById(1:string id),
	
	//获取开奖记录列表，type:双色球、大乐透等
	RecordWinCodeListResp getRecordWinCodeList(1:string type)
}