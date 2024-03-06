function [ datas ] = MinMax( datas, range )
    switch(range)
        case 'RAW'
            for sub=1:16
                for word=1:10
                    [col, countcnt] = size(datas{sub, word});
                    for(count=1:countcnt)
                        max_v = max(datas{sub, word}{count}.full);
                        min_v = min(datas{sub, word}{count}.full);
                        a = (datas{sub, word}{count}.full-min_v)./(max_v-min_v);
                        datas{sub, word}{count}.full = a;
                        clear a;
                        max_v = max(datas{sub, word}{count}.speech_seg);
                        min_v = min(datas{sub, word}{count}.speech_seg);
                        a = (datas{sub, word}{count}.speech_seg-min_v)./(max_v-min_v);
                        datas{sub, word}{count}.speech_seg = a;
                        clear a;
                    end
                end
            end
        case 'AE'
            for sub=1:16
                for word=1:10
                    [col, countcnt] = size(datas{sub, word});
                    for(count=1:countcnt)
                        max_v = max(datas{sub, word}{count});
                        min_v = min(datas{sub, word}{count});
                        datas{sub, word}{count} = (datas{sub, word}{count}-min_v)./(max_v-min_v);
                        clear a;
                    end
                end
            end
        case 'ECT'
            for gridno = 1:10
                for subject = 1:16
                    for word = 1:10
                        [col, countcnt] = size(datas{gridno, subject, word});
                        for(count=1:countcnt)
%                             max_v = max(datas{gridno, subject, word}{count}.full.gray);
%                             min_v = min(datas{gridno, subject, word}{count}.full.gray);
%                             datas{gridno, subject, word}{count}.full.gray = ...
%                                 (datas{gridno, subject, word}{count}.full.gray-min_v)./(max_v-min_v);
%                             max_v = max(datas{gridno, subject, word}{count}.full.sobel);
%                             min_v = min(datas{gridno, subject, word}{count}.full.sobel);
%                             datas{gridno, subject, word}{count}.full.sobel = ...
%                                 (datas{gridno, subject, word}{count}.full.sobel-min_v)./(max_v-min_v);
%                             max_v = max(datas{gridno, subject, word}{count}.full.of);
%                             min_v = min(datas{gridno, subject, word}{count}.full.of);
%                             datas{gridno, subject, word}{count}.full.of = ...
%                                 (datas{gridno, subject, word}{count}.full.of-min_v)./(max_v-min_v);
%                             datas{gridno, subject, word}{count}.full.of(find(isnan(datas{gridno, subject, word}{count}.full.of) == 1)) = 0;
%                             max_v = max(datas{gridno, subject, word}{count}.full.diff_gray);
%                             min_v = min(datas{gridno, subject, word}{count}.full.diff_gray);
%                             datas{gridno, subject, word}{count}.full.diff_gray = ...
%                                 (datas{gridno, subject, word}{count}.full.diff_gray-min_v)./(max_v-min_v);
% 
%                             max_v = max(datas{gridno, subject, word}{count}.img_seg.gray);
%                             min_v = min(datas{gridno, subject, word}{count}.img_seg.gray);
%                             datas{gridno, subject, word}{count}.img_seg.gray = ...
%                                 (datas{gridno, subject, word}{count}.img_seg.gray-min_v)./(max_v-min_v);
%                             max_v = max(datas{gridno, subject, word}{count}.img_seg.sobel);
%                             min_v = min(datas{gridno, subject, word}{count}.img_seg.sobel);
%                             datas{gridno, subject, word}{count}.img_seg.sobel = ...
%                                 (datas{gridno, subject, word}{count}.img_seg.sobel-min_v)./(max_v-min_v);
%                             max_v = max(datas{gridno, subject, word}{count}.img_seg.of);
%                             min_v = min(datas{gridno, subject, word}{count}.img_seg.of);
%                             datas{gridno, subject, word}{count}.img_seg.of = ...
%                                 (datas{gridno, subject, word}{count}.img_seg.of-min_v)./(max_v-min_v);
%                             datas{gridno, subject, word}{count}.img_seg.of(find(isnan(datas{gridno, subject, word}{count}.img_seg.of) == 1)) = 0;
%                             max_v = max(datas{gridno, subject, word}{count}.img_seg.diff_gray);
%                             min_v = min(datas{gridno, subject, word}{count}.img_seg.diff_gray);
%                             datas{gridno, subject, word}{count}.img_seg.diff_gray = ...
%                                 (datas{gridno, subject, word}{count}.img_seg.diff_gray-min_v)./(max_v-min_v);
                            max_v = max(datas{gridno, subject, word}{count}.diff_gray);
                            min_v = min(datas{gridno, subject, word}{count}.diff_gray);
                            datas{gridno, subject, word}{count}.diff_gray = ...
                                (datas{gridno, subject, word}{count}.diff_gray-min_v)./(max_v-min_v);
                            
                            
%                             max_v = max(datas{gridno, subject, word}{count}.speech_seg.gray);
%                             min_v = min(datas{gridno, subject, word}{count}.speech_seg.gray);
%                             datas{gridno, subject, word}{count}.speech_seg.gray = ...
%                                 (datas{gridno, subject, word}{count}.speech_seg.gray-min_v)./(max_v-min_v);
%                             max_v = max(datas{gridno, subject, word}{count}.speech_seg.sobel);
%                             min_v = min(datas{gridno, subject, word}{count}.speech_seg.sobel);
%                             datas{gridno, subject, word}{count}.speech_seg.sobel = ...
%                                 (datas{gridno, subject, word}{count}.speech_seg.sobel-min_v)./(max_v-min_v);
%                             max_v = max(datas{gridno, subject, word}{count}.speech_seg.of);
%                             min_v = min(datas{gridno, subject, word}{count}.speech_seg.of);
%                             datas{gridno, subject, word}{count}.speech_seg.of = ...
%                                 (datas{gridno, subject, word}{count}.speech_seg.of-min_v)./(max_v-min_v);
%                             datas{gridno, subject, word}{count}.speech_seg.of(find(isnan(datas{gridno, subject, word}{count}.speech_seg.of) == 1)) = 0;
%                             max_v = max(datas{gridno, subject, word}{count}.speech_seg.diff_gray);
%                             min_v = min(datas{gridno, subject, word}{count}.speech_seg.diff_gray);
%                             datas{gridno, subject, word}{count}.speech_seg.diff_gray = ...
%                                 (datas{gridno, subject, word}{count}.speech_seg.diff_gray-min_v)./(max_v-min_v);
                        end
                    end
                end
            end
        case 'OF'
            for gridno=1:10
                for subject = 1:16
                    for word = 1:10
                        [col, countcnt] = size(datas{gridno, subject, word});
                        for(count=1:countcnt)
                            max_v = max(datas{gridno, subject, word}{count}.full);
                            min_v = min(datas{gridno, subject, word}{count}.full);
                            datas{gridno, subject, word}{count}.full = ...
                                (datas{gridno, subject, word}{count}.full-min_v)./(max_v-min_v);
                            datas{gridno, subject, word}{count}.full(find(isnan(datas{gridno, subject, word}{count}.full) == 1)) = 0;

                            max_v = max(datas{gridno, subject, word}{count}.img_seg);
                            min_v = min(datas{gridno, subject, word}{count}.img_seg);
                            datas{gridno, subject, word}{count}.img_seg = ...
                                (datas{gridno, subject, word}{count}.img_seg-min_v)./(max_v-min_v);
                            datas{gridno, subject, word}{count}.img_seg(find(isnan(datas{gridno, subject, word}{count}.img_seg) == 1)) = 0;
                        
                            max_v = max(datas{gridno, subject, word}{count}.speech_seg);
                            min_v = min(datas{gridno, subject, word}{count}.speech_seg);
                            datas{gridno, subject, word}{count}.speech_seg = ...
                                (datas{gridno, subject, word}{count}.speech_seg-min_v)./(max_v-min_v);
                            datas{gridno, subject, word}{count}.speech_seg(find(isnan(datas{gridno, subject, word}{count}.speech_seg) == 1)) = 0;
                        end
                    end
                end
            end
        case 'DCT'
            for gridno = 1:10
                for subject = 1:16
                    for word = 1:10
                        [col, countcnt] = size(datas{gridno, subject, word});
                        for(count=1:countcnt)
                            max_v = max(datas{gridno, subject, word}{count}.full.dct);
                            min_v = min(datas{gridno, subject, word}{count}.full.dct);
                            datas{gridno, subject, word}{count}.full.dct = ...
                                (datas{gridno, subject, word}{count}.full.dct-min_v)./(max_v-min_v);
                            max_v = max(datas{gridno, subject, word}{count}.full.diff_dct);
                            min_v = min(datas{gridno, subject, word}{count}.full.diff_dct);
                            datas{gridno, subject, word}{count}.full.diff_dct = ...
                                (datas{gridno, subject, word}{count}.full.diff_dct-min_v)./(max_v-min_v);

                            max_v = max(datas{gridno, subject, word}{count}.img_seg.dct);
                            min_v = min(datas{gridno, subject, word}{count}.img_seg.dct);
                            datas{gridno, subject, word}{count}.img_seg.dct = ...
                                (datas{gridno, subject, word}{count}.img_seg.dct-min_v)./(max_v-min_v);
                            max_v = max(datas{gridno, subject, word}{count}.img_seg.diff_dct);
                            min_v = min(datas{gridno, subject, word}{count}.img_seg.diff_dct);
                            datas{gridno, subject, word}{count}.img_seg.diff_dct = ...
                                (datas{gridno, subject, word}{count}.img_seg.diff_dct-min_v)./(max_v-min_v);
                            
                            max_v = max(datas{gridno, subject, word}{count}.speech_seg.dct);
                            min_v = min(datas{gridno, subject, word}{count}.speech_seg.dct);
                            datas{gridno, subject, word}{count}.speech_seg.dct = ...
                                (datas{gridno, subject, word}{count}.speech_seg.dct-min_v)./(max_v-min_v);
                            max_v = max(datas{gridno, subject, word}{count}.speech_seg.diff_dct);
                            min_v = min(datas{gridno, subject, word}{count}.speech_seg.diff_dct);
                            datas{gridno, subject, word}{count}.speech_seg.diff_dct = ...
                                (datas{gridno, subject, word}{count}.speech_seg.diff_dct-min_v)./(max_v-min_v);
                        end
                    end
                end
            end
        case 'SHAPE'
            for subject = 1:16
                for word = 1:10
                    [col, countcnt] = size(datas{subject, word}.full);
                    for(count=1:countcnt)
                        max_v = max(datas{subject, word}.full{count});
                        min_v = min(datas{subject, word}.full{count});
                        datas{subject, word}.full{count} = ...
                            (datas{subject, word}.full{count}-min_v)./(max_v-min_v);
                        
                        max_v = max(datas{subject, word}.img_seg{count});
                        min_v = min(datas{subject, word}.img_seg{count});
                        datas{subject, word}.img_seg{count} = ...
                            (datas{subject, word}.img_seg{count}-min_v)./(max_v-min_v);
                        
                        max_v = max(datas{subject, word}.speech_seg{count});
                        min_v = min(datas{subject, word}.speech_seg{count});
                        datas{subject, word}.speech_seg{count} = ...
                            (datas{subject, word}.speech_seg{count}-min_v)./(max_v-min_v);
                        
                        max_v = max(datas{subject, word}.full_diff{count});
                        min_v = min(datas{subject, word}.full_diff{count});
                        datas{subject, word}.full_diff{count} = ...
                            (datas{subject, word}.full_diff{count}-min_v)./(max_v-min_v);
                        
                        max_v = max(datas{subject, word}.img_seg_diff{count});
                        min_v = min(datas{subject, word}.img_seg_diff{count});
                        datas{subject, word}.img_seg_diff{count} = ...
                            (datas{subject, word}.img_seg_diff{count}-min_v)./(max_v-min_v);
                        
                        max_v = max(datas{subject, word}.speech_seg_diff{count});
                        min_v = min(datas{subject, word}.speech_seg_diff{count});
                        datas{subject, word}.speech_seg_diff{count} = ...
                            (datas{subject, word}.speech_seg_diff{count}-min_v)./(max_v-min_v);
                    end
                end
            end
        case 'LBP'
            for gridno = 1:10
                for subject = 1:16
                    for word = 1:10
                        [col, countcnt] = size(datas{gridno, subject, word});
                        for(count=1:countcnt)
                            max_v = max(datas{gridno, subject, word}{count}.speech_seg);
                            min_v = min(datas{gridno, subject, word}{count}.speech_seg);
                            datas{gridno, subject, word}{count}.speech_seg = ...
                                (datas{gridno, subject, word}{count}.speech_seg-min_v)./(max_v-min_v);
                        end
                    end
                end
            end
        case 'OF'
            for gridno = 1:10
                for subject = 1:16
                    for word = 1:10
                        [col, countcnt] = size(datas{gridno, subject, word});
                        for(count=1:countcnt)
                            max_v = max(datas{gridno, subject, word}{count}.speech_seg);
                            min_v = min(datas{gridno, subject, word}{count}.speech_seg);
                            datas{gridno, subject, word}{count}.speech_seg = ...
                                (datas{gridno, subject, word}{count}.speech_seg-min_v)./(max_v-min_v);
                        end
                    end
                end
            end
        otherwise
    end
end

