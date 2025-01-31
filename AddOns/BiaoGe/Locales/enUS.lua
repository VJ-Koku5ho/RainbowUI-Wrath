local AddonName, ADDONSELF = ...

if (GetLocale() ~= "enUS") then return end

local L = setmetatable({}, {
    __index = function(table, key)
        table[key] = tostring(key)
        return tostring(key)
    end,
})

do
    L["< BiaoGe > 金 团 表 格"] = "< BiaoGe > Raid Table"
    L["<说明书与更新记录> "] = "<Instruction and Update Logs>"
    L["保存至历史表格"] = "Save to History Table"
    L["该表格已在你历史表格里"] = "This table is already in your history table"
    L["历史表格（共%d个）"] = "History Table (Total %d)"
    L["已保存至历史表格1"] = "Saved to History Table 1"
    L["设置"] = "Settings"
    L["当前难度:"] = "Current Difficulty:"
    L["切换副本难度"] = "Switch Raid Difficulty"
    L["10人|cff00BFFF普通|r"] = "10-player |cff00BFFFNormal|r"
    L["25人|cff00BFFF普通|r"] = "25-player |cff00BFFFNormal|r"
    L["10人|cffFF0000英雄|r"] = "10-player |cffFF0000Heroic|r"
    L["25人|cffFF0000英雄|r"] = "25-player |cffFF0000Heroic|r"
    L["确认切换难度为< %s >？"] = "Confirm to switch to difficulty < %s >?"
    L["是"] = "Yes"
    L["否"] = "No"
    L["心愿清单"] = "Wish List"
    L["清空当前表格"] = "Clear Current Table"
    L["关闭心愿清单"] = "Close Wish List"
    L["清空当前心愿"] = "Clear Current Wish"
    L["对账"] = "Account"
    L["关闭对账"] = "Close Account"
    L["要清空表格< %s >吗？"] = "Do you want to clear the table < %s >?"
    L["角色"] = "Character"
    L["黑龙"] = "Black Dragon"
    L["宝库"] = "Vault"
    L["赛德精华"] = "Residuum"
    L["金币"] = "Gold"
    L["< 角色团本完成总览 >"] = "< Character Raid Completion Overview >"
    L["（团本重置时间：%s）"] = "(Raid Reset Time: %s)"
    L["当前没有符合的角色"] = "No matching characters"
    L["（右键删除角色总览数据）"] = "(Right-click to delete character overview data)"
    L["（插件右下角右键可删除数据）"] = "(Right-click on plugin lower right corner to delete data)"
    L["< 角色货币总览 >"] = "< Character Currency Overview >"
    L["金"] = "Gold"
    L["合计"] = "Total"
    L["删除角色"] = "Delete Character"
    L["总览数据"] = "Overview Data"
    L["你关注的装备开始拍卖了：%s（右键取消关注）"] = "The item you are watching is being auctioned: %s (right-click to cancel)"
    L["已成功关注装备：%s。团长拍卖此装备时会提醒"] = "Successfully added item to watch list: %s. You will be notified when the guild master auctions this item."
    L["<自动记录装备>"] = "<Auto Record Equipment>"
    L["已取消关注装备：%s"] = "Successfully removed item from watch list: %s"
    L["你的心愿达成啦！！！>>>>> %s(%s) <<<<<"] = "You have achieved your wish!!! >>>>> %s(%s) <<<<<"
    L["已自动记入表格：%s%s(%s) x%d => %s< %s >%s"] = "Automatically added to the table: %s%s(%s) x%d => %s< %s >%s"
    L["自动关注心愿装备：%s%s。团长拍卖此装备时会提醒"] = "Automatically added to wish list: %s%s. You will be notified when the guild master auctions this item."
    L["自动记录失败：%s%s(%s)。因为%s< %s >%s的格子满了。。"] = "Automatic recording failed: %s%s(%s). Because the slot in %s< %s >%s is full."
    L["自动关注心愿装备失败：%s%s"] = "Failed to automatically add item to wish list: %s%s"
    L["已自动记入表格：%s%s(%s) => %s< %s >%s"] = "Automatically added to the table: %s%s(%s) => %s< %s >%s"
    L["< 交易记账失败 >"] = "< Trade Account Failed >"
    L["双方都给了装备，但没金额"] = "Both sides gave equipment but no amount"
    L["我不知道谁才是买家"] = "I don't know who the buyer is"
    L["如果有金额我就能识别了"] = "I can recognize it if there is an amount"
    L["（欠款%d）"] = "(Debt %d)"
    L["< 交易记账成功 >"] = "< Trade Account Success >"
    L["< 交易记账成功 >|r\n装备：%s\n买家：%s\n金额：%s%d|rg%s\nBOSS：%s< %s >|r"] = "< Trade Account Success >|r\nItem: %s\nBuyer: %s\nAmount: %s%d|rg%s\nBOSS: %s< %s >|r"
    L["表格里没找到此次交易的装备"] = "The item for this transaction was not found in the table"
    L["该BOSS格子已满"] = "The slot for this BOSS is already full"
    L["欠款："] = "Debt:"
    L["记账效果预览"] = "Preview of Account Effect"
    L["无"] = "None"
    L["<交易自动记账>"] = "<Auto Trade Account>"
    L["次"] = "times"
    L["打断"] = "Interrupt"
    L["级"] = "Level"
    L["装等"] = "Item Level"
    L["分钟"] = "minutes"
    L["时间"] = "Time"
    L["已清空表格< %s >，分钱人数已改为%d人"] = "The table < %s > has been cleared, and the number of people to split the money has been changed to %d"
    L["已清空心愿< %s >"] = "The wish < %s > has been cleared"
    L["确认清空表格< %s >？"] = "Are you sure you want to clear the table < %s >?"
    L["高亮该天赋的装备"] = "Highlight equipment for this talent"
    L["<金额自动加零>"] = "<Automatic Add Zero to Amount>"
    L["<UI缩放>"] = "<UI Scale>"
    L["<UI透明度>"] = "<UI Transparency>"
    L["< BiaoGe > 版本过期提醒，最新版本是：%s，你的当前版本是：%s"] = "< BiaoGe > Version expired reminder, the latest version is: %s, your current version is: %s"
    L["你可以前往curseforge搜索biaoge更新"] = "You can go to curseforge to search for biaoge updates"
    L["< BiaoGe > 金团表格载入成功。插件命令：%s或%s，小地图图标：%s"] = "< BiaoGe > Raid table loaded successfully. Plugin commands: %s or %s, minimap icon: %s"
    L["星星"] = "Star"
    L["BiaoGe金团表格"] = "BiaoGe Raid Table"
    L["显示/关闭表格"] = "Show/Hide Table"
    L["对比的账单："] = "Comparative Bill:"
    L["  项目"] = "  Item"
    L["装备"] = "Equipment"
    L["我的金额"] = "My Amount"
    L["对方金额"] = "Other Amount"
    L["装备总收入"] = "Total Income"
    L["差额"] = "Difference"
    L["买家"] = "Buyer"
    L["金额"] = "Amount"
    L["关注"] = "Follow"
    L["关注中，团长拍卖此装备会提醒"] = "Followed, the guild master will be notified when this item is auctioned"
    L["右键取消关注"] = "Right-click to unfollow"
    L["欠款：%s|r\n右键清除欠款"] = "Debt: %s|r\nRight-click to clear debt"
    L["坦克补贴"] = "Tank Subsidy"
    L["治疗补贴"] = "Healer Subsidy"
    L["输出补贴"] = "DPS Subsidy"
    L["放鱼补贴"] = "Fish Subsidy"
    L["人数可自行修改"] = "Number can be modified"
    L["（SHIFT+点击可发送装备，CTRL+点击可通报历史价格）"] = "(ALT+Click to set as dropped, SHIFT+Click to send equipment, CTRL+Click to report historical price)"
    L["（ALT+点击可关注装备，SHIFT+点击可发送装备，CTRL+点击可通报历史价格）"] = "(ALT+Click to follow item, SHIFT+Click to send equipment, CTRL+Click to report historical price)"
    L["欠款金额"] = "Outstanding Amount"
    L["不在团队，无法通报"] = "Not in the team, cannot report"
    L["———通报历史价格———"] = "---------Report Historical Prices---------"
    L["装备：%s(%s)"] = "Item: %s(%s)"
    L["月"] = "Month"
    L["日"] = "Day"
    L["，价格:"] = ", Price:"
    L["，买家:"] = ", Buyer:"
    L["取消交换"] = "Cancel Trade"
    L["你正在交换该行全部内容"] = "You are trading the entire contents of this row"
    L["\n点击取消交换"] = "\nClick to cancel the trade"
    L["交换成功"] = "Trade successful"
    L["（ALT+左键改名，ALT+右键删除表格）"] = "(ALT + Left Click to Rename, ALT + Right Click to Delete)"
    L["保存表格"] = "Save Table"
    L["把当前表格保存至历史表格"] = "Save the current table to the historical table\nbut does not save outstanding amounts and attention"
    L["%m月%d日%H:%M:%S\n"] = "%m/%d/%H:%M:%S\n"
    L["%s %s %s人 工资:%s"] = "%s %s %s players Salary:%s"
    L["分享表格"] = "Share Table"
    L["把当前表格发给别人，类似发WA那样"] = "Share the current table with others, similar to sending a WA"
    L["当前表格-"] = "Current Table -"
    L["历史表格-"] = "Historical Table -"
    L["导出表格"] = "Export Table"
    L["把表格导出为文本"] = "Export the table as text"
    L["应用表格"] = "Apply Table"
    L["把该历史表格复制粘贴到当前表格，这样你可以编辑内容"] = "Copy and paste the historical table into the current table so that you can edit the content"
    L["确定应用表格？\n你当前的表格将被"] = "Apply the table?\nYour current table will be"
    L[" 替换 "] = " replaced "
    L["当前名字："] = "Current Name:"
    L["名字改为："] = "Change Name to:"
    L["确定"] = "Confirm"
    L["取消"] = "Cancel"
    L["（CTRL+点击可通报历史价格）"] = "(CTRL + Click to report historical prices)"
    L["< 历史表格 > "] = "< Historical Table > "
    L["你正在改名第 %s 个表格"] = "You are renaming the %s th table"
    L["< |cffFFFFFF10人|r|cff00BFFFNormal|r >"] = "< |cffFFFFFF10 Players|r|cff00BFFFNormal|r >"
    L["< |cffFFFFFF25人|r|cff00BFFFNormal|r >"] = "< |cffFFFFFF25 Players|r|cff00BFFFNormal|r >"
    L["< |cffFFFFFF10人|r|cffFF0000Heroic|r >"] = "< |cffFFFFFF10 Players|r|cffFF0000Heroic|r >"
    L["< |cffFFFFFF25人|r|cffFF0000Heroic|r >"] = "< |cffFFFFFF25 Players|r|cffFF0000Heroic|r >"
    L["心愿1"] = "Wish 1"
    L["心愿2"] = "Wish 2"
    L["已掉落"] = "Already Dropped"
    L["恭喜你，该装备已掉落"] = "Congratulations, the item has dropped"
    L["右键取消提示"] = "\nRight-click to cancel the prompt"
    L["当前团队还有 %s 人也许愿该装备！"] = "There are %s more players in the current team wishing for this item!"
    L["查询心愿竞争"] = "Check Wish Competition"
    L["查询团队里，有多少人许愿跟你相同的装备"] = "Check how many people in the team wish for the same item as you"
    L["不在团队，无法查询"] = "Not in a team, unable to check"
    L["恭喜你，当前团队没人许愿跟你相同的装备"] = "Congratulations, no one in the current team wishes for the same item as you"
    L["分享心愿10PT"] = "Share Wish 10PT"
    L["分享心愿25PT"] = "Share Wish 25PT"
    L["分享心愿10H"] = "Share Wish 10H"
    L["分享心愿25H"] = "Share Wish 25H"
    L["< 我 的 心 愿 >"] = "< My Wish >"
    L["副本难度："] = "Raid Difficulty:"
    L["频道：团队"] = "Channel: Raid"
    L["频道：队伍"] = "Channel: Party"
    L["不在队伍，无法通报"] = "Not in a party, unable to announce"
    L["频道：公会"] = "Channel: Guild"
    L["没有公会，无法通报"] = "No guild, unable to announce"
    L["频道：密语"] = "Channel: Whisper"
    L["没有目标，无法通报"] = "No target, unable to announce"
    L["————我的心愿————"] = "————My Wish List————"
    L["——感谢使用金团表格——"] = "——Thank you for using JinTuanTable——"
    L["队伍"] = "Party"
    L["公会"] = "Guild"
    L["团队"] = "Raid"
    L["密语目标"] = "Whisper Target"
    L["心愿清单："] = "Wish List:"
    L["心愿装备只要掉落就会有提醒，并且掉落后自动关注团长拍卖"] = "You will receive a reminder whenever a wish item drops, and it will automatically track the raid leader's auction after it drops."
    L["你今天的运气指数(1-100)："] = "Your luck index today (1-100):"
    L["当前表格"] = "Current Table"
    L["历史表格"] = "Historical Table"
    L["（当前为自动显示)"] = "(Currently set to auto show)"
    L["<BiaoGe>金团表格"] = "<BiaoGe> Raid Table"
    L["左键：|r打开表格\n"] = "Left-click: Open the table\n"
    L["中键：|r切换自动显示角色总览"] = "Right-click: Switch to automatically display character overview"
    L["（当前为不自动显示)"] = "(Currently set to not auto show)"
    L["通报流拍"] = "Announce Unsold"
    L["< 流 拍 装 备 >"] = "< Unsold Items >"
    L["通报欠款"] = "Announce Debt"
    L["< 通 报 欠 款 >"] = "< Announce Debt >"
    L["< 合 计 欠 款 >"] = "< Total Debt >"
    L["没记买家"] = "No Recorded Buyers"
    L["合计欠款："] = "Total Debt:"
    L["————通报欠款————"] = "————Announce Debt————"
    L["{rt7} 合计欠款 {rt7}"] = "{rt7} Total Debt {rt7}"
    L[" 合计欠款："] = " Total Debt:"
    L["没有WCL记录"] = "No WCL Records"
    L["读取不到数据，你可能没安装或者没打开WCL插件"] = "Unable to retrieve data, you may not have installed or enabled the WCL plugin"
    L["更新时间："] = "Update Time:"
    L["< WCL分数 >"] = "< WCL Score >"
    L["———通报WCL分数———"] = "———Announce WCL Score———"
    L["通报WCL"] = "Announce WCL"
    L["通报消费"] = "Announce Expenses"
    L["< 消 费 排 名 >"] = "< Spending Rank >"
    L["———通报消费排名———"] = "———Announce Spending Rank———"
    L["< 通报击杀用时 >"] = "< Announce Kill Time >"
    L["———通报击杀用时———"] = "———Announce Kill Time———"
    L["分"] = "min"
    L["秒"] = "sec"
    L["击杀用时："] = "Kill Time:"
    L["通报账单"] = "Announce Ledger"
    L["< 收  入 >"] = "< Income >"
    L["Boss："] = "Boss:"
    L["项目："] = "Item:"
    L["< 支  出 >"] = "< Expenses >"
    L["< 总  览 >"] = "< Overview >"
    L["< 工  资 >"] = "< Salary >"
    L["———通报金团账单———"] = "———Announce Raid Ledger———"
    L["< 收 {rt1} 入 >"] = "< {rt1} Income >"
    L["< 支 {rt4} 出 >"] = "< {rt4} Expenses >"
    L["< 总 {rt3} 览 >"] = "< {rt3} Overview >"
    L["人"] = "person"
    L["< 工 {rt6} 资 >"] = "< {rt6} Salary >"
    L["|cffffffff< 心愿清单 >|r\n\n1、你可以设置一些装备，\n    这些装备只要掉落就会有提醒，\n    并且掉落后自动关注团长拍卖\n"] = "|cffffffff< Wish List >|r\n\n1. You can set some items that you want,\n    and you will receive a reminder when they drop,\n    and automatically track the raid leader's auction\n"
    L["|cffffffff< 自动记录装备 >|r\n\n1、只会记录紫装和橙装\n2、橙片、飞机头、小怪掉落\n    会存到杂项里\n3、图纸不会自动保存\n"] = "|cffffffff< Automatically Record Items >|r\n\n1. Only Purple and Orange items will be recorded\n2. Orange scraps, plane heads, and mob drops\n    will be saved to Miscellaneous\n3. Blueprints will not be saved automatically\n"
    L["|cffffffff< 对账 >|r\n\n1、当团队有人通报BiaoGe/RaidLedger/大脚的账单，\n    你可以选择该账单，来对账\n2、只对比装备收入，不对比罚款收入，也不对比支出\n3、别人账单会自动保存1天，过后自动删除\n"] = "|cffffffff< Verify Ledger >|r\n\n1. When someone in the raid reports a BiaoGe/RaidLedger/BigFoot ledger, you can choose that ledger to verify\n2. Only compares item income, not fine income or expenses\n3. Other people's ledgers will be automatically saved for 1 day and then deleted\n"
    L["|cffffffff< 交易自动记账 >|r\n\n1、需要配合自动记录装备，因为\n    如果表格里没有该交易的装备，\n    则记账失败\n2、如果一次交易两件装备以上，\n    则只会记第一件装备，\n"] = "|cffffffff< Automatically Record Trades >|r\n\n1. Requires automatic item recording, because\n    if the item is not in the table, the trade will fail to record\n2. If there are more than two items in a trade,\n    only the first item will be recorded\n"
    L["|cffffffff< 清空当前表格/心愿 >|r\n\n1、表格界面时一键清空装备、买家、金额，同时还清空关注和欠款\n2、心愿界面时一键清空全部心愿装备\n"] = "|cffffffff< Clear Current Table/Wishlist >|r\n\n1. In the table interface, click to clear all items, buyers, and amounts, and also clear the tracking and debt\n2. In the wishlist interface, click to clear all wishlist items\n"
    L["|cffffffff< 金额自动加零 >|r\n\n1、输入金额和欠款时自动加两个0\n    减少记账操作，提高记账效率\n"] = "|cffffffff< Automatically Add Two Zeros to Amounts >|r\n\n1. Automatically add two zeros to amounts and debts\n    to reduce accounting operations and improve efficiency\n"
    L["通报金团账单"] = "Announce Raid Ledger"
    L["RaidLedger:.... 收入 ...."] = "RaidLedger:.... Credit ...."
    L["事件：.-|c.-|Hitem.-|h|r"] = "Event:.-|c.-|Hitem.-|h|r"
    L["(%d+)金"] = "(%d+)gold"
    L["收入为："] = "Income:"
    L["收入为：%d+。"] = "Income:%d+."
    L["平均每人收入:"] = "Per Member credit:"
    L["感谢使用金团表格"] = "Thank you for using the Raid Table"
    L["，装备总收入"] = ",Total item income:"
    L["-感谢使用大脚金团辅助工具-"] = "-Thank you for using BigFoot Raid Assistant-"
    L["总收入"] = "Total Income"
    L["总支出"] = "Total Expenses"
    L["净收入"] = "Net Income"
    L["分钱人数"] = "Number of People Splitting Money"
    L["人均工资"] = "Average Salary per Person"
    L["历史价格：%s%s(%s)"] = "historical prices:%s%s(%s)"
    L["通报用时"] = "Announce Time"
    L["返回表格"] = "Return to Table"
    L["当前"] = "Current amount"
    L["没有金额"] = "No amount"
    L["———通报流拍装备———"] = "———通報流拍裝備———"
    L["欠"] = true
	
	-- 自行加入
	L["BiaoGe"] = "|cff00BFFFBiaoGe|r"

end









-- BOSS名字
do
    L["你\n漏\n记\n的\n装\n备"] = "Items\nMissed\nby\nYou"
    L["总\n结"] = "Sum-\nmary"
    L["工\n资"] = "Sa-\nlary"
    L["杂\n\n项"] = "Misce-\nllaneous"
    L["罚\n\n款"] = "Fines"
    L["支\n\n出"] = "Ex-\npenses"
    L["总\n览"] = "Over-\nview"

    L["玛\n洛\n加\n尔\n领\n主"] = "Lord\nMarr-\nowgar"
    L["亡\n语\n者\n女\n士"] = "Lady\nDeath-\nwhisper"
    L["冰\n冠\n炮\n舰\n战\n斗"] = "Gun-\nship\nBattle"
    L["萨\n鲁\n法\n尔"] = "Saur-\nfang"
    L["烂\n肠"] = "Fester-\ngut"
    L["腐\n面"] = "Rot-\nface"
    L["普\n崔\n塞\n德\n教\n授"] = "Pro-\nfessor\nPut-\nricide"
    L["鲜\n血\n议\n会"] = "Blood\nCouncil"
    L["鲜\n血\n女\n王"] = "Blood-\nQueen\nLana'-\nthel"
    L["踏\n梦\n者"] = "Valith-\nria\nDream-\nwalker"
    L["辛\n达\n苟\n萨"] = "Sindra-\ngosa"
    L["巫\n妖\n王"] = "The\nLich\nKing"
    L["海\n里\n昂"] = "Ha-\nlion"

    L["诺\n森\n德\n猛\n兽"] = "North-\nrend\nBeasts"
    L["加\n拉\n克\n苏\n斯"] = "Lord\nJara-\nxxus"
    L["阵\n营\n冠\n军"] = "Champion\nof\nthe\nHorde/\nAlliance"
    L["瓦\n克\n里\n双\n子"] = "Twin\nVal'kyr"
    L["阿\n努\n巴\n拉\n克"] = "Anub'-\narak"
    L["嘉\n奖\n宝\n箱"] = "Loot\nChest"
    L["奥\n妮\n克\n希\n亚"] = "Ony-\nxia"

    L["烈\n焰\n巨\n兽"] = "Flame\nLeviathan"
    L["锋\n鳞"] = "Razorscale"
    L["掌\n炉\n者"] = "Ignis\nthe\nFurnace\nMaster"
    L["拆\n解\n者"] = "XT-002\nDecon-\nstructor"
    L["钢\n铁\n议\n会"] = "Iron\nCouncil"
    L["科\n隆\n加\n恩"] = "Kolo-\ngarn"
    L["欧\n尔\n利\n亚"] = "Aur-\niaya"
    L["霍\n迪\n尔"] = "Ho-\ndir"
    L["托\n里\n姆"] = "Tho-\nrim"
    L["弗\n蕾\n亚"] = "Fre-\nya"
    L["米\n米\n尔\n隆"] = "Mimi-\nron"
    L["维\n扎\n克\n斯\n将\n军"] = "Gene-\nral\nVezax"
    L["尤\n格\n萨\n隆"] = "Yogg-\nSaron"
    L["奥\n尔\n加\n隆"] = "Algalon\nthe\nObserver"

    L["阿\n努\n布\n雷\n坎"] = "Anub'-\nRekhan"
    L["黑\n女\n巫\n法\n琳\n娜"] = "Grand\nWidow\nFaerlina"
    L["迈\n克\n斯\n纳"] = "Maexxna"
    L["瘟\n疫\n使\n者\n诺\n斯"] = "Noth\nthe\nPlague-\nbringer"
    L["肮\n脏\n的\n希\n尔\n盖"] = "Heigan\nthe\nUnclean"
    L["洛\n欧\n塞\n布"] = "Loa-\ntheb"
    L["教\n官"] = "Inst-\nructor\nRazu-\nvious"
    L["收\n割\n者\n戈\n提\n克"] = "Gothik\nthe\nHar-\nvester"
    L["天\n启\n四\n骑\n士"] = "The\nFour\nHorsemen"
    L["帕\n奇\n维\n克"] = "Patch-\nwerk"
    L["格\n罗\n布\n鲁\n斯"] = "Grob-\nbulus"
    L["格\n拉\n斯"] = "Glu-\nth"
    L["塔\n迪\n乌\n斯"] = "Tha-\nddius"
    L["萨\n菲\n隆"] = "Sap-\nphiron"
    L["克\n尔\n苏\n加\n德"] = "Kel'-\nThuzad"
    L["萨\n塔\n里\n奥"] = "Sar-\ntharion"
    L["玛\n里\n苟\n斯"] = "Maly-\ngos"

    -- L[] = true
    -- L[] = true
    -- L[] = true
    -- L[] = true
    -- L[] = true
    -- L[] = true
    -- L[] = true
end

ADDONSELF.L = L
