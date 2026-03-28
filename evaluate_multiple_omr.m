function [roll_array,code_array,marks_array,reject]=evaluate_multiple_omr(f,soln,n_question,given_code)
    d=ls(f);  % getting all file names from the given directory
    d(1,:)=[]; % In many operating systems, first two items returned by a directory listing are . and .. (references to current and parent folders). 
    d(1,:)=[]; % These two lines delete those entries so the code only looks at actual image files.   
    s=size(d); % counting number of files
    reject=0;  % track invalid sheets
    roll_array=zeros(s(1),1); % arrays created, sized to number of files
    code_array=zeros(s(1),1); % s(1) represents the total number of files.
    marks_array=zeros(s(1),1);
    for k_index=1:size(d) % indexing files
        im=imread(fullfile(f,d(k_index,:))); % Taking image from the directory
        % f: The folder name,  d(k_index,:): specific image file name
        % fullfile(f, ...): a "smart" folder combiner. If folder is C:\OMR\Scans and file is img.jpg, fullfile joins them correctly into C:\OMR\Scans\img.jpg
        answer_image=img_processed(im);
        [roll,roll_validity]=get_roll(answer_image);
        [code,code_validity]=get_code(answer_image);
        if ((code_validity==1) && (roll_validity==1) && (code==given_code))
            roll_array(k_index-reject)=roll;
            code_array(k_index-reject)=code;
            marks_array(k_index-reject)=evaluate_single_omr(answer_image,soln,n_question)
        else
            % ignoring when roll or code is invalid
            roll_array(k_index-reject)=[];
            code_array(k_index-reject)=[];
            marks_array(k_index-reject)=[];
            reject=reject+1; % counting rejected scripts
        end
    end
end