[y,Fs] = audioread('input.wav');
y=y(:,1);
% source = stft(y,Fs);
% 假设这是0.1秒的音频文件
tune = [520 590 660 700 780 880 990];
[S,F,T] = stft(y,Fs,'Window',hamming(0.1*Fs,'periodic'),'OverlapLength',0);

[st,Fsst] = audioread('standard.wav');
st=st(:,1);
[Sst,Fst,Tst] = stft(st,Fsst,'Window',hamming(0.1*Fsst,'periodic'),'OverlapLength',0);

% [S,T,F] = tfrstft(y,Fs,'Window',hamming(0.1*Fs,'periodic'),'OverlapLength',0);
%figure;
%waterfall(Fst,Tst,abs(Sst(:,:))');
% figure;

flen=[-Fs/2+10:10:Fs/2];
flenst=[-Fsst/2+10:10:Fsst/2];
n=length(T); %音频时长，单位秒
nst=length(Tst);
A=zeros(n,1);
B=zeros(nst,1);
for i=1:n
    [pks,locs]=max(abs(S(:,i))');
    A(i)=abs(flen(locs));
end
for i=1:nst
    [pksst,locsst]=max(abs(Sst(:,i))');
    B(i)=abs(flenst(locs));
end

%figure
%plot(abs(Sst(Fsst/20+35,:)))


%do
for i=[2 7 72]
    if A(i)~=tune(1)
        for j=1:5
            S(:,i+j-2)=Sst(:,j);
        end
    end
end
%re
for i=[62 67]
    if A(i)~=tune(1)
        for j=1:5
            S(:,i+j-2)=Sst(:,10+j);
        end
    end
end
%mi
for i=[52 57]
    if A(i)~=tune(1)
        for j=1:5
            S(:,i+j-2)=Sst(:,20+j);
        end
    end
end
%fa
for i=[42 47]
    if A(i)~=tune(1)
        for j=1:5
            S(:,i+j-2)=Sst(:,30+j);
        end
    end
end
%so
for i=[12 17 32]
    if A(i)~=tune(1)
        for j=1:5
            S(:,i+j-2)=Sst(:,40+j);
        end
    end
end
%la
for i=[22 27]
    if A(i)~=tune(1)
        for j=1:5
            S(:,i+j-2)=Sst(:,50+j);
        end
    end
end
%xi
for i=[]
    if A(i)~=tune(1)
        for j=1:5
            S(:,i+j-2)=Sst(:,60+j);
        end
    end
end

%waterfall(F,T,abs(S(:,:))');

%2231 - 260 Fs=44100 Fs/20=2205
[ix,ti] = istft(S,Fs,'Window',hamming(0.1*Fs,'periodic'),'OverlapLength',0);
audiowrite('output.wav',ix,Fs);

% plot(flen,abs(S(:,6,1))')
% [pks,locs]=max(abs(S(:,6,1))');
% abs(flen(locs))
