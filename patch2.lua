
interface{"JRMinePriviOrderDetail"}

function payForNormalPrivite(self,sender)

    local dic = {}
    if self:selectedWXP()
    then
        dic["paymentChannel"] = 2
    else
        dic["paymentChannel"] = 1
    end

    dic["orderId"] = self:detailData():orderId()
    dic["accessToken"] = JRUserInfo:shareUserInfo():accessToken()
    dic["payMode"] = 2

    local weakSelf  =   self--temp self
    YLAPIRequestManage:postUrl_andParams_andSuccessBlock_orErrorBlock("sp/privilege/privilegePurchase",dic,

        toblock(

            function (data)
        
                -- print('lua  animations  completion  '   ..  tostring(data))

                print('get data '.. tostring(data["status"]))


                if data["status"] == 200 
                then
                    print('is success')
                    if self:selectedWXP()
                    then
                        print('is wx')

                        local stringData = NSJSONSerialization:dataWithJSONObject_options_error(data["payResult"]["payParameter"],NSJSONWritingPrettyPrinted,nil)
                        local signString = NSString:initWithData_encoding(stringData,NSUTF8StringEncoding) 

                        weakSelf:payTheOrderByType_withSignInfo_action(self:selectedWXP(),toobjc(signString),sender)
                    else
                        print('is alipay')
                        weakSelf:payTheOrderByType_withSignInfo_action(self:selectedWXP(),data["payResult"]["payParameter"]["sign"],sender)
                    end
                    sender:setEnabled(true)

                else

                    print('is failed')
                    sender:setEnabled(true)
                end

            end
        ,{"void","id"}), -- return void,

        toblock(
            function ()
                sender:setEnabled(true)
            end   
        ,{"void","NSError"})-- return void
    )
end

function payforFlashPrivilge(self,sender)

    local dic = {}
    if self:selectedWXP()
    then
        dic["paymentChannel"] = 2
    else
        dic["paymentChannel"] = 1
    end

    dic["orderId"] = self:detailData():orderId()
    dic["accessToken"] = JRUserInfo:shareUserInfo():accessToken()
    dic["payMode"] = 2

    local weakSelf  =   self--temp self
    YLAPIRequestManage:postUrl_andParams_andSuccessBlock_orErrorBlock("sp/privilege/flashSalePurchase",dic,

        toblock(

            function (data)
        
                -- print('lua  animations  completion  '   ..  tostring(data))

                print('get data '.. tostring(data["status"]))


                if data["status"] == 200 
                then
                    print('is success')
                    if self:selectedWXP()
                    then
                        print('is wx')

                        local stringData = NSJSONSerialization:dataWithJSONObject_options_error(data["payResult"]["payParameter"],NSJSONWritingPrettyPrinted,nil)
                        local signString = NSString:initWithData_encoding(stringData,NSUTF8StringEncoding) 

                        weakSelf:payTheOrderByType_withSignInfo_andsender(self:selectedWXP(),toobjc(signString),sender)
                    else
                        print('is alipay')
                        weakSelf:payTheOrderByType_withSignInfo_andsender(self:selectedWXP(),data["payResult"]["payParameter"]["sign"],sender)
                    end
                    sender:setEnabled(true)

                else

                    print('is failed')
                    sender:setEnabled(true)
                end

            end
        ,{"void","id"}), -- return void,

        toblock(
            function ()
                sender:setEnabled(true)
            end   
        ,{"void","NSError"})-- return void
    )
end