-- oc 源码
-- -(void)payforFlashPrivilge:(UIButton *)sender{
--     NSMutableDictionary *dic = [NSMutableDictionary dictionary];
--     if (self.selectedWXP) {
--         [dic setValue:@(2) forKey:@"paymentChannel"];
--     }else{
--         [dic setValue:@(1) forKey:@"paymentChannel"];
--     }
--     [dic setValue:self.detailData.orderId forKey:@"orderId"];
--     [dic setValue:USERINFO.accessToken forKey:@"accessToken"];
--     [dic setValue:@"2" forKey:@"payMode"];
--     __weak typeof(self) weakSelf = self;
--     [YLAPIRequestManage postUrl:flashSalePurchase andParams:dic andSuccessBlock:^(id  _Nonnull data) {

--         switch ([data[@"status"] integerValue]) {
--             case 200:
--             {
--                 NSError *parseError;
--                 NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data[@"payResult"][@"payParameter"] options:NSJSONWritingPrettyPrinted error:&parseError];
--                 if (parseError) {
--                   //解析出错
--                 }
--                 NSString * str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

--                 if (weakSelf.selectedWXP) {
--                     [weakSelf payTheOrderByType:weakSelf.selectedWXP withSignInfo:str action:sender];
--                 }   else{
--                     [weakSelf payTheOrderByType:weakSelf.selectedWXP withSignInfo:[NSString stringWithFormat:@"%@",data[@"payResult"][@"payParameter"][@"sign"]] action:sender];
--                 }

--                 //[weakSelf payTheOrderByType:weakSelf.selectedWXP withSignInfo:str action:sender];
--                 sender.enabled = YES;
--             }
--                 break;
--             default:
--                 sender.enabled = YES;
--                 break;
--         }

--     } orErrorBlock:^(NSError * _Nonnull error) {
--         sender.enabled = YES;
--     }];
-- }


interface{"JRConfirmOrderPri"}

function payForNormalPrivite(self,sender)

    -- 声明字典、数组：lua 中只有table类型
    local dic = {}

    -- 控制流if语句 if then  else  end 
    -- :语法获取属性，属性后用（）
    if self:selectedWXP()
    then

        -- 字典赋值
        dic["paymentChannel"] = 2
    else
        dic["paymentChannel"] = 1
    end

    dic["orderId"] = self:orderInfo():rechargeOrderId()

    -- 原生code中的宏函数不可用，要使用特定的类
    dic["accessToken"] = JRUserInfo:shareUserInfo():accessToken()
    dic["payMode"] = 2

    -- weakSelf 避免循环引用
    local weakSelf  =   self--temp self

    -- ：调用方法，多参数用下划线分开，实际参数放置于函数（）中
    YLAPIRequestManage:postUrl_andParams_andSuccessBlock_orErrorBlock("sp/privilege/privilegePurchase",dic,

        -- 对于block，要用toblock关键字
        
        -- 格式：
        -- toblock(function (param),{backvaluetype,paramtype})
        
        toblock(

            -- block的回调内容：用function（param）包裹
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



function payforFlashPrivilge(self,sender)

    local dic = {}
    if self:selectedWXP()
    then
        dic["paymentChannel"] = 2
    else
        dic["paymentChannel"] = 1
    end

    dic["orderId"] = self:orderInfo():rechargeOrderId()
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