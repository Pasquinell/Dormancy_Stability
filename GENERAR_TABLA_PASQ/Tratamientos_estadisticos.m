    function [out11, out12] = Tratamientos_estadisticos(X1,Y1,BETA1,R1,J1,SIGMA1,MSE1)
        CI1 = nlparci(BETA1,R1,'covar',SIGMA1);
        SE11=(CI1(1,2)-BETA1(1,1)/1.96);
        SE12=(CI1(2,2)-BETA1(1,2)/1.96);
        % Predicted values
%         step1=(max(X1)-1)/50;
%         xx1=min(X1):step1:max(X1);
%          Y_pred1=typ2(BETA1,xx1')';
        % Goodness of fit
        Ybar1=mean(Y1);
        % Residual SS
        RSS1=sum(R1.*R1);
        % Total SS
        SST1=sum((Y1-Ybar1).^2);
        % SS of regression
        SSR1=SST1-RSS1;
        Rsquare1=SSR1/SST1;
        n1=size(Y1);
        n1=n1(1);
        % MS
        MSR1=SSR1;
        MSE1=RSS1/(n1-1);
        Fratio1=MSR1/MSE1;
        Pval1=1-fcdf(Fratio1,1,n1-1);
        % AIC
        k_1=2;
        AIC_1=2+k_1+n1+(log(2*pi*RSS1/n1)+1);
        AICc_1=AIC_1+(2*k_1*(k_1+1))/(n1-k_1-1);
        % Output
        out11=[BETA1(1,1),CI1(1,1),CI1(1,2),SE11,Rsquare1,Fratio1,Pval1,AICc_1];
        out12=[BETA1(1,2),CI1(2,1),CI1(2,2),SE12];
    end

