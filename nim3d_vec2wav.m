function [c]=nim3d_vec2wav(c1,level,siz,siz1,filt)
c.sizeINI=siz;
c.level=level;
c.filters=filt;

c.mode='sym';
l1=length(c1)-1;
c2=cell(7*l1+1,1);
c2{1}=c1{1}{1};
k=2;
for i=1:l1
    for j=1:7
        c2{k}=c1{i+1}{j};
        k=k+1;
    end
end
c.dec=c2;
c.sizes=siz1;