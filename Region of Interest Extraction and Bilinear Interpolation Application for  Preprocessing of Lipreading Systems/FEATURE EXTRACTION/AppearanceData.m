clc; clear all;

raw_data_path=['D:/Development/00.STUDIES/00.Experiment/Matlab/2017/MainExperiment/DATA/RAW_DATA/'];
label_data_path=['D:/Development/00.STUDIES/00.Experiment/Matlab/2017/MainExperiment/DATA/LABEL_DATA/'];

datas = cell(10, 10, 10);
for gridno=1:10
    for subject=1:16
        [gridno subject]
        graydata = load([raw_data_path 'GRAY_FEATURES_' num2str(subject) '_' num2str(gridno) '.txt']);
        sobeldata = load([raw_data_path 'SOBEL_FEATURES_' num2str(subject) '_' num2str(gridno) '.txt']);
        ofdata = load([raw_data_path 'OPTICAL_FLOW_FEATURES_' num2str(subject) '_' num2str(gridno) '.txt']);
        labeldata = load([[label_data_path 'label_' num2str(subject) '.txt']]); %match1~16 가져온다
        for word=1:10
            utterance_data = cell(1,1);
            for count=1:30
                [frameidxes, col] = find(graydata(:, 1)==word & graydata(:,2)==count);
                [row, col] = size(frameidxes);
                if row == 0
                    continue;
                end
                full_grayfeature = [];
                full_sobelfeature = [];
                full_offeature = [];
                img_seg_grayfeature = [];
                img_seg_sobelfeature = [];
                img_seg_offeature = [];
                speech_seg_grayfeature = [];
                speech_seg_sobelfeature = [];
                speech_seg_offeature = [];
                for frameno=1:row
                    [frameidx, col] = find(graydata(:, 1)==word & graydata(:,2)==count & graydata(:,3)==frameno-1);
                    full_grayfeature = [full_grayfeature ; graydata(frameidx, 4:gridno*gridno+3)];
                    full_sobelfeature = [full_sobelfeature ; sobeldata(frameidx, 4:gridno*gridno+3)];
                    [labelidx, col] = find(labeldata(:, 1)==word & labeldata(:,2)==count & labeldata(:,3)==frameno); % 이런 방식으로 맞춰야한다.
                    if labeldata(labelidx, 4) == 1
                        img_seg_grayfeature = [img_seg_grayfeature ; graydata(frameidx, 4:gridno*gridno+3)];
                        img_seg_sobelfeature = [img_seg_sobelfeature ; sobeldata(frameidx, 4:gridno*gridno+3)];
                    end
                    if labeldata(labelidx, 5) == 1
                        speech_seg_grayfeature = [speech_seg_grayfeature ; graydata(frameidx, 4:gridno*gridno+3)];
                        speech_seg_sobelfeature = [speech_seg_sobelfeature ; sobeldata(frameidx, 4:gridno*gridno+3)];
                    end
                end
                utterance_data{count}.full.gray = full_grayfeature;
                utterance_data{count}.full.sobel = full_sobelfeature;
                utterance_data{count}.img_seg.gray = img_seg_grayfeature;
                utterance_data{count}.img_seg.sobel = img_seg_sobelfeature;
                utterance_data{count}.speech_seg.gray = speech_seg_grayfeature;
                utterance_data{count}.speech_seg.sobel = speech_seg_sobelfeature;
                
                [frameidxes, col] = find(ofdata(:, 1)==word & ofdata(:,2)==count);
                [row, col] = size(frameidxes);
                if row == 0
                    continue;
                end
                for frameno=1:row
                    [frameidx, col] = find(ofdata(:, 1)==word & ofdata(:,2)==count & ofdata(:,3)==frameno);
                    full_offeature = [full_offeature ; ofdata(frameidx, 4:(gridno*gridno*2)+3)];
                    [labelidx, col] = find(labeldata(:, 1)==word & labeldata(:,2)==count & labeldata(:,3)==frameno);
                    if labeldata(labelidx, 4) == 1
                        img_seg_offeature = [img_seg_offeature ; ofdata(frameidx, 4:(gridno*gridno*2)+3)];
                    end
                    if labeldata(labelidx, 5) == 1
                        speech_seg_offeature = [speech_seg_offeature ; ofdata(frameidx, 4:(gridno*gridno*2)+3)];
                    end
                end
                utterance_data{count}.full.of = full_offeature;
                utterance_data{count}.img_seg.of = img_seg_offeature;
                utterance_data{count}.speech_seg.of = speech_seg_offeature;
            end
            datas{gridno, subject, word} = utterance_data;
        end
    end
end

for gridno=1:10
    for subject=1:16
        for word=1:10
            [aa, cnt] = size(datas{gridno, subject, word});
            for count=1:cnt
                [row, col] = size(datas{gridno, subject, word}{count}.full.gray);
                temp = [];
                for frame=1:row-1
                    temp = [temp; datas{gridno, subject, word}{count}.full.gray(frame, :)-datas{gridno, subject, word}{count}.full.gray(frame+1, :)];
                end
                datas{gridno, subject, word}{count}.full.diff_gray = temp;
                
                [row, col] = size(datas{gridno, subject, word}{count}.img_seg.gray);
                temp = [];
                for frame=1:row-1
                    temp = [temp; datas{gridno, subject, word}{count}.img_seg.gray(frame, :)-datas{gridno, subject, word}{count}.img_seg.gray(frame+1, :)];
                end
                datas{gridno, subject, word}{count}.img_seg.diff_gray = temp;
                
                [row, col] = size(datas{gridno, subject, word}{count}.speech_seg.gray);
                temp = [];
                for frame=1:row-1
                    temp = [temp; datas{gridno, subject, word}{count}.speech_seg.gray(frame, :)-datas{gridno, subject, word}{count}.speech_seg.gray(frame+1, :)];
                end
                datas{gridno, subject, word}{count}.speech_seg.diff_gray = temp;
            end
        end
    end
end

save ./MainExperiment/DATA/APPEARANCE_DATA.mat datas -v7.3