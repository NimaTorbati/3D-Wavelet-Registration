function [c,l1]=nim3d_wav2vec(c1)
l1=(size(c1.dec,1)-1)/7;
c=cell(1,l1+1);
c{1}{1}=c1.dec{1};
k=2;
for i=1:l1
    for j=1:7
        c{i+1}{j}=c1.dec{k};
        k=k+1;
    end
end
