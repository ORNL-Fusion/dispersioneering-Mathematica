close all;
clear all;
clc;

% Read data from Jay Anderson, WHAM
% =================================
whamdata=readtable('WHAM_phase2_800eV_3p2e19.csv');


%% Physical constants:
% =========================================================================
e_c = 1.6020e-19;
k_B = 1.3806e-23;
m_p = 1.6726e-27;
m_e = 9.1094e-31;
mu0 = 4*pi*1e-7;
c   = 299792458;
E_0 = m_p*c^2;

%% Contours of harmonic numbers


whamdata=readtable('WHAM_phase2_800eV_3p2e19.csv');
nR = 129;
nZ = 601;
r2D = reshape(whamdata.r,[nR,nZ]);
z2D = reshape(whamdata.z,[nR,nZ]);
br2D = reshape(whamdata.br,[nR,nZ]);
bz2D = reshape(whamdata.bz,[nR,nZ]);
psi2D = reshape(whamdata.psi,[nR,nZ]);
ne2D = reshape(whamdata.ne,[nR,nZ]);
r=r2D(:,1);
z=z2D(1,:);
rlim = 0.2;
figure()
B=sqrt(br2D.^2+bz2D.^2);
q=1.6e-19;
m=2*1.67e-27;
wc=q*B/m;
wrf=2*pi*27.1e6;
[C,h]=contour(z,r,wrf./wc,[1,2,3,4,5],'ShowText','on','LineWidth', 2);
clabel(C,h,'FontSize',18,'Color','black')
% hold on
% contour(z,r,ne2D,'LineWidth', 2)
xlim([-0.8,+0.8]);
ylim([-rlim,rlim]);

% xlim([-1.25 1.25])
% ylim([-1.0 1.0]);
set(gca,'XTick',[])
set(gca,'YTick',[])
set(gca,'YLabel',[])
set(gca,'XLabel',[])
% set(gcf, 'color', 'none'); set(gca, 'color', 'none');
% exportgraphics(gcf,'transparent.eps',...   % since R2020a
% 'ContentType','vector',...
% 'BackgroundColor','none')



%%



z=unique(whamdata.z);
r=unique(whamdata.r);

[r2D,z2D] = meshgrid(r,z);


% Font sizes:
fontSize.label  = 16;
fontSize.title  = 12;
fontSize.legend = 13;
fontSize.axes   = 13;
% B-field data
% ------------
bz=reshape(whamdata.bz,numel(r),numel(z));
br=reshape(whamdata.br,numel(r),numel(z));
psi=reshape(whamdata.psi,numel(r),numel(z));

B2D=0.5*sqrt(br.*br+bz.*bz);

m_D=2*m_p;
w_ci=e_c.*B2D'./(m_D);
w_rf = 2*pi*27.1E6;
resN=(w_ci./w_rf);


figure;hold on;contour(z2D,r2D,1./resN,'LevelList',[1,2,3,4,5],'ShowText', 'on','LineWidth',4);
xlim([-1.25 1.25])
ylim([-1.0 1.0]);
% set(gca,'XTick',[])
% set(gca,'YTick',[])
% set(gca,'YLabel',[])
% set(gca,'XLabel',[])
% set(gcf, 'color', 'none'); set(gca, 'color', 'none');
% exportgraphics(gcf,'transparent.eps',...   % since R2020a
% 'ContentType','vector',...
% 'BackgroundColor','none')

%% Magnetic field plots

figure; imagesc(z,r,bz);
figure; contour(z,r,bz,'LevelList',[1,2,3,4,5],'ShowText', 'on','LineWidth',4)

set(gca,'fontName','times','fontSize',fontSize.axes)
% ylim([0 20]);
% xlim([7,35])
xlabel('$z[m]$','interpreter','latex','fontSize',fontSize.label)
ylabel('$r[m]$','interpreter','latex','fontSize',fontSize.label)
figure; 
hB(1)= plot(z,bz(1,:),'k-', 'LineWidth',0.5);hold on;
hB(2)= plot(z(227:end-226),bz(1,227:end-226),'r-', 'LineWidth',4);

m_D=2*m_p;
bz1=bz(1,227:end-226);
w_ci=e_c.*bz(1,:)./(m_D);
w_rf = 2*pi*27.1E6;

resN=abs(1-(w_rf./w_ci));
figure; plot(z,resN)



% Legend:
hLeg = legend(hB,'full','zoom');
set(hLeg,'interpreter','latex','fontSize',fontSize.legend,'Location','east');

% Formatting:
set(gca,'fontName','times','fontSize',fontSize.axes)
ylim([0 20]);
% xlim([7,35])
xlabel('z[m]','interpreter','latex','fontSize',fontSize.label)
ylabel('$B_z[T]$','interpreter','latex','fontSize',fontSize.label)


% density data
% ------------
ne=1E19*reshape(whamdata.ne,numel(r),numel(z));
figure; imagesc(z,r,ne);
xlabel('$z[m]$','interpreter','latex','fontSize',fontSize.label)
ylabel('$r[m]$','interpreter','latex','fontSize',fontSize.label)
figure; 
hD=plot(z,ne(1,:),'r-', 'LineWidth',4);
% Legend:
hLeg = legend(hB,'full','zoom');
set(hLeg,'interpreter','latex','fontSize',fontSize.legend,'Location','east');

% Formatting:
set(gca,'fontName','times','fontSize',fontSize.axes)
ylim([0 1E20]);
% xlim([7,35])
xlabel('z[m]','interpreter','latex','fontSize',fontSize.label)
ylabel('$n_e$ [m$^{-3}$]','interpreter','latex','fontSize',fontSize.label)


% Temperature data
% ----------------
Te=800*reshape(whamdata.ne./whamdata.ne(2),numel(r),numel(z));
figure; imagesc(z,r,Te);
xlabel('$z[m]$','interpreter','latex','fontSize',fontSize.label)
ylabel('$r[m]$','interpreter','latex','fontSize',fontSize.label)
figure; plot(z,Te(1,:));
% Formatting:
set(gca,'fontName','times','fontSize',fontSize.axes)
xlabel('z[m]','interpreter','latex','fontSize',fontSize.label)
ylabel('$T_e$ [eV]','interpreter','latex','fontSize',fontSize.label)

data=[z(227:end-226), ne(1,(227:end-226))',Te(1,(227:end-226))',bz(1,(227:end-226))'];
T=array2table(data);
T.Properties.VariableNames(1:4)={'z','ne','Te','Bz'};
writetable(T,'wham_profiles.csv');






