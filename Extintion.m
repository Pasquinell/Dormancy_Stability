function [gstop,isterminal,direction] = Extintion(t,y)

global ET m

gstop       = y(1:m)-ET;
isterminal  = ones(size(gstop));
direction   = -ones(size(gstop));

end