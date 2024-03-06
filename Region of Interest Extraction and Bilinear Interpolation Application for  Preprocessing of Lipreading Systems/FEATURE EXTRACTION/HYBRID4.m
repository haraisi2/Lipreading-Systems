clc; clear all;

load 'D:/CBNU/AppearanceData/Nearest/APPEARANCE_Dif_ROI1_nearest'
datas = Normalization(datas, 'ECT', 'MIN-MAX');
gray_data = Normalization(datas, 'UTTERANCE', 'MEAN');
% datas = Normalization(datas, 'ECT', 'MIN-MAX');
% gray_data = Normalization(datas, 'UTTERANCE', 'MEAN');

load 'D:/CBNU/SHAPE_DATA.mat'
datas = Normalization(datas, 'SHAPE', 'MIN-MAX');
shape_data = ShapeMean(datas, 'UTTERANCE');

datas = cell(16, 10);
reference = cell(10, 1);
for word=1:10
    for sub=1:16
        worddata = cell(1,1);
        [col, countcnt] = size(gray_data{6, sub, word});
%         for count=1:countcnt
%             [frame1, ~] = size(shape_data{sub, word}.full{count});
%             [frame2, ~] = size(gray_data{6, sub, word}{count}.full.gray);
%             [frame3, ~] = size(gray_data{4, sub, word}{count}.full.diff_gray);
%             if frame2-frame3 ~= 1
%                 disp ['error' num2str(sub) num2str(word) num2str(count)]
%             end
%             temp1 = 0;
%             temp2 = 0;
%             if frame2-frame1 == 1
%                 
%             elseif frame2-frame1 > 1
%                 temp1 = frame2-frame1-1;
%             elseif frame2-frame1 == 0
%                 temp2 = 1;
%             else
%                 temp2 = frame1 - frame2+1;
%             end
%             ttt = zeros(1, 5);
%             ttt = [ttt; shape_data{sub, word}.full{count}(1:end-temp2,[1,3,4,5,6])];
%             ttt1 = zeros(1,16);
%             ttt1 = [ttt1; gray_data{4, sub, word}{count}.full.diff_gray(1:end-temp1, :)];
%             temp = [ttt,ttt1];
%             worddata{count}.full = temp;
%         end
%         for count=1:countcnt
%             [frame1, ~] = size(shape_data{sub, word}.speech_seg{count});
%             [frame2, ~] = size(gray_data{6, sub, word}{count}.speech_seg.gray);
%             [frame3, ~] = size(gray_data{4, sub, word}{count}.speech_seg.diff_gray);
%             if frame2-frame3 ~= 1
%                 disp ['error' num2str(sub) num2str(word) num2str(count)]
%             end
%             temp1 = 0;
%             temp2 = 0;
%             if frame2-frame1 == 1
%                 
%             elseif frame2-frame1 > 1
%                 temp1 = frame2-frame1-1;
%             elseif frame2-frame1 == 0
%                 temp2 = 1;
%             else
%                 temp2 = frame1 - frame2+1;
%             end
%             ttt = zeros(1, 5);
%             ttt = [ttt; shape_data{sub, word}.speech_seg{count}(1:end-temp2,[1,3,4,5,6])];
%             ttt1 = zeros(1,16);
%             ttt1 = [ttt1; gray_data{4, sub, word}{count}.speech_seg.diff_gray(1:end-temp1, :)];
%             temp = [ttt,ttt1];
%             worddata{count}.speech_seg = temp;
%         end
        for count=1:countcnt
            [frame1, ~] = size(shape_data{sub, word}.speech_seg{count});
            [frame2, ~] = size(gray_data{6, sub, word}{count}.gray);
            [frame3, ~] = size(gray_data{4, sub, word}{count}.diff_gray);
            if frame2-frame3 ~= 1
                disp ['error' num2str(sub) num2str(word) num2str(count)]
            end
            temp1 = 0;
            temp2 = 0;
            if frame2-frame1 == 1
                
            elseif frame2-frame1 > 1
                temp1 = frame2-frame1-1;
            elseif frame2-frame1 == 0
                temp2 = 1;
            else
                temp2 = frame1 - frame2+1;
            end
            ttt = zeros(1, 5);
            ttt = [ttt; shape_data{sub, word}.speech_seg{count}(1:end-temp2,[1,3,4,5,6])];
            ttt1 = zeros(1,16);
            ttt1 = [ttt1; gray_data{4, sub, word}{count}.diff_gray(1:end-temp1, :)];
            temp = [ttt,ttt1];
            worddata{count}.speech_seg = temp;
        end
        datas{sub, word} = worddata;
    end
end

save D:/CBNU/Hybrid/HYBRID4_DATA_ROI1_nearest.mat datas;
