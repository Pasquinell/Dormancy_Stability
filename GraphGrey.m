function GraphGrey(EPD_Proportion)

%  P = load('PERSIST_MAT_%EPD')
%  S = load('SHANNON_MAT_%EPD')

 
P = load(sprintf('PERSIST_Y_SHANNON_MAT/PERSIST_MAT_EPD%3.2f',EPD_Proportion));

S = load(sprintf('PERSIST_Y_SHANNON_MAT/SHANNON_MAT_EPD%3.2f',EPD_Proportion));
% %Ejes para los plots

% Y=[.1
%     .15
%     .2
%     .25
%     .3];
% X=[20
%     40
%     60
%     80];
% 
% surf(X,Y,P);
% colormap Gray
% xlabel('Connectance','fontsize',22);
% ylabel('Richness','fontsize',22);
% %t=colorbar('location','EastOutside');
% set(gca,'FontSize',16)
% set(gca,'YDir','normal')
% %set(get(t,'ylabel'),'String','Persistence','FontSize',16)
% %caxis([0 1])  
% axis([0.09 0.26 19 51 0.3 1]) 
% %saveas(gcf,Name1,'png')

climsP = [.2 .6];
climsS = [-200 1];

figure
colormap(gray);
imagesc(P, climsP);
figure
colormap(gray);
imagesc(S,climsS);
% 
% figure
% colormap(gray);
% imagesc(mat2gray(P));
% figure
% colormap(gray);
% imagesc(mat2gray(S));

end