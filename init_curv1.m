function [C,siz,s,s1]=init_curv1(dimax1,dimax2,dimax3,nlevs,filt)
a=zeros(dimax1,dimax2,dimax3);
C1=wavedec3(a,nlevs,filt);
[C,l1]=nim3d_wav2vec(C1);
s1=C1.sizes;
s=C1.filters;
for i=1:l1+1
    a1=size(C{1,i}{1,1});
    siz(i)=length(C{1,i})*a1(1)*a1(2)*a1(3);
end
