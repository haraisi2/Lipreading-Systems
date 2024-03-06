function [result] = ShapeMean(datas, range )
    result = cell(16,10);
    switch (range)
        case 'UTTERANCE'
            for subject = 1:16
                for word = 1:10
                    [col, countcnt] = size(datas{subject, word}.full);
                    for(count=1:countcnt)
                        mean_mat = mean(datas{subject, word}.full{count});
                        std_mat = std(datas{subject, word}.full{count});
                        datas{subject, word}.full{count} = ...
                            MeanNormalization(datas{subject, word}.full{count}, mean_mat, std_mat);
                        
                        mean_mat = mean(datas{subject, word}.img_seg{count});
                        std_mat = std(datas{subject, word}.img_seg{count});
                        datas{subject, word}.img_seg{count} = ...
                            MeanNormalization(datas{subject, word}.img_seg{count}, mean_mat, std_mat);
                        
                        mean_mat = mean(datas{subject, word}.speech_seg{count});
                        std_mat = std(datas{subject, word}.speech_seg{count});
                        datas{subject, word}.speech_seg{count} = ...
                            MeanNormalization(datas{subject, word}.speech_seg{count}, mean_mat, std_mat);
                        
                        mean_mat = mean(datas{subject, word}.full_diff{count});
                        std_mat = std(datas{subject, word}.full_diff{count});
                        datas{subject, word}.full_diff{count} = ...
                            MeanNormalization(datas{subject, word}.full_diff{count}, mean_mat, std_mat);
                        
                        mean_mat = mean(datas{subject, word}.img_seg_diff{count});
                        std_mat = std(datas{subject, word}.img_seg_diff{count});
                        datas{subject, word}.img_seg_diff{count} = ...
                            MeanNormalization(datas{subject, word}.img_seg_diff{count}, mean_mat, std_mat);
                        
                        mean_mat = mean(datas{subject, word}.speech_seg_diff{count});
                        std_mat = std(datas{subject, word}.speech_seg_diff{count});
                        datas{subject, word}.speech_seg_diff{count} = ...
                            MeanNormalization(datas{subject, word}.speech_seg_diff{count}, mean_mat, std_mat);
                    end
                end
            end
        case 'SUBJECT'
            for subject = 1:16
                non_seg_data = [];
                img_seg_data = [];
                speech_seg_data = [];
                for word = 1:10
                    [col, countcnt] = size(datas{subject, word}.full);
                    for(count=1:countcnt)
                        non_seg_data = [non_seg_data; datas{subject, word}.full{count}];
                        img_seg_data = [img_seg_data; datas{subject, word}.img_seg{count}];
                        speech_seg_data = [speech_seg_data; datas{subject, word}.speech_seg{count}];
                    end
                end

                for word = 1:10
                    [col, countcnt] = size(datas{subject, word}.full);
                    for(count=1:countcnt)
                        datas{subject, word}.full{count} = ...
                            MeanNormalization(datas{subject, word}.full{count}, mean(non_seg_data), std(non_seg_data));
                        datas{subject, word}.img_seg{count} = ...
                            MeanNormalization(datas{subject, word}.img_seg{count}, mean(img_seg_data), std(img_seg_data));
                        datas{subject, word}.speech_seg{count} = ...
                            MeanNormalization(datas{subject, word}.speech_seg{count}, mean(speech_seg_data), std(speech_seg_data));
                    end
                end
            end
        case 'WORD'
            for word = 1:10
                non_seg_data = [];
                img_seg_data = [];
                speech_seg_data = [];
                for subject = 1:16
                    [col, countcnt] = size(datas{subject, word}.full);
                    for(count=1:countcnt)
                        non_seg_data = [non_seg_data; datas{subject, word}.full{count}];
                        img_seg_data = [img_seg_data; datas{subject, word}.img_seg{count}];
                        speech_seg_data = [speech_seg_data; datas{subject, word}.speech_seg{count}];
                    end
                end

                for subject = 1:16
                    [col, countcnt] = size(datas{subject, word}.full);
                    for(count=1:countcnt)
                        datas{subject, word}.full{count} = ...
                            MeanNormalization(datas{subject, word}.full{count}, mean(non_seg_data), std(non_seg_data));
                        datas{subject, word}.img_seg{count} = ...
                            MeanNormalization(datas{subject, word}.img_seg{count}, mean(img_seg_data), std(img_seg_data));
                        datas{subject, word}.speech_seg{count} = ...
                            MeanNormalization(datas{subject, word}.speech_seg{count}, mean(speech_seg_data), std(speech_seg_data));
                    end
                end
            end
        case 'ALL'
            non_seg_data = [];
            img_seg_data = [];
            speech_seg_data = [];
            for subject = 1:16
                for word = 1:10
                    [col, countcnt] = size(datas{subject, word}.full);
                    for(count=1:countcnt)
                        non_seg_data = [non_seg_data; datas{subject, word}.full{count}];
                        img_seg_data = [img_seg_data; datas{subject, word}.img_seg{count}];
                        speech_seg_data = [speech_seg_data; datas{subject, word}.speech_seg{count}];
                    end
                end
            end
            for subject = 1:16    
                for word = 1:10
                    [col, countcnt] = size(datas{subject, word}.full);
                    for(count=1:countcnt)
                        datas{subject, word}.full{count} = ...
                            MeanNormalization(datas{subject, word}.full{count}, mean(non_seg_data), std(non_seg_data));

                        datas{subject, word}.img_seg{count} = ...
                            MeanNormalization(datas{subject, word}.img_seg{count}, mean(img_seg_data), std(img_seg_data));

                        datas{subject, word}.speech_seg{count} = ...
                            MeanNormalization(datas{subject, word}.speech_seg{count}, mean(speech_seg_data), std(speech_seg_data));
                    end
                end
            end
    end
    result = datas; 
end

function [ result ] = MeanNormalization( data, mean_data, std_data )
mean_mat = repmat(mean_data, [size(data, 1), 1]);
std_mat = repmat(std_data, [size(data, 1), 1]);
result = (data-mean_mat)./std_mat;
end

