function obtained_mark=evaluate_single_omr(answer_image,soln,n_question)
     ifl=answer_image;
     n=n_question;
            real_ans=soln;
            marks=0;
            for j=1:5
                y_ans=round(linspace(1484,2685,11));  % center positions in y-axis
                x_ans=round(linspace(341+420*(j-1),521+420*(j-1),4)); % center positions in x-axis for all columns
                for i=1:10
                    valid_fill = 0;    % ← split into two counters
                    stray_fill = 0;
                    flag = 0;
                    if i<=5
                        for k=1:4
                            s = sum(sum(ifl(y_ans(i)-20:y_ans(i)+20, x_ans(k)-20:x_ans(k)+20)));
                            if s > 1000       % ← two thresholds now
                                valid_fill = valid_fill + 1;
                                if real_ans((j-1)*10+i) == k
                                    flag = 1;
                                end
                            elseif s > 100
                                stray_fill = stray_fill + 1;
                            end
                        end
                    else
                        for k=1:4
                            s = sum(sum(ifl(y_ans(i+1)-20:y_ans(i+1)+20, x_ans(k)-20:x_ans(k)+20)));
                            if s > 1000
                                valid_fill = valid_fill + 1;
                                if real_ans((j-1)*10+i) == k
                                    flag = 1;
                                end
                            elseif s > 110
                                stray_fill = stray_fill + 1;
                            end
                        end
                    end
                    if valid_fill==1 && flag==1 && stray_fill==0  % ← 3 conditions now
                        marks=marks+1;
                    end
                    if n==((j-1)*10+i)   % ← this line stays exactly the same
                        break;
                    end
                end
                if n==((j-1)*10+i)
                    break;
                end
            end
    obtained_mark=marks;
end