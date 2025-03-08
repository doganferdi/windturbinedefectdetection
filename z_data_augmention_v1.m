% text dosyalarini okuyup orada bulunan koordinat degerlerini aliyoruz
clear all
%kullanacagimiz degiskenleri variable olarak atiyoruz
text_okunan_etiketler_tumu=[];
boyaHasari_sayisi=0;
% drenaj_sayisi=0;
erozyon_sayisi=0;
% kabukAyrilmasi_sayisi=0;
% reseptor_sayisi=0;
% reseptorHasarli_sayisi=0;
serration_sayisi=0;
% serrationHasarli_sayisi=0;
vortex_sayisi=0;
vortexHasarli_sayisi=0;
% yagLekesi_sayisi=0;
% yildirimHasari_sayisi=0;
% yuzeyCatlagi_sayisi=0;


%resim ve text dosyaları aynı klasorde olacak şekilde tasarlandi. oyüzden
%asagida iki farkli klasor var. 
etiket_klasor=dir('C:\Program Files\MATLAB\R2024b\toolbox\nnet\cnn\zeliharuzgarturbini\dataset\labels\*.txt');
resim_klasor='C:\Program Files\MATLAB\R2024b\toolbox\nnet\cnn\zeliharuzgarturbini\dataset\labels';
goruntu_sayisi=0;
goruntu_sayisi=numel(etiket_klasor)
enb=0;boyut=0;enk=99999;enbwg=0;enbhy=0;

%%
for k = 1:goruntu_sayisi
dosya_yolu={};
    [~, f,ext] = fileparts(etiket_klasor(k).name);

dosya_adi=fullfile(resim_klasor,etiket_klasor(k).name);
okunan_text_dosyasi=table2array(readtable((dosya_adi)));
[satir,sutun] = size(okunan_text_dosyasi);
dosya_yolu(1:satir,1)={dosya_adi};
d_yolu1 = replace(dosya_yolu,'txt','jpg');
dadi=replace(dosya_adi,'txt','jpg');
d_yolu1 = replace(d_yolu1,'labels','images');
dadi=replace(dadi,'labels','images');
%%
% bu bölüm text dosyasından alınan ondalıklı değerleri korrdinat düzleminde
% x ve y başlangıç ve bitiş noktalarını hesaplama 
[hy,wg,kan]=size(imread(dadi));

if wg>enbwg
    enbwg=wg;
end
if wg>enbhy
    enbhy=hy;
end

for z=1:satir
        x=okunan_text_dosyasi(z,2);
        y=okunan_text_dosyasi(z,3);
        w=okunan_text_dosyasi(z,4); 
        h=okunan_text_dosyasi(z,5);

        if length(f)<14
            x0=int32((x-w/2)*wg);
            y0=int32((y-h/2)*hy);
            x1=int32((x+w/2)*wg);x1=x1-x0;
            y1=int32((y+h/2)*hy);y1=y1-y0;

        else
            if f(15:15)=="a"
            x0=int32((x-w/2)*wg);
            y0=int32((y-h/2)*hy);
            x1=int32((x+w/2)*wg);x1=x1-x0;
            y1=int32((y+h/2)*hy);y1=y1-y0;
            x0=wg-x0-x1;
            end
            if f(15:15)=="b"
            x0=int32((x-w/2)*wg);
            y0=int32((y-h/2)*hy);
            x1=int32((x+w/2)*wg);x1=x1-x0;
            y1=int32((y+h/2)*hy);y1=y1-y0;
            y0=hy-y0-y1;
            end
            if f(15:15)=="c"
            x0=int32((x-w/2)*wg);
            y0=int32((y-h/2)*hy);
            x1=int32((x+w/2)*wg);x1=x1-x0;
            y1=int32((y+h/2)*hy);y1=y1-y0;
            x0=wg-x0-x1;
            y0=hy-y0-y1;
            end

        end

            if x0<1 
                x0=1; end
            if x1<1 
                x1=1;end
            if y0<1 
                y0=1;
            end
            if y1<1 
                y1=1;end
   
    okunan_text_dosyasi(z,2)=x0;
    okunan_text_dosyasi(z,3)=y0;
    okunan_text_dosyasi(z,4)=x1;
    okunan_text_dosyasi(z,5)=y1;
end 

okunan_etiketler1=[];


boyaHasari_koordinat=[];
% drenaj_koordinat=[];
erozyon_koordinat=[];
% kabukAyrilmasi_koordinat=[];
% reseptor_koordinat=[];
% reseptorHasarli_koordinat=[];
serration_koordinat=[];
% serrationHasarli_koordinat=[];
vortex_koordinat=[];
vortexHasarli_koordinat=[];
% yagLekesi_koordinat=[];
% yildirimHasari_koordinat=[];
% yuzeyCatlagi_koordinat=[];
 
ekle=0;

 for i=1:satir
     
    hesabakatma=0;
    okunan1satir=okunan_text_dosyasi(i,2:5);
        x=okunan_text_dosyasi(z,2);
        y=okunan_text_dosyasi(z,3);
        w=okunan_text_dosyasi(z,4); 
        h=okunan_text_dosyasi(z,5);
       boyut=w*h;
       
       if boyut>enb
           enb=boyut;
       end
       if boyut<enk
           enk=boyut;
       end
       if (w*h)<1
           hesabakatma=1;
       end
  
  if okunan_text_dosyasi(i,1)==0 && hesabakatma==0
      boyaHasari_sayisi=boyaHasari_sayisi+1;
      boyaHasari_koordinat=[boyaHasari_koordinat;[okunan1satir]];
      ekle=1;
  end
 
   % if okunan_text_dosyasi(i,1)==1 && hesabakatma==0
   %    drenaj_koordinat=[drenaj_koordinat;okunan1satir];
   %    drenaj_sayisi=drenaj_sayisi+1;
   %    ekle=1;
   % end
   if okunan_text_dosyasi(i,1)==2 && hesabakatma==0
      erozyon_koordinat=[erozyon_koordinat;okunan1satir];
      erozyon_sayisi=erozyon_sayisi+1;
      ekle=1;
   end

   % if okunan_text_dosyasi(i,1)==3 && hesabakatma==0
   %    kabukAyrilmasi_koordinat=[kabukAyrilmasi_koordinat;okunan1satir];
   %    kabukAyrilmasi_sayisi=kabukAyrilmasi_sayisi+1;
   %    ekle=1;
   % end
  %  if okunan_text_dosyasi(i,1)==4 && hesabakatma==0
  %     reseptor_koordinat=[reseptor_koordinat;okunan1satir];
  %     reseptor_sayisi=reseptor_sayisi+1;
  %     ekle=1;
  %  end
  %    if okunan_text_dosyasi(i,1)==5 && hesabakatma==0
  %     reseptorHasarli_sayisi=reseptorHasarli_sayisi+1;
  %     reseptorHasarli_koordinat=[reseptorHasarli_koordinat;[okunan1satir]];
  %     ekle=1;
  % end
 
   if okunan_text_dosyasi(i,1)==6 && hesabakatma==0
      serration_koordinat=[serration_koordinat;okunan1satir];
      serration_sayisi=serration_sayisi+1;
      ekle=1;
   end
   % if okunan_text_dosyasi(i,1)==7 && hesabakatma==0
   %    serrationHasarli_koordinat=[serrationHasarli_koordinat;okunan1satir];
   %    serrationHasarli_sayisi=serrationHasarli_sayisi+1;
   %    ekle=1;
   % end

   if okunan_text_dosyasi(i,1)==8 && hesabakatma==0
      vortex_koordinat=[vortex_koordinat;okunan1satir];
      vortex_sayisi=vortex_sayisi+1;
      ekle=1;
   end
   if okunan_text_dosyasi(i,1)==9 && hesabakatma==0
      vortexHasarli_koordinat=[vortexHasarli_koordinat;okunan1satir];
      vortexHasarli_sayisi=vortexHasarli_sayisi+1;
      ekle=1;
   end

   % if okunan_text_dosyasi(i,1)==10 && hesabakatma==0
   %    yagLekesi_koordinat=[yagLekesi_koordinat;okunan1satir];
   %    yagLekesi_sayisi=yagLekesi_sayisi+1;
   %    ekle=1;
   % end

   % if okunan_text_dosyasi(i,1)==11 && hesabakatma==0
   %    yildirimHasari_koordinat=[yildirimHasari_koordinat;okunan1satir];
   %    yildirimHasari_sayisi=yildirimHasari_sayisi+1;
   %    ekle=1;
   % end
   % if okunan_text_dosyasi(i,1)==12 && hesabakatma==0
   %    yuzeyCatlagi_koordinat=[yuzeyCatlagi_koordinat;okunan1satir];
   %    yuzeyCatlagi_sayisi=yuzeyCatlagi_sayisi+1;
   %    ekle=1;
   % end
  
end 

if ekle==0
    ekle=ekle;
end
if ekle==1
% okunan_etiketler1=[dadi {boyaHasari_koordinat} {drenaj_koordinat} {erozyon_koordinat} {kabukAyrilmasi_koordinat} {reseptor_koordinat} {reseptorHasarli_koordinat} {serration_koordinat} {serrationHasarli_koordinat} {vortex_koordinat} {vortexHasarli_koordinat} {yagLekesi_koordinat} {yildirimHasari_koordinat} {yuzeyCatlagi_koordinat}];
okunan_etiketler1=[dadi {boyaHasari_koordinat}  {erozyon_koordinat}  {serration_koordinat} {vortex_koordinat} {vortexHasarli_koordinat}];
text_okunan_etiketler_tumu=[text_okunan_etiketler_tumu;okunan_etiketler1];
end
end
%%

toplam=boyaHasari_sayisi+erozyon_sayisi+serration_sayisi+vortex_sayisi+vortexHasarli_sayisi;
% kategoriler=categorical(["boyaHasari","drenaj","erozyon","kabukAyrilmasi","reseptor","reseptorHasarli","serration","serrationHasarli","vortex","vortexHasarli","yagLekesi","yildirimHasari","yuzeyCatlagi"])
kategoriler=categorical(["boyaHasari","erozyon","serration","vortex","vortexHasarli"])
kategoriler=categories(kategoriler)

ruzgartirbunu_train_ds=table(text_okunan_etiketler_tumu(:,1),text_okunan_etiketler_tumu(:,2),text_okunan_etiketler_tumu(:,3),text_okunan_etiketler_tumu(:,4),text_okunan_etiketler_tumu(:,5),text_okunan_etiketler_tumu(:,6), ...
    'VariableNames', {'resim_yolu','boyaHasari','erozyon', ...
    'serration','vortex','vortexHasarli'});
save ('C:\Program Files\MATLAB\R2024b\toolbox\nnet\cnn\zeliharuzgarturbini\zelihav4_5_sinif_v1.mat','-v7.3');
% load ('C:\Program Files\MATLAB\R2023b\toolbox\nnet\cnn\ruzgarturbini\ruzgar_tirbunu_v1.mat');

