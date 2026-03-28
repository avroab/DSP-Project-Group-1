function [code,validity]=get_code(answer_image)
    ifl=answer_image;
    y_code = round(linspace(704,1244,10));
    x_code = round(linspace(941,1061,3));
    code=0;
    validity=1;
    for j=1:3
        fill=0;  %Resets a counter to track how many bubbles are filled in the current column.
        fill_index=0;  %Resets a variable to remember which row (0–9) was filled.
        for i=1:10
            s = sum(sum(ifl(y_code(i)-20:y_code(i)+20, x_code(j)-20:x_code(j)+20)));
            if s>1000
                fill=fill+1; % counts number of filled circles in a column
                fill_index=i; % reconds filled index
            end
        end
        if fill==1
                code=code*10+mod(fill_index,10);
        else
            validity=0;
        end
    end
end