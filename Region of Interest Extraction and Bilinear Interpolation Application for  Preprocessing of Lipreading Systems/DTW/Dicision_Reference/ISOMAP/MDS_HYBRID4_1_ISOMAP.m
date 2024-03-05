clear all; close all; clc;

% data_path=['D:/DOCUMENTS/00.DATA/CBNUDB/DATAS/DATA_ANALYSIS/'];
load 'D:/CBNU/HYBRID4_Shape_Diff_ROI1.mat'

% CVIData = [];
% sub_labels = [];
% word_labels = [];
% for label=1:7
%     file = fopen([data_path 'DATA_' num2str(label) '.txt']);
%     txt_data = textscan(file, '%d:%d:%d:%d', 'Delimiter', '\n', 'CollectOutput', true);
%     [row, ~] = size(txt_data{1});
%     for i=1:row
%         idx = txt_data{1}(i, :);
%         sub_labels = [sub_labels;idx(1,1)];
%         word_labels = [word_labels;label];
%         CVIData = [CVIData;datas{idx(1,1), idx(1,2)}{idx(1,3)}.full(idx(1,4), :)];
%     end
% end

% result = [];
% for K= 7:7
% for DIM = 3:3
% c_data = ISOMAP(CVIData', K);
% CVIData_ = c_data';
% figure(1)
% parallelcoords(CVIData_, 'group', word_labels)
% figure(2)
% scatter3(CVIData_(:,1), CVIData_(:,2), CVIData_(:,3),[], word_labels,'fill', 'MarkerEdgeColor','k')
% CVIData_ = c_data(1:DIM, :)';
% [SB SW] = FISHER_RATIO(sub_labels, CVIData_);
% FDR1 = [trace(SB), trace(SW), (trace(SB)/trace(SW))];
% 
% [SB SW] = FISHER_RATIO(word_labels, CVIData_);
% FDR2 = [trace(SB), trace(SW), (trace(SB)/trace(SW))];
% 
% result = [result;K, DIM, FDR1(1,3), FDR2(1,3), FDR2(1,3)/FDR1(1,3)]
% end
% end
tempdata = []; %기존의 데이터를 계산하기 편하도록 데이터를 재구성
label1 = [];
for word=1:10
    for sub=1:16
        [col, countcnt] = size(datas{sub, word});
        for count=1:countcnt
            [fno, ~] = size(datas{sub, word}{count}.speech_seg);
            for frame=1:fno
                tempdata = [tempdata;datas{sub, word}{count}.speech_seg(frame, :)];
                label1 = [label1;word, sub, count];
            end
        end
    end
end
c_data = [];
for word=1:10 %차원 축소
    [idx, ~] = find(label1(:, 1) == word);
    tmpp = ISOMAP(tempdata(idx, :)', 10);
    c_data = [c_data;tmpp(1:57, :)'];
end

% for word=1:2
%     test = [];
%     [idx, ~] = find(label1(:, 1) == ((word-1)*5)+1);
%     test = [test;tempdata(idx, :)];
%     [idx, ~] = find(label1(:, 1) == ((word-1)*5)+2);
%     test = [test;tempdata(idx, :)];
%     [idx, ~] = find(label1(:, 1) == ((word-1)*5)+3);
%     test = [test;tempdata(idx, :)];
%     [idx, ~] = find(label1(:, 1) == ((word-1)*5)+4);
%     test = [test;tempdata(idx, :)];
%     [idx, ~] = find(label1(:, 1) == ((word-1)*5)+5);
%     test = [test;tempdata(idx, :)];
%     tmpp = ISOMAP(test', 10);
%     c_data = [c_data;tmpp(1:57, :)'];
% end

datass = cell(16,10);
for word=1:10 % 차원 축소한 데이터 발화 데이터로 (오래걸림 그래서 저장)
    for sub=1:16
        countdata = cell(1,1);
        [col, countcnt] = size(datas{sub, word});
        for count=1:countcnt
            [idx, ~] = find(label1(:,1) == word & label1(:,2)==sub & label1(:,3)==count);
            countdata{count} = c_data(idx, :);
        end
        datass{sub, word} = countdata;
    end
end
% save D:/DOCUMENTS/00.DATA/MATLAB_DATA/DATAS/HYBRID4_ISOMAP_DATAS.mat datass
% load D:/DOCUMENTS/00.DATA/MATLAB_DATA/DATAS/HYBRID4_ISOMAP_DATAS.mat

for DIM=7:7 %차원이 7인 경우가 가장 좋아서
label = [];
inputdata = cell(1,1);
idx = 1;
for word=1:10
    for sub=1:16
        [col, countcnt] = size(datass{sub, word});
        for count=1:countcnt
            inputdata{idx} = datass{sub, word}{count}(:, 1:DIM);
            label = [label; word, sub, count];
            idx = idx+1;
        end
    end
end


% ['2nd step'] %DTW는 템플릿을 먼저 결정 (템플릿을 먼저 결정하는 부분)
cnt = length(inputdata);
k = 1;
for i = 1: cnt-1
    for j = i+1:cnt
        D(k) = dtw(inputdata{i}', inputdata{j}');
        k = k+1;
    end
end

opt1 = {'o', 'x','+','*','.'};
opt2 = {'b', 'g', 'r','c','m','k'};

% ['3rd step']
[Y,eigvals] = cmdscale(D);

figure(3);
for word = 1:10
    opt = [opt1{mod(word,5)+1} opt2{mod(word,6)+1}];
    idx = find(label(:, 1) == word);
    plot(Y(idx, 1), Y(idx, 2), opt);
    hold on;
end
grid on;

figure(4);
for sub = 1:16
    opt = [opt1{mod(sub,5)+1} opt2{mod(sub,6)+1}];
    idx = find(label(:, 2) == sub);
    plot(Y(idx, 1), Y(idx, 2), opt);
    hold on;
end
grid on;

% idx = label(:, 2);
% [SB SW] = FISHER_RATIO(idx, [Y(:,1),Y(:,2)]);
% FDR3 = [trace(SB), trace(SW), (trace(SB)/trace(SW))];
% idx = label(:, 1);
% [SB SW] = FISHER_RATIO(idx, [Y(:,1),Y(:,2)]);
% FDR4 = [trace(SB), trace(SW), (trace(SB)/trace(SW))];

template = []; % 템플릿 결정
for word = 1:10
    idx = find(label(:, 1) == word);
    c = mean([Y(idx, 1), Y(idx, 2)]);
    [row, ~] = size(idx);
    d = sqrt((Y(idx,1)-repmat(c(1,1),row, 1)).^2+((Y(idx,2)-repmat(c(1,2),row, 1)).^2));
    [minval, minidx] = min(d);
    template = [template ; label(idx(minidx), :)];
end

inputdata = cell(10, 1);
referClass = cell(10, 1);
labels = cell(10,1);
for word=1:10
    worddata = cell(1,1);
    idx = 1;
    label1 = [];
    for sub=1:16
        [col, countcnt1] = size(datass{sub, word});
        countcnt = countcnt1;
        for count=1:countcnt
            worddata{idx} = datass{sub, word}{count}(:, 1:DIM);
            idx = idx+1;
            label1 = [label1; sub, count];
            if template(word, 2) == sub && template(word,3) == count
                referClass{word} = datass{sub, word}{count}(:, 1:DIM);
            end
        end
    end
    inputdata{word} = worddata;
    labels{word} = label1;
end

result = zeros(10,10); % 인식률 계산
recog_result = [];
sub_results = cell(16, 1);
for sub=1:16
    sub_results{sub} = zeros(10,10);
end
for word= 1:10
    [col, countcnt] = size(inputdata{word});
    for count=1:countcnt
        compDtw(1)  = dtw(referClass{1}', inputdata{word}{count}');
        compDtw(2)  = dtw(referClass{2}', inputdata{word}{count}');
        compDtw(3)  = dtw(referClass{3}', inputdata{word}{count}');
        compDtw(4)  = dtw(referClass{4}', inputdata{word}{count}');
        compDtw(5)  = dtw(referClass{5}', inputdata{word}{count}');
        compDtw(6)  = dtw(referClass{6}', inputdata{word}{count}');
        compDtw(7)  = dtw(referClass{7}', inputdata{word}{count}');
        compDtw(8)  = dtw(referClass{8}', inputdata{word}{count}');
        compDtw(9)  = dtw(referClass{9}', inputdata{word}{count}');
        compDtw(10)  = dtw(referClass{10}', inputdata{word}{count}');
        [xx, recResult]=min(compDtw);
        result(word,recResult) = result(word,recResult) +1;
        label = labels{word}(count, :);
        sub_results{label(1, 1)}(word, recResult) = sub_results{label(1, 1)}(word, recResult) + 1;
    end
    recog_result = [recog_result; result(word, word), countcnt, result(word, word)./countcnt];
end
results.confu_mat = result;
results.recog_rate = recog_result;

[DIM,FDR3(1,3), FDR4(1,3), FDR4(1,3)/FDR3(1,3), mean(recog_result)]
end
% save D:/DOCUMENTS/00.DATA/MATLAB_DATA/DATAS/HYBRID4_ISOMAP_RESULTS.mat datass D label template