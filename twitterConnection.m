% consumerkey = 'abcdefghijklmnop123456789';
% consumersecret = 'qrstuvwxyz123456789';
% accesstoken = '123456789abcdefghijklmnop';
% accesstokensecret = '123456789qrstuvwxyz';
% 
% c = twitter(consumerkey,consumersecret,accesstoken,accesstokensecret);

c.StatusCode = 'OK'; %Temporary

%Check the Twitter connection
if c.StatusCode ~= matlab.net.http.StatusCode.OK;
    return
end



